import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/app_text_field.dart';
import 'package:flutter/cupertino.dart';

class UpdateInformation extends StatefulWidget {
  const UpdateInformation({Key? key}) : super(key: key);

  @override
  State<UpdateInformation> createState() => _UpdateInformationState();
}

class _UpdateInformationState extends State<UpdateInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppText("ho va ten"),
          AppTextField(),
          AppText("so dien thoai"),
          AppTextField()
        ],
      ),
    );
  }
}
