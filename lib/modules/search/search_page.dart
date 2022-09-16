import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:flutter/cupertino.dart';

import '../../components/app_scalford.dart';

class SearchPage extends StatefulWidget {
  final int index;

  const SearchPage({Key? key, required this.index}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends BasePopState<SearchPage> {
  @override
  Widget buildWidget(BuildContext context) {
    return const AppScaffold(
      body: Center(
        child: AppText("TAG SEARCH"),
      ),
    );
  }

  @override
  int get tabIndex => widget.index;
}
