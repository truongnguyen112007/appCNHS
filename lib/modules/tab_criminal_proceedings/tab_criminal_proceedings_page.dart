import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabCriminalProceedingsPage extends StatefulWidget {
  const TabCriminalProceedingsPage({Key? key}) : super(key: key);

  @override
  State<TabCriminalProceedingsPage> createState() => _TabCriminalProceedingsPageState();
}

class _TabCriminalProceedingsPageState extends State<TabCriminalProceedingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Criminal Proceeding'),
      ),
    );
  }
}
