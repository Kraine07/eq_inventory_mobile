import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme.dart';
import 'icon.dart';

class Heading extends StatefulWidget {

  final TextEditingController searchController;
  final bool showIcon;
  final String name;


   Heading({
     super.key,
     required this.name,
     required this.searchController,
     required this.showIcon
  });



  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween
          ,
          spacing: 20,
          children: [
            Visibility(
              visible: widget.showIcon,
                child: AppIcon(icon: Symbols.arrow_back, weight: 500)),
            Text("Equipment",
              style: TextStyle(
                  fontSize: 32
              ),
            ),
            Expanded(
              child: Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppIcon(icon: Symbols.add, weight: 300,size: 32,),
                  AppIcon(icon: Symbols.construction, weight: 300,size: 32,)
                ],
              ),
            )
          ],
        ),



        Text(widget.name,
          style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary
          ),
        ),



        AppInputField(
          label: "Search",
            radius: 1000.0,
            borderStyle: BorderStyle.none,
            controller: widget.searchController,
            obscureText: false,
            validator: (val){},
            icon: AppIcon(icon: Symbols.search, weight: 300),
            onChanged: (val){}
        ),
      ],
    );
  }
}
