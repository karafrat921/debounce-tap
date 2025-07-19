import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:debounce_tap/debounce_tap.dart';

void main() {
  group('Debounce Widget Tests', () {
    testWidgets('Debounce.inkwell should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.inkwell(onTap: () {}, child: const Text('Test')),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('Debounce.gestureDetector should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.gestureDetector(
              onTap: () {},
              child: const Text('Test'),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('Debounce.iconButton should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.iconButton(
              onTap: () {},
              icon: const Icon(Icons.favorite),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('Debounce.textButton should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.textButton(
              onTap: () {},
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });
  });
}
