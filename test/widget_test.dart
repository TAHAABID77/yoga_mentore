import 'package:flutter_test/flutter_test.dart';
import 'package:yoga_mentore/main.dart';

void main() {
  testWidgets('App launches with SplashScreen', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Wait for animations / splash delay to complete
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Check if SplashScreen text exists
    expect(find.text('Yoga Mentor'), findsOneWidget);
  });
}
