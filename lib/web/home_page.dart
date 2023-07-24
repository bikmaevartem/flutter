import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mentoring/web/base_page.dart';
import 'package:flutter_mentoring/web/map_view_page.dart';
import 'package:flutter_mentoring/web/video_player_page.dart';
import 'package:flutter_mentoring/web/web_view_page.dart';

class HomePage extends BasePage {

  const HomePage({required String title}) : super(title: title);

  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const WebViewPage(title: 'Web View')));
                },
              child: const Text('WebView ')
          ),
          OutlinedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const MapViewPage(title: 'Map View')));
              },
              child: const Text('MapView')
          ),
          OutlinedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=> VideoPlayerPage(videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
                );
              },
              child:const Text('VideoPlayer ')),
        ],
      ),
    );
  }

}