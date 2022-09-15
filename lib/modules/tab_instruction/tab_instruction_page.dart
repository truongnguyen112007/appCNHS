import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabInstructionPage extends StatefulWidget {
  const TabInstructionPage({Key? key}) : super(key: key);

  @override
  State<TabInstructionPage> createState() => _TabInstructionPageState();
}

class _TabInstructionPageState extends State<TabInstructionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
        child: Text('Instructrion Page'),
      ),
    );
  }
}
