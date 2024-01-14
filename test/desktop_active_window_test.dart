import 'package:desktop_active_window/desktop_active_window.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {
  const MethodChannel channel = MethodChannel('desktop_active_window');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (message) async => await channel.invokeMethod('getActiveWindowInfo'));
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (message) async => await channel.invokeMethod('getActiveWindowInfo'));
  });

  test('testing', () async {

    print("result: STARTING");

    print("result: ENDING");

    try {
      var result = (await ActiveWindow.getActiveWindowInfo)?.toJson();
      print("result: ${result}");
    } catch (e) {
      print("result-exp: ${e}");
    }

    // expect(result, {'key': 'value'});

    // expect(await ActiveWindow.getActiveWindowInfo, throwsA(isInstanceOf<ActiveWindowInfo>()));
  });


}
