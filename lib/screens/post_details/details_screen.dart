import 'package:flutter/material.dart';
import 'package:mo4_task_posts_app/data/models/post_model.dart';
import 'package:mo4_task_posts_app/providers/posts_providers.dart';

import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final String postTitle;
  final PostModel postModel;
  final int postId;
  const DetailsScreen(
      {super.key,
      required this.postTitle,
      required this.postModel,
      required this.postId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostProvider>(context, listen: false)
          .getPostComments(id: widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.postTitle,
        ),
      ),
      body: Column(
        children: [
          const Text(
            "Comments",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child:
                  Consumer<PostProvider>(builder: (context, comments, child) {
                if (comments.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: comments.getComments!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return commentStyle(
                          comments.getComments![index].postId,
                          comments.getComments![index].name,
                          comments.getComments![index].body);
                    },
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

Widget commentStyle(int? id, String? name, String? body) {
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      leading: const Icon(
        Icons.person,
        size: 15.0,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            body!,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
