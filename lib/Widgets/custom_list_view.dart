import 'package:flutter/material.dart';

Widget customlistview(
    {final double hight,
    final double width,
    final int itemcount,
    final direction,
    final double padding,
    final controller,
    final bool scroll,
    Function function}) {
  return SizedBox(
    height: hight,
    width: width,
    child: ListView.builder(
        physics: ScrollPhysics(
            parent: scroll
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics()),
        shrinkWrap: true,
        controller: controller ?? ScrollController(),
        padding:
            EdgeInsets.symmetric(vertical: padding) ?? const EdgeInsets.all(10),
        itemCount: itemcount,
        scrollDirection:
            direction == "vertical" ? Axis.vertical : Axis.horizontal,
        itemBuilder: function),
  );
}
