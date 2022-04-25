import 'package:flutter/material.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/drop_down.dart';

Widget inputDrop(
    {double width,
    Function value,
    String hint,
    String chosenvalue,
    List<dynamic> list}) {
  return container(
      hight: h(50),
      width: width ?? w(287),
      borderRadius: 5,
      bordercolor: AppColor.grey,
      child: DropDown(
          chosenvalue: chosenvalue,
          getindex: (val) {},
          hint: hint,
          list: list,
          onchanged: value));
}
