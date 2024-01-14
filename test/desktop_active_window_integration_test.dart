import 'package:desktop_active_window/src/active_window.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('YourPlugin fetches data successfully', (WidgetTester tester) async {
    var activeWindow = await ActiveWindow.getActiveWindowInfo;

    // Start your Flutter app
    print(activeWindow);

    // Wait for the app to fully start
    await tester.pumpAndSettle();

    // Your test logic here, interacting with the UI and checking results
  });
}