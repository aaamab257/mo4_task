import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:mo4_task_posts_app/data/models/comments_model.dart';
import 'package:mo4_task_posts_app/data/models/post_model.dart';
import 'package:mo4_task_posts_app/data/remote/dio/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepo {
  final DioClient dioClient;

  final SharedPreferences sharedPreferences;

  PostRepo({required this.dioClient, required this.sharedPreferences});

  Future<List<PostModel>> getPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final posts = json.map((e) {
        return PostModel(
            id: e['id'],
            title: e['title'],
            userId: e['userId'],
            body: e['body']);
      }).toList();
      return posts;
    }
    return [];
  }

  Future<List<CommentsModel>> getComments({int? postId}) async {
    String url = 'https://jsonplaceholder.typicode.com/posts/$postId/comments';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final comments = json.map((e) {
        return CommentsModel(
          postId: e['postId'],
          name: e['name'],
          commentId: e['id'],
          body: e['body'],
        );
      }).toList();
      return comments;
    }
    return [];
  }

  Future<bool> deletePost({int? postId}) async {
    String url = 'https://jsonplaceholder.typicode.com/posts/$postId';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}


//https://jsonplaceholder.typicode.com/posts/1
