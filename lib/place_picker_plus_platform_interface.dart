import 'package:place_picker_plus/models/location_place.dart';
import 'package:place_picker_plus/models/place.dart';
import 'package:place_picker_plus/models/place_autocomplete.dart';
import 'package:place_picker_plus/models/type_filter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'place_picker_plus_method_channel.dart';

abstract class PlacePickerPlusPlatform extends PlatformInterface {
  /// Constructs a PlacePickerPlusPlatform.
  PlacePickerPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static PlacePickerPlusPlatform _instance = MethodChannelPlacePickerPlus();

  /// The default instance of [PlacePickerPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelPlacePickerPlus].
  static PlacePickerPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlacePickerPlusPlatform] when
  /// they register themselves.
  static set instance(PlacePickerPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Place> showAutocomplete({
    required PlaceAutocompleteMode mode,
    LocationPlace? bias,
    LocationPlace? restriction,
    TypeFilter? typeFilter,
    String? countryCode,
  }) async {
    throw UnimplementedError('showAutocomplete() has not been implemented.');
  }

  Future<void> initialize({String? androidApiKey, String? iosApiKey}) async {
    throw UnimplementedError('initialize() has not been implemented.');
  }
}
