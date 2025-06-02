import 'package:flutter_test/flutter_test.dart';
import 'package:place_picker_plus/models/location_place.dart';
import 'package:place_picker_plus/models/place.dart';
import 'package:place_picker_plus/models/place_autocomplete.dart';
import 'package:place_picker_plus/models/type_filter.dart';
import 'package:place_picker_plus/place_picker_plus.dart';
import 'package:place_picker_plus/place_picker_plus_platform_interface.dart';
import 'package:place_picker_plus/place_picker_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPlacePickerPlusPlatform
    with MockPlatformInterfaceMixin
    implements PlacePickerPlusPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> initialize({String? androidApiKey, String? iosApiKey}) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<Place> showAutocomplete({
    required PlaceAutocompleteMode mode,
    LocationPlace? bias,
    LocationPlace? restriction,
    TypeFilter? typeFilter,
    String? countryCode,
  }) {
    // TODO: implement showAutocomplete
    throw UnimplementedError();
  }
}

void main() {
  final PlacePickerPlusPlatform initialPlatform = PlacePickerPlusPlatform.instance;

  test('$MethodChannelPlacePickerPlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPlacePickerPlus>());
  });

  test('getPlatformVersion', () async {
    PlacePickerPlus placePickerPlusPlugin = PlacePickerPlus();
    MockPlacePickerPlusPlatform fakePlatform = MockPlacePickerPlusPlatform();
    PlacePickerPlusPlatform.instance = fakePlatform;

    expect(await placePickerPlusPlugin.getPlatformVersion(), '42');
  });
}
