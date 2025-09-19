import 'package:equipment_inventory/Components/equipmentTile.dart';
import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/Model/equipmentModel.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../theme.dart';
import '../utilityMethods.dart';

class LocationsAtProperty extends StatefulWidget {

  final Set locations;
  final List<EquipmentModel> equipmentList;
  final BuildContext context;

  const LocationsAtProperty({
    super.key,
    required this.locations,
    required this.context,
    required this.equipmentList
  });

  @override
  State<LocationsAtProperty> createState() => _LocationsAtPropertyState();
}

class _LocationsAtPropertyState extends State<LocationsAtProperty> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(20),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.locations.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 60,
            maxCrossAxisExtent: 210,
            childAspectRatio: 2 / 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
        ),

        itemBuilder: (context, index){




          return InkWell(
            onTap: (){
              showBottomSheet(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height*.80,
                  minWidth: 480,
                  maxWidth: 960
                ),
                  context: widget.context,
                  builder: (BuildContext sheetContext){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12,
                      children: [
                        Text("${UtilityMethods.capitalizeEachWord(widget.locations.elementAt(index).name ?? "",)}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w200,
                            )
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                              color: AppColors.appDarkBlue40,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            spacing: 4,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppIcon(icon: Symbols.add, weight: 300),
                              Text("Place equipment here")
                            ],
                          ),
                        ),


                        Column(
                          spacing: 4,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: widget.equipmentList
                              .where((eq) => eq.location == widget.locations.elementAt(index))
                              .map((eq) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: EquipmentTile(equipment: eq),
                          ))
                              .toList(),

                        ),
                      ],
                    );
                  });
            },

            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.appDarkBlue40,
                    borderRadius: BorderRadius.circular(8)
                ),



                // location name
                child: Center(
                    child: Text(UtilityMethods.capitalizeEachWord(widget.locations.elementAt(index).name??"",),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,

                      ),
                    )
                )
            ),
          );
        }
    );
  }
}
