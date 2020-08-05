import 'package:flutter/material.dart';

class ItemColor {
  final Color backgroundColor;
  final Color lineColor;
  final Color gradientColor;
  final Color startColor;
  final Color endColor;

  ItemColor({
    this.backgroundColor,
    this.lineColor,
    this.gradientColor,
    this.startColor,
    this.endColor,
  });

  static List<ItemColor> data = <ItemColor>[
    ItemColor(
      backgroundColor: Color(0xff008e7b),
      gradientColor: Color(0xff009a88),
      lineColor: Color(0xff5bc8b7),
      startColor: Color(0xffff775e),
      endColor: Color(0xffff8d77),
    ),
    ItemColor(
      backgroundColor: Color(0xffff775e),
      gradientColor: Color(0xffff8d77),
      lineColor: Color(0xffffc4b7),
      startColor: Color(0xFF738AE6),
      endColor: Color(0xFF5C5EDD),
    ),
    ItemColor(
      backgroundColor: Color(0xffffcb0f),
      gradientColor: Color(0xffffd642),
      lineColor: Color(0xfffff199),
      startColor: Color(0xFFFE95B6),
      endColor: Color(0xFFFF5287),
    ),
    ItemColor(
      backgroundColor: Color(0xff6078ff),
      gradientColor: Color(0xff758aff),
      lineColor: Color(0xffe7e9fb),
      startColor: Color(0xFF6F72CA),
      endColor: Color(0xFF1E1466),
    )
  ];
}
