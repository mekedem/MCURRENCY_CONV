// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mcurrency_conv/main.dart';

void main() {
  testWidgets('SearchInput', (WidgetTester tester) async {
    final targetfield = find.byKey(ValueKey("SearchInput"));
    final evaluatedfield = find.byKey(ValueKey("outputkey"));

    await tester.pumpWidget(MaterialApp(home: MyApp()));
    await tester.enterText(targetfield, "10");
    await tester.pump();

    expect(find.text("10"), findsWidgets);
  });
}
