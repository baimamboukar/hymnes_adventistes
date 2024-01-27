// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hymnes_adventistes/src/app/app.dart';

void main() {
  testWidgets('MaterialApp Widget Setup', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SabbathSongs());
    // Find MaterialApp widget.
    final materialAppFinder = find.byType(MaterialApp);

    // expect(find.byType(SabbathSongBlocs), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);

    // Get the MaterialApp widget.
    final materialApp = tester.widget<MaterialApp>(materialAppFinder);

    // Assert that the default locale is English.
    expect(materialApp.supportedLocales, contains(const Locale('en', '')));
  });
}
