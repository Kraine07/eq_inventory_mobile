import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';


class AppIcon extends StatefulWidget {
  final IconData icon;
  final double weight;
  final double size;
  final Color? color;


  const AppIcon({
    super.key,
    required this.icon,
    required this.weight,
    this.size = 24,
    this.color = AppColors.appWhite
  });

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      color: widget.color,
      size: widget.size,
      widget.icon,
      weight: widget.weight,
    );
  }
}
