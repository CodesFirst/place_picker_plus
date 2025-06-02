import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:place_picker_plus/models/location_place.dart';
import 'package:place_picker_plus/models/place.dart';
import 'package:place_picker_plus/models/place_autocomplete.dart';
import 'package:place_picker_plus/models/type_filter.dart';

import 'place_picker_plus_platform_interface.dart';

/// An implementation of [PlacePickerPlusPlatform] that uses method channels.
class MethodChannelPlacePickerPlus extends PlacePickerPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('place_picker_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Place> showAutocomplete({
    required PlaceAutocompleteMode mode,
    LocationPlace? bias,
    LocationPlace? restriction,
    TypeFilter? typeFilter,
    String? countryCode,
  }) async {
    var argMap = {
      "mode": mode == PlaceAutocompleteMode.modeOverlay ? 71 : 72,
      "bias": bias?.toJson(),
      "restriction": restriction?.toJson(),
      "type": typeFilter?.name,
      "country": countryCode,
    };

    final result = await methodChannel.invokeMethod<Map<dynamic, dynamic>?>(
      'showAutocomplete',
      argMap,
    );

    if (result == null) {
      throw PlatformException(
        code: 'NULL_RESULT',
        message: 'No place was selected or result is null',
      );
    }

    // Convert Map<dynamic, dynamic> to Map<String, dynamic>
    final placeMap = Map<String, dynamic>.from(result);

    return Place.fromJson(placeMap);
  }

  @override
  Future<void> initialize({String? androidApiKey, String? iosApiKey}) async {
    final args = <String, String>{
      'androidApiKey': androidApiKey ?? '',
      'iosApiKey': iosApiKey ?? '',
    };
    await methodChannel.invokeMethod('initialize', args);
  }
}
