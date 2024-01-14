# dotup_flutter_active_window

 A flutter plugin to get active foreground window on MacOS, Windows and Linux.

## Usage

A simple usage example:

```dart
import 'package:dotup_flutter_active_window/dotup_flutter_active_window.dart';

main() {
  final windowInfo = await DotupFlutterActiveWindow.getActiveWindowInfo;

  // or with observer
  final filterFromDb = ActiveWindowFilter(value: 'dotup_', field: ActiveWindowProperty.title);
  final windowObserver = ActiveWindowObserver()
      ..addFilter((windowInfo) => windowInfo?.title.contains('main') == false)
      ..addFilter(ActiveWindowFilterGenerator().generate(filterFromDb))
      ..listen((event) {
        print(event);
      });
    windowObserver.start();
}
```

[dotup.de](https://dotup.de)

## Install
`flutter pub add dotup_flutter_active_window`

## Links

> ### dotup_flutter_themed on [pub.dev](https://pub.dev/packages/dotup_flutter_themed)
>
> ### Other widgets on [pub.dev](https://pub.dev/packages?q=dotup)
> 
> ### Other open source flutter projects on [Github](https://github.com/search?q=dotup_flutter)
> 
> ### Other open source dart projects on [Github](https://github.com/search?q=dotup_dart)

# Flutter simulator | DFFP3
> Go to [https://flutter-apps.ml](https://flutter-apps.ml) and check out the awesome flutter simulator !

![Flutter simulator](https://flutter-apps.ml/wp-content/uploads/2021/10/Bildschirmfoto-2021-10-31-um-11.34.42-2048x1335.png)

> ## [dotup IT solutions](https://dotup.de)
