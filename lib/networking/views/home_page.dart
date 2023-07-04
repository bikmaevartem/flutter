import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mentoring/networking/views/posts_list_page.dart';

import '../mixins/app_bar_mixin.dart';
import '../models/post_model.dart';

class HomePage extends StatelessWidget with AppBarMixin{
  HomePage({super.key});
  final _HomePageLogic _homePageLogic = _HomePageLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Home Page'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              child: const Text('GO TO 2nd SCREEN'),
              onPressed: () => _navigateToPostsListPage(context),
            ),
            StreamBuilder(
              stream: _homePageLogic.postModelStream,
              builder: _postBuilder,
            )
          ],
        ),
      ),
    );
  }

  void _navigateToPostsListPage(BuildContext context) async{
    final PostModel? postModel = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=> PostsListPage())
    );

    _homePageLogic.showPost(postModel);

    if (postModel != null){

    }

  }

  Widget _postBuilder(BuildContext context, AsyncSnapshot<PostModel?> snapshot){
    if (!snapshot.hasData){
      return Container();
    }
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white30,
      ),
      child: Column(
        children: [
          Text('id:${snapshot.data?.id}'),
          Text('user id:${snapshot.data?.userId}'),
          Text('title:${snapshot.data?.title}'),
          Text('body:${snapshot.data?.body}'),
        ],
      ),
    );
  }
}

class _HomePageLogic {
  late final StreamController<PostModel?> _streamController;

  _HomePageLogic(){
    _streamController = StreamController();
  }

  void showPost(PostModel? postModel) {
    _streamController.add(postModel);
  }

  Stream<PostModel?> get postModelStream  => _streamController.stream;
}