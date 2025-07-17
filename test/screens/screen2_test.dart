import 'package:app1/screens/screen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:app1/controllers/user_controller.dart';
import 'package:app1/screens/screen2.dart';

void main() {
  setUp(() {
    Get.put(UserController()); 
  });

  tearDown(() {
    Get.reset(); 
  });

  testWidgets('SecondScreen displays user name and selected user info', (WidgetTester tester) async {
    final userController = Get.find<UserController>();
    userController.setUserName("Rafi");

    await tester.pumpWidget(
      GetMaterialApp(
        home: SecondScreen(),
      ),
    );

    expect(find.text("Welcome"), findsOneWidget);
    expect(find.text("Rafi"), findsOneWidget);
    expect(find.text("Selected User Name"), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, "Choose a User"), findsOneWidget);
  });

  testWidgets('SecondScreen displays selected user name when set', (WidgetTester tester) async {
    final userController = Get.find<UserController>();
    userController.setUserName("Rafi");
    userController.setSelectedUser("Jane Doe");

    await tester.pumpWidget(
      GetMaterialApp(
        home: SecondScreen(),
      ),
    );

    expect(find.text("Welcome"), findsOneWidget);
    expect(find.text("Rafi"), findsOneWidget);
    expect(find.text("Jane Doe"), findsOneWidget);
  });

  testWidgets('SecondScreen navigates to ThirdScreen on button press', (WidgetTester tester) async {
    final userController = Get.find<UserController>();
    userController.setUserName("Rafi");

    await tester.pumpWidget(
      GetMaterialApp(
        home: SecondScreen(),
      ),
    );

    expect(find.byType(SecondScreen), findsOneWidget);
    
    final nextButton = find.widgetWithText(ElevatedButton, "Choose a User");
    expect(nextButton, findsOneWidget);

    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    expect(find.byType(ThirdScreen), findsOneWidget);
  });
}