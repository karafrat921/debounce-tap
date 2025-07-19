import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:debounce_tap/debounce_tap.dart';

void main() {
  group('Debounce Tests', () {
    testWidgets('InkWell debounce should work correctly', (
      WidgetTester tester,
    ) async {
      int tapCount = 0;
      int blockedCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.inkwell(
              onTap: () => tapCount++,
              onTapBlocked: (remainingMs) => blockedCount++,
              debounceDuration: const Duration(milliseconds: 500),
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      // İlk tıklama - çalışmalı
      await tester.tap(find.text('Test Button'));
      expect(tapCount, 1);
      expect(blockedCount, 0);

      // Hemen ardından ikinci tıklama - engellenmeli
      await tester.tap(find.text('Test Button'));
      expect(tapCount, 1); // Hala 1 olmalı
      expect(blockedCount, 1); // Engellenme sayısı artmalı

      // 500ms bekledikten sonra tıklama - çalışmalı
      await tester.pump(const Duration(milliseconds: 500));
      await tester.tap(find.text('Test Button'));
      expect(tapCount, 2);
      expect(blockedCount, 1);
    });

    testWidgets('GestureDetector debounce should work correctly', (
      WidgetTester tester,
    ) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.gestureDetector(
              onTap: () => tapCount++,
              debounceDuration: const Duration(milliseconds: 300),
              child: const Text('Gesture Test'),
            ),
          ),
        ),
      );

      // İlk tıklama
      await tester.tap(find.text('Gesture Test'));
      expect(tapCount, 1);

      // Hızlı tıklama - engellenmeli
      await tester.tap(find.text('Gesture Test'));
      expect(tapCount, 1);

      // 300ms sonra - çalışmalı
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('Gesture Test'));
      expect(tapCount, 2);
    });

    testWidgets('IconButton debounce should work correctly', (
      WidgetTester tester,
    ) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.iconButton(
              onTap: () => tapCount++,
              icon: const Icon(Icons.add),
              debounceDuration: const Duration(milliseconds: 200),
            ),
          ),
        ),
      );

      // İlk tıklama
      await tester.tap(find.byType(IconButton));
      expect(tapCount, 1);

      // Hızlı tıklama - engellenmeli
      await tester.tap(find.byType(IconButton));
      expect(tapCount, 1);

      // 200ms sonra - çalışmalı
      await tester.pump(const Duration(milliseconds: 200));
      await tester.tap(find.byType(IconButton));
      expect(tapCount, 2);
    });

    testWidgets('TextButton debounce should work correctly', (
      WidgetTester tester,
    ) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.textButton(
              onTap: () => tapCount++,
              child: const Text('Text Button'),
              debounceDuration: const Duration(milliseconds: 100),
            ),
          ),
        ),
      );

      // İlk tıklama
      await tester.tap(find.text('Text Button'));
      expect(tapCount, 1);

      // Hızlı tıklama - engellenmeli
      await tester.tap(find.text('Text Button'));
      expect(tapCount, 1);

      // 100ms sonra - çalışmalı
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.text('Text Button'));
      expect(tapCount, 2);
    });

    testWidgets('onTapBlocked callback should provide correct remaining time', (
      WidgetTester tester,
    ) async {
      int? lastRemainingMs;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.inkwell(
              onTap: () {},
              onTapBlocked: (remainingMs) => lastRemainingMs = remainingMs,
              debounceDuration: const Duration(milliseconds: 1000),
              child: const Text('Test'),
            ),
          ),
        ),
      );

      // İlk tıklama
      await tester.tap(find.text('Test'));

      // Hemen ardından ikinci tıklama
      await tester.tap(find.text('Test'));

      // Kalan süre 1000ms'e yakın olmalı
      expect(lastRemainingMs, isNotNull);
      expect(lastRemainingMs!, greaterThan(900));
      expect(lastRemainingMs!, lessThanOrEqualTo(1000));
    });

    testWidgets('Different debounce durations should work correctly', (
      WidgetTester tester,
    ) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Debounce.inkwell(
              onTap: () => tapCount++,
              debounceDuration: const Duration(milliseconds: 50),
              child: const Text('Quick Test'),
            ),
          ),
        ),
      );

      // İlk tıklama
      await tester.tap(find.text('Quick Test'));
      expect(tapCount, 1);

      // Hızlı tıklama - engellenmeli
      await tester.tap(find.text('Quick Test'));
      expect(tapCount, 1);

      // 50ms sonra - çalışmalı
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.text('Quick Test'));
      expect(tapCount, 2);
    });
  });
}
