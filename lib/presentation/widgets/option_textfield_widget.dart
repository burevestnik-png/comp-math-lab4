import 'package:comp_math_lab3/presentation/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionTextfield extends StatelessWidget {
  final String content;
  final TextEditingController controller;
  final void Function(String)? onChange;
  final String tooltipContent;

  OptionTextfield({
    required this.content,
    required this.onChange,
    required this.controller,
    required this.tooltipContent,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipContent,
      margin: EdgeInsets.only(top: 10),
      textStyle: TextStyle(fontSize: 14, color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 100,
            child: fieldText(content, size: TextSize.SMALL),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: onChange,
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
