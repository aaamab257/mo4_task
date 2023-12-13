class CommentsModel {
  // {
  //   "postId": 1,
  //   "id": 1,
  //   "name": "id labore ex et quam laborum",
  //   "email": "Eliseo@gardner.biz",
  //   "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
  // },

  int? postId;
  int? commentId;
  String? name;
  String? body;

  CommentsModel({this.body, this.commentId, this.name, this.postId});
}
