import 'package:equipment_inventory/Service/propertyService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme.dart';
import '../utilityMethods.dart';
import 'icon.dart';

class PropertySheet extends StatefulWidget {

  final PropertyService property;
  final int index;
  const PropertySheet({super.key, required this.property, required this.index});

  @override
  State<PropertySheet> createState() => _PropertySheetState();
}

class _PropertySheetState extends State<PropertySheet> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // show property sheet
        showCupertinoSheet(
            useNestedNavigation: true,
            context: context,
            builder: (BuildContext context){
              return Material(
                color: AppColors.appLightBlue,
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      spacing: 32,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        // property name
                        Row(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                UtilityMethods.capitalizeEachWord(widget.property.propertyList[widget.index].name ?? ""),
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w200
                                ),
                              ),
                            ),
                            Row(
                              spacing: 8,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppIcon(icon: Symbols.add_2_rounded, weight: 500,),
                                AppIcon(icon: Symbols.edit, weight: 500,color: AppColors.activeColor,),
                                AppIcon(icon: Symbols.delete, weight: 500,color: AppColors.inactiveColor,),

                              ],
                            ),
                          ],
                        ),

                        // list of locations
                        Expanded(
                          child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  maxCrossAxisExtent: 360,
                                  mainAxisExtent: 100
                              ),
                              itemCount: 10,
                              itemBuilder: (context, index){
                                return GridTile(
                                  header: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Text("Location Name",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                  footer: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      spacing: 20,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AppIcon(icon: Symbols.edit, weight: 500,color: AppColors.activeColor, size: 20,),
                                        AppIcon(icon: Symbols.delete, weight: 500,color: AppColors.inactiveColor, size: 20,),

                                      ],
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.appBlue,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                  ),
                                );

                              }
                          ),
                        ),
                      ],
                    )),
              );
            }
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: AppColors.appBlue,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Center(
          child: Text(
            UtilityMethods.capitalizeEachWord(widget.property.propertyList[widget.index].name.toString()),
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w300,
                fontSize: 16
            ),
          ),
        ),
      ),
    );
  }
}
