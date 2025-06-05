import Flutter
import UIKit
import GooglePlaces

public class PlacePickerPlusPlugin: NSObject, FlutterPlugin, GMSAutocompleteViewControllerDelegate {
  var result: FlutterResult?
    
  let filterTypes: [String: GMSPlacesAutocompleteTypeFilter] = [
      "address": .address,
      "cities": .city,
      "region": .region,
      "geocode": .geocode,
      "establishment": .establishment
  ]

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "place_picker_plus", binaryMessenger: registrar.messenger())
    let instance = PlacePickerPlusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    self.result = result
    switch call.method {
      case "initialize":
          guard let args = call.arguments as? [String: Any],
                let apiKey = args["iosApiKey"] as? String else {
              result(FlutterError(code: "API_KEY_ERROR", message: "Missing iOS API Key", details: nil))
              return
          }
          GMSPlacesClient.provideAPIKey(apiKey)
          result(nil)
          
      case "showAutocomplete":
          guard let args = call.arguments as? [String: Any] else {
              result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected arguments", details: nil))
              return
          }
          
          showAutocomplete(
              filter: args["type"] as? String,
              bounds: args["bounds"] as? [String: Any],
              restriction: args["restriction"] as? [String: Any],
              country: args["country"] as? String
          )
          
      default:
          result(FlutterMethodNotImplemented)
    }
  }

  private func showAutocomplete(filter: String?, bounds: [String: Any]?, restriction: [String: Any]?, country: String?) {
    let autocompleteController = GMSAutocompleteViewController()
    autocompleteController.delegate = self
    
    let autocompleteFilter = GMSAutocompleteFilter()
    
    // Filtro por tipo
    if let filterKey = filter, let mappedFilter = filterTypes[filterKey] {
        autocompleteFilter.type = mappedFilter
    }

    // Filtro por país
    if let country = country {
        autocompleteFilter.country = country
    }

    // Bias o Restriction por ubicación
    if let restriction = restriction,
        let neLat = restriction["northEastLat"] as? Double,
        let neLng = restriction["northEastLng"] as? Double,
        let swLat = restriction["southWestLat"] as? Double,
        let swLng = restriction["southWestLng"] as? Double {
        let northeast = CLLocationCoordinate2D(latitude: neLat, longitude: neLng)
        let southwest = CLLocationCoordinate2D(latitude: swLat, longitude: swLng)
        autocompleteFilter.locationRestriction = GMSPlaceRectangularLocationOption(northeast, southwest)
    } else if let bounds = bounds,
              let neLat = bounds["northEastLat"] as? Double,
              let neLng = bounds["northEastLng"] as? Double,
              let swLat = bounds["southWestLat"] as? Double,
              let swLng = bounds["southWestLng"] as? Double {
        let northeast = CLLocationCoordinate2D(latitude: neLat, longitude: neLng)
        let southwest = CLLocationCoordinate2D(latitude: swLat, longitude: swLng)
        autocompleteFilter.locationBias = GMSPlaceRectangularLocationOption(northeast, southwest)
    }
    
    autocompleteController.autocompleteFilter = autocompleteFilter
    
    // UI oscura o clara
    if #available(iOS 12.0, *) {
        let style = UIScreen.main.traitCollection.userInterfaceStyle
        if style == .dark {
            autocompleteController.primaryTextColor = .white
            autocompleteController.secondaryTextColor = .lightGray
            autocompleteController.tableCellSeparatorColor = .lightGray
            autocompleteController.tableCellBackgroundColor = .darkGray
        } else {
            autocompleteController.primaryTextColor = .black
            autocompleteController.secondaryTextColor = .gray
            autocompleteController.tableCellSeparatorColor = .lightGray
            autocompleteController.tableCellBackgroundColor = .white
        }
    }

    // Mostrar controlador
    if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
        rootVC.present(autocompleteController, animated: true, completion: nil)
    }
  }
    
  // MARK: - GMSAutocompleteViewControllerDelegate  
  public func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    viewController.dismiss(animated: true)
    var data: [String: Any] = [
        "name": place.name ?? "",
        "latitude": String(format: "%.7f", place.coordinate.latitude),
        "longitude": String(format: "%.7f", place.coordinate.longitude),
        "id": place.placeID ?? ""
    ]
    
    if let address = place.formattedAddress {
        data["address"] = address
    }
    
    result?(data)
  }

  public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
      viewController.dismiss(animated: true)
      result?(FlutterError(code: "PLACE_AUTOCOMPLETE_ERROR", message: error.localizedDescription, details: nil))
  }

  public func wasCancelled(_ viewController: GMSAutocompleteViewController) {
      viewController.dismiss(animated: true)
      result?(FlutterError(code: "USER_CANCELED", message: "User has canceled the operation.", details: nil))
  }

  public func didRequestAutocompletePredictions(for viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  public func didUpdateAutocompletePredictions(for viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
