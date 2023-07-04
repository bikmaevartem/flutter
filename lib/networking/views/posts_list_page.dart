import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_mentoring/networking/mixins/app_bar_mixin.dart';

import '../models/post_model.dart';

class PostsListPage extends StatelessWidget with AppBarMixin {
  PostsListPage();

  final _PostsListPageLogic _logic = _PostsListPageLogic();
  late final List<PostModel> _posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Posts Page'),
      body: FutureBuilder(
        future: _logic.fetchPostsList(),
        initialData: null,
        builder: _builderForFutureBuilder,
      ),
    );
  }

  Widget _builderForFutureBuilder(BuildContext context, AsyncSnapshot<List<PostModel>?> snapshot){
    if (!snapshot.hasData) {
      return const Text('Data is loading');
    }

    if (snapshot.data!.isEmpty){
      return const Text('No data');
    }

    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).pop(snapshot.data![index]);
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('id: ${snapshot.data![index].id}'),
                Text('userId: ${snapshot.data![index].userId}'),
                Text('title: ${snapshot.data![index].title}'),
                Text('body: ${snapshot.data![index].body}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PostsListPageLogic {
  static const String _url = 'jsonplaceholder.typicode.com';
  static const String _urlPath = '/posts';

  _PostsListPageLogic();

  Future<List<PostModel>> fetchPostsList() async {
    final List<PostModel> result = [];
    final Uri uri = Uri.https(_url, _urlPath);
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> body = convert.jsonDecode(response.body);
      for(var obj in body) {
        result.add(PostModel.fromDynamic(obj));
      }
    }

    return Future.value(result);
  }
}