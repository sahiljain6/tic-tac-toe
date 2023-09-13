import 'package:flutter/material.dart';

const List<BoxShadow> shadows = [
  BoxShadow(color: Colors.purple, blurRadius: 4, spreadRadius: 0.1,blurStyle: BlurStyle.outer),
  BoxShadow(color: Colors.purple, blurRadius: 4, spreadRadius: 0.1,blurStyle: BlurStyle.outer)
];
List<BoxShadow> gridShadows = [
  BoxShadow(
      blurStyle: BlurStyle.outer,
      color: Colors.grey[800]!,
      spreadRadius: 0.1,
      blurRadius: 1,
      offset: const Offset(1, 1)),
  const BoxShadow(
      blurStyle: BlurStyle.outer,
      color: Colors.purple,
      spreadRadius: 0.1,
      blurRadius: 1,
      offset: Offset(-1, -1)),
];
