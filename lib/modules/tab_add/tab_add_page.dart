import 'package:flutter/material.dart';

class TabAdd extends StatefulWidget {
  const TabAdd({Key? key}) : super(key: key);

  @override
  State<TabAdd> createState() => _TabAddState();
}

class _TabAddState extends State<TabAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('add'),
      ),
    );
  }
}
