import 'package:flutter/cupertino.dart';
import 'package:flutter_mentoring/web/base_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends BasePage {

  const WebViewPage({required String title}) : super(title: title);

  @override
  Widget buildContent(BuildContext context) {
    return const Center(
      child: WebView(initialUrl: 'https://flutter.dev/')
      );
  }

}