import 'dart:convert';

class PostModel {
  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromDynamic(dynamic obj){
    return PostModel(
        id: obj['id'],
        userId: obj['userId'],
        title: obj['title'],
        body: obj['body'],
    );
  }

  int userId;
  int id;
  String title;
  String body;
}