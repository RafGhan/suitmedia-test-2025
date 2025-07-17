import 'package:flutter_test/flutter_test.dart';
import 'package:app1/models/user_model.dart';
import 'package:get/get.dart';
import 'package:app1/controllers/user_controller.dart';

class TestThirdScreenState {
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;
  List<User> users = [];

  void selectUser(User user) {
    final fullName = '${user.firstName} ${user.lastName}';
    Get.find<UserController>().selectedUserName.value = fullName;
  }
}

void main() {
  group('TestThirdScreenState', () {
    late TestThirdScreenState state;

    setUp(() {
      Get.put(UserController());
      state = TestThirdScreenState();
    });

    test('Initial values', () {
      expect(state.page, 1);
      expect(state.isLoading, isFalse);
      expect(state.hasMore, isTrue);
      expect(state.users, isEmpty);
    });

    test('selectUser sets controller value', () {
      final user = User(
        firstName: 'Rafi',
        lastName: 'Ghani',
        email: 'rafi@example.com',
        avatar: '',
      );
      state.selectUser(user);
      expect(Get.find<UserController>().selectedUserName.value, 'Rafi Ghani');
    });
  });
  
}
