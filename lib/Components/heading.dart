import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:equipment_inventory/utilityMethods.dart';
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
    return Material(
      color: AppColors.appDarkBlue.withValues(alpha: 0.8),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
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



            Text(UtilityMethods.capitalizeEachWord(widget.name),
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary
              ),
            ),



            Center(
              child: AppInputField(
                label: "Search",
                radius: 1000.0,
                borderStyle: BorderStyle.none,
                controller: widget.searchController,
                obscureText: false,
                validator: (val){},
                icon: AppIcon(icon: Symbols.search, weight: 300,size: 18,),
                  fontSize: 14,
                  verticalPadding: 4,
                onChanged: (val){}
              ),
            ),
          ],
        ),
      ),
    );
  }
}
