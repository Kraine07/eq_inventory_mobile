import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';


class AppIcon extends StatefulWidget {
  final IconData icon;
  final double weight;
  final double size;


  const AppIcon({
    super.key,
    required this.icon,
    required this.weight,
    this.size = 24
  });

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      color: AppColors.appWhite,
      size: widget.size,
      widget.icon,
      weight: widget.weight,
    );
  }
}
