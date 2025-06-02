import 'package:place_picker_plus/models/location_place.dart';
import 'package:place_picker_plus/models/place.dart';
import 'package:place_picker_plus/models/place_autocomplete.dart';
import 'package:place_picker_plus/models/type_filter.dart';

import 'place_picker_plus_platform_interface.dart';

class PlacePickerPlus {
  Future<String?> getPlatformVersion() {
    return PlacePickerPlusPlatform.instance.getPlatformVersion();
  }

  Future<Place> showAutocomplete({
    required PlaceAutocompleteMode mode,
    LocationPlace? bias,
    LocationPlace? restriction,
    TypeFilter? typeFilter,
    String? countryCode,
  }) async {
    return await PlacePickerPlusPlatform.instance.showAutocomplete(
      mode: mode,
      bias: bias,
      restriction: restriction,
      typeFilter: typeFilter,
      countryCode: countryCode,
    );
  }

  Future<void> initialize({String? androidApiKey, String? iosApiKey}) async {
    await PlacePickerPlusPlatform.instance.initialize(
      androidApiKey: androidApiKey,
      iosApiKey: iosApiKey,
    );
  }
}
