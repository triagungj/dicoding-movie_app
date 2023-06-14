import 'package:flutter/material.dart';

class TvSeriesDetailPage extends StatelessWidget {
  const TvSeriesDetailPage({required this.id, super.key});
  static const String routeName = '/tv-detail';
  final String id;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('detail')),
    );
  }
}
