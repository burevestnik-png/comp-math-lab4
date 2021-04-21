import 'package:comp_math_lab4/domain/state/main_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class Options extends GetView<MainScreenState> {
  _space() => SizedBox(height: 10);

  _spacedDivider() => Column(children: [
        _space(),
        Divider(),
        _space(),
      ]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [],
      ),
    );
  }
}
