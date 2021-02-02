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
    await tester.pumpWidget(MyApp());
    var textField = find.byType(TextField);
    var textval = find.byType(Text);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'Hello');
    expect(find.text(' '), findsOneWidget);
    await tester.pump();
    expect(textval.toString(), '');
    tester.getSize(textval);
  });
}
