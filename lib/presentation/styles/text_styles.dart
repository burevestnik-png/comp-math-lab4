import 'package:flutter/cupertino.dart';

import 'constants.dart';

enum TextSize { BASIC, SMALL }

Widget fieldText(String content, {TextSize size = TextSize.BASIC}) {
  return Text(
    content,
    style: TextStyle(
      fontSize:
          size == TextSize.BASIC ? kFieldBasicFontSize : kFieldSmallFontSize,
    ),
  );
}
