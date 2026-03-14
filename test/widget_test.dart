import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noteapp/main.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Notes app smoke test', (WidgetTester tester) async {
    // Build app and trigger frame
    await tester.pumpWidget(const MyApp());

    // Initial empty state
    expect(find.text('No notes yet. Tap + to add one!'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Tap FAB to add note
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Dialog appears
    expect(find.text('Add Note'), findsOneWidget);

    // Enter title and desc
    await tester.enterText(find.byType(TextField).first, 'Test Title');
    await tester.enterText(find.byType(TextField).last, 'Test Description');

    // Tap Add
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Note appears
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    // Delete button exists
    expect(find.byIcon(Icons.delete), findsOneWidget);
  });
}
