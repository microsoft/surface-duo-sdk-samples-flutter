import 'package:flutter/material.dart';

class Tool {
  final IconData icon;
  final String name;

  Tool(this.icon, this.name);
}

List<Tool> tools = [
  Tool(
    Icons.auto_fix_high,
    'Auto Fix',
  ),
  Tool(
    Icons.wb_sunny,
    'Brightness',
  ),
  Tool(
    Icons.brightness_medium,
    'Contrast',
  ),
  Tool(
    Icons.vignette,
    'Vignette',
  ),
  Tool(
    Icons.rotate_left,
    'Rotate',
  ),
  Tool(
    Icons.crop,
    'Crop',
  ),
];