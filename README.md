## ☕ Support Me

If you find this plugin useful, please consider supporting me:

[![Buy Me a Coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/codesfirst)


Note
Original repository: https://pub.dev/packages/google_places_picker

The problem with the original repository is that it will no longer be maintained by the creator, for this reason this repository was created in order to maintain updated code and make respective improvements as long as it is required.

# place_picker_plus

Google Places Autocomplete for Flutter

## Getting Started

### Setting up
1. Run the `initialize` method in your `main.dart`'s `initState` (or anywhere it would only be called once) with your API keys as arguments:
```dart
import 'package:place_picker_plus/place_picker_plus.dart';

PluginGooglePlacePicker().initialize(
      androidApiKey: "YOUR_ANDROID_API_KEY",
      iosApiKey: "YOUR_IOS_API_KEY",
);
```

### Usage

You can use the plugin via the `showAutocomplete` methods, which takes a PlaceAutocompleteMode paramater to know whether to display the fullscreen or the overlay control on Android (it has no effect on iOS). It returns a `Place` object with the following properties:

- name
- id
- address
- latitude
- longitude