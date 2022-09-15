import 'package:flutter/material.dart';

class TabCriminalLawPage extends StatefulWidget {
  const TabCriminalLawPage({Key? key}) : super(key: key);

  @override
  State<TabCriminalLawPage> createState() => _TabCriminalLawPageState();
}

class _TabCriminalLawPageState extends State<TabCriminalLawPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child:
      Text('Criminal law'),));
  }
}
