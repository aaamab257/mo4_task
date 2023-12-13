import 'package:flutter/material.dart';
import 'package:mo4_task_posts_app/data/models/comments_model.dart';
import 'package:mo4_task_posts_app/data/models/post_model.dart';
import 'package:mo4_task_posts_app/repo/post_repo.dart';

class PostProvider with ChangeNotifier {
  final PostRepo postRepo;
  PostProvider({required this.postRepo});

  List<PostModel>? postsModel;
  List<CommentsModel>? commentsModel;

  List<PostModel>? get getPosts => postsModel;
  List<CommentsModel>? get getComments => commentsModel;
  bool isLoading = false;
  bool isDeleted = false;

  Future<void> getPost() async {
    isLoading = true;
    notifyListeners();
    final response = await postRepo.getPosts();
    postsModel = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getPostComments({int? id}) async {
    isLoading = true;
    notifyListeners();
    final response = await postRepo.getComments(postId: id);
    commentsModel = response;
    isLoading = false;
    notifyListeners();
  }

  Future<bool> deletePost({int? id}) async {
    isLoading = true;
    notifyListeners();
    final response = await postRepo.deletePost(postId: id);
    isDeleted = response;
    isLoading = false;
    notifyListeners();
    return isDeleted;
  }
}
