
import 'package:equipment_inventory/Components/locationSheet.dart';
import 'package:equipment_inventory/Service/equipmentService.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:equipment_inventory/utilityMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../Components/icon.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({super.key});

  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}


class _EquipmentScreenState extends State<EquipmentScreen> {

  @override
  void initState() {

    super.initState();
    Future.microtask(() => {
      Provider.of<EquipmentService>(context, listen: false).retrieveList()
    });
  }


  @override
  Widget build(BuildContext context) {


    return Consumer<EquipmentService>(
        builder: (context, eqService,child){
          final byPropertyThenLocation = eqService.groupedByPropertyThenLocation;
          return ListView.builder(
            itemCount: byPropertyThenLocation.length,
              itemBuilder: (context, propertyIndex){


              // properties
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.appBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [

                          //property name
                          Flexible(
                            child: Row(
                              spacing: 20,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    UtilityMethods.capitalizeEachWord(byPropertyThenLocation.keys.elementAt(propertyIndex)),
                                    softWrap: true,
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
                                    AppIcon(icon: Symbols.edit, weight: 200,color: AppColors.activeColor,),
                                    AppIcon(icon: Symbols.delete, weight: 200,color: AppColors.inactiveColor,),

                                  ],
                                ),
                              ],
                            ),
                          ),


                          // List of locations
                          Flexible(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: byPropertyThenLocation.values.elementAt(propertyIndex).length,
                                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 280,
                                  mainAxisExtent: 100,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 4
                                ),
                                itemBuilder: (context, locationIndex){


                                  return InkWell(
                                    onTap: (){
                                      showCupertinoSheet(
                                        enableDrag: true,
                                        useNestedNavigation: true,
                                        context: context,
                                        builder: (context){


                                          // location sheet
                                          return LocationSheet(
                                            locationIndex: locationIndex,
                                            propertyIndex: propertyIndex,
                                            byPropertyThenLocation: byPropertyThenLocation,
                                          );

                                        }
                                      );
                                    },

                                    // location name
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.appDarkBlue,
                                        borderRadius: BorderRadius.circular(8)
                                      ),

                                      padding: EdgeInsets.all(12),
                                        margin: EdgeInsets.all(12),
                                        child: Center(

                                          // location name
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              UtilityMethods.capitalizeEachWord(byPropertyThenLocation.values.elementAt(propertyIndex).keys.elementAt(locationIndex)),
                                              style: TextStyle(
                                                fontSize: 14
                                              ),
                                          )
                                        )
                                    ),
                                  );
                                },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
          );
        }
    );


  }
}
