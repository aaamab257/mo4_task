import 'package:flutter/material.dart';
import 'package:mo4_task_posts_app/providers/posts_providers.dart';
import 'package:mo4_task_posts_app/screens/post_details/details_screen.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostProvider>(context, listen: false).getPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Posts',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          child: Consumer<PostProvider>(builder: (context, posts, child) {
            if (posts.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: posts.getPosts!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) async {
                      await Provider.of<PostProvider>(context, listen: false)
                          .deletePost(id: posts.getPosts![index].id)
                          .then((value) {
                        if (value) {
                          posts.getPosts!.removeAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Post Deleted')));
                        }
                      });
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                  postTitle: posts.getPosts![index].title!,
                                  postModel: posts.getPosts![index],
                                  postId: posts.getPosts![index].id!)),
                        );
                      },
                      child: postStyle(
                          context,
                          posts.getPosts![index].id,
                          posts.getPosts![index].title,
                          posts.getPosts![index].body),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}

Widget postStyle(BuildContext context, int? id, String? title, String? body) {
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: Colors.grey[400],
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
            title!,
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
