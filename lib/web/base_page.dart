import 'package:flutter/material.dart';

abstract class BasePage extends StatelessWidget {

  final String title;

  const BasePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: buildContent(context),
      ),
    );
  }

  Widget buildContent(BuildContext context);
}