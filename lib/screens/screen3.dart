import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';

class ThirdScreen extends StatefulWidget {
  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> users = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  final userController = Get.find<UserController>();
  final ScrollController scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchUsers();

    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent - 200) {
        fetchUsers();
      }
    });
  }

  Future<void> fetchUsers({bool refresh = false}) async {
    if (isLoading || (!hasMore && !refresh)) return;

    setState(() {
      isLoading = true;
    });

    final currentPage = refresh ? 1 : page;
    final url = 'https://reqres.in/api/users?page=$currentPage&per_page=10';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-api-key': 'reqres-free-v1',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newUsers = (data['data'] as List)
            .map((e) => User.fromJson(e))
            .toList();

        setState(() {
          if (refresh) {
            users = newUsers;
            page = 2;
            hasMore = true;
          } else {
            users.addAll(newUsers);
            page++;
            if (newUsers.isEmpty) hasMore = false;
          }
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void selectUser(User user) {
    final fullName = "${user.firstName} ${user.lastName}";
    userController.setSelectedUser(fullName);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Third Screen")),
      body: RefreshIndicator(
        onRefresh: () => fetchUsers(refresh: true),
        child: users.isEmpty && !isLoading
            ? Center(child: Text("No users found."))
            : ListView.builder(
                controller: scrollCtrl,
                itemCount: users.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= users.length) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    onTap: () => selectUser(user),
                  );
                },
              ),
      ),
    );
  }
}