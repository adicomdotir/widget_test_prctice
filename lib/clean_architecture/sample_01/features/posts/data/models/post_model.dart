import 'package:widget_test_practice/clean_architecture/sample_01/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required int id,
    required int userId,
    required String title,
    required String body,
  }): super(id: id, userId: userId, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'body': body,
  };
}
