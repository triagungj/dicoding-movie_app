import 'package:ditonton/app/app.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  di.init();
  runApp(const App());
}
