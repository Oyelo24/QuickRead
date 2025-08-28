import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static String get baseUrl {
    if (kDebugMode) {
      // Development URLs
      if (kIsWeb) {
        return "http://127.0.0.1:8090/api"; // Web (Chrome)
      } else if (Platform.isAndroid) {
        return "http://10.0.2.2:8090/api"; // Android emulator
      } else {
        return "http://127.0.0.1:8090/api"; // iOS simulator/other
      }
    } else {
      // Production
      return "https://your-production-server.com/api";
    }
  }

  Future<Map<String, dynamic>> registerUser(
    String email,
    String password,
    String name,
  ) async {
    final url = Uri.parse("$baseUrl/collections/users/records");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "passwordConfirm": password,
        "name": name,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ User registered successfully!");
      return jsonDecode(response.body);
    } else {
      print("❌ Failed to register: ${response.body}");
      throw Exception("Registration failed: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse("$baseUrl/collections/users/auth-with-password");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"identity": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  Future<List<Map<String, dynamic>>> fetchBooks() async {
    final url = Uri.parse("$baseUrl/collections/books/records");

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['items'] ?? []);
    } else {
      throw Exception("Failed to fetch books: ${response.body}");
    }
  }
//Bookmarks post and get request and remove http function//

  Future<Map<String, dynamic>> createBookmark(
    String userId,
    String bookId,
    int page,
  ) async {
    final url = Uri.parse("$baseUrl/collections/bookmarks/records");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user": userId,
        "book": bookId,
        "page": page,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to create bookmark: ${response.body}");
    }
  }

    Future<List<Map<String, dynamic>>> fetchBookmarks() async {
    final url = Uri.parse("$baseUrl/collections/bookmarks/records");

    final response = await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['items'] ?? []);
    } else {
      throw Exception("Failed to fetch bookmarks: ${response.body}");
    }
  }
}
