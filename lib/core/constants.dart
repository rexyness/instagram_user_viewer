import 'package:flutter/material.dart';
import 'package:instagram_user_viewer/theme/palette.dart';

const kBorderRadius = 8.0;
const kListItemSpacing = 12.0;
const kMediumSpacing = 24.0;

final kInnerDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(32),
);
// border for all 3 colors
final kGradientBoxDecoration = BoxDecoration(
  gradient: const LinearGradient(colors: [Colors.orange, Palette.red500]),
  border: Border.all(
    color: Colors.amber, //kHintColor, so this should be changed?
  ),
  borderRadius: BorderRadius.circular(32),
);
