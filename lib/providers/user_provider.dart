import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  String? selectedUserName;
  String? name;
  bool? isPalindrome;
  List users = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void checkPalindrome(String text) {
    String formattedText = text.replaceAll(' ', '').toLowerCase();
    isPalindrome = formattedText == formattedText.split('').reversed.join('');
    notifyListeners();
  }

  Future<void> fetchUsers(int page) async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=$page&per_page=8'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['data'].isEmpty) {
        hasMoreData = false;
      } else {
        users.addAll(data['data']);
        currentPage++;
      }
      notifyListeners();
    }
    isLoading = false;
  }

  void selectUser(String firstName, String lastName) {
    selectedUserName = '$firstName $lastName';
    notifyListeners();
  }
}
