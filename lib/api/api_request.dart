import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:subspace/models/blog.dart';

class Api {
  Future<String> fetchBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode != 200) {
        return Future.error(Exception("Something went wrong"));
      }
      return response.body;
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  List<Blog> parseBlog(String responseBody) {
    Map parsed = jsonDecode(responseBody);
    List parsedList = parsed["blogs"];
    return parsedList.map((json) => Blog.fromJson(json)).toList();
  }
}
