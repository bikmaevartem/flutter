import 'package:flutter/material.dart';

mixin AppBarMixin {
  AppBar buildAppBar({required String title}){
    return AppBar(
      title: Text(title),
    );
  }
}