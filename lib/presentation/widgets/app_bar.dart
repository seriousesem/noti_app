import 'package:flutter/material.dart';

buildAppBar({String title = '', Widget? leading}) {
  return AppBar(
    title: Text(
      title,
    ),
    leading: leading,
  );
}
