import 'package:app1/controllers/user_controller.dart';
import 'package:app1/screens/screen1.dart';
import 'package:app1/screens/screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('FirstScreen - check palindrome and navigate', (WidgetTester tester) async {
    Get.put(UserController());

    await tester.pumpWidget(
      GetMaterialApp(
        home: const FirstScreen(),
      ),
    );

    final nameField = find.byType(TextField).at(0);
    final sentenceField = find.byType(TextField).at(1);
    final checkButton = find.widgetWithText(ElevatedButton, "CHECK");
    final nextButton = find.widgetWithText(ElevatedButton, "NEXT");
    expect(nextButton, findsOneWidget);

    await tester.enterText(nameField, "Rafi");
    await tester.enterText(sentenceField, "Madam");
    await tester.tap(checkButton);
    await tester.pump();

    expect(find.text("isPalindrome"), findsOneWidget);
    Get.back();
    await tester.pumpAndSettle();


    await tester.tap(nextButton);
    await tester.pump(); 
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(SecondScreen), findsOneWidget);
    expect(find.textContaining("Welcome"), findsOneWidget);
  });

  testWidgets('Shows error when fields are empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FirstScreen(),
      ),
    );

    final nextButton = find.widgetWithText(ElevatedButton, "NEXT");
    expect(nextButton, findsOneWidget);

    await tester.tap(nextButton);
    await tester.pump(); 
    await tester.pump(const Duration(seconds: 1)); 

    expect(find.text("Please enter your name"), findsOneWidget);
  });
}
