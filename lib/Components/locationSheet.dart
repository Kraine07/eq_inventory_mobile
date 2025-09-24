import 'package:equipment_inventory/Components/button.dart';
import 'package:flutter/material.dart';

import '../Model/equipmentModel.dart';
import '../Model/locationModel.dart';
import '../theme.dart';
import '../utilityMethods.dart';




class LocationSheet extends StatefulWidget {

  final LocationModel? location;
  final List<EquipmentModel> equipmentList;


  LocationSheet({
    super.key,
    required this.location,
    required this.equipmentList,
  });


  @override
  State<LocationSheet> createState() => _LocationSheetState();
}

class _LocationSheetState extends State<LocationSheet> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          spacing: 20,
          children: [
            Text(widget.location!.name!.toUpperCase(),
            // Text(widget.byPropertyThenLocation.values.elementAt(widget.propertyIndex).keys.elementAt(widget.locationIndex)!.name!.toUpperCase(),
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300
              ),
            ),
            Row(
              children: [
                AppButton(onPressed: (){}, text: "Place equipment",),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.equipmentList.length,

                  itemBuilder: (context, gIndex) {
                    EquipmentModel currentEquipment = widget.equipmentList[gIndex];


                    // equipment at location
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 400
                      ),
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.appDarkBlue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              // equipment info
                              Text("${UtilityMethods.capitalizeEachWord(currentEquipment.model!.manufacturer.name.toString())} ${UtilityMethods.capitalizeEachWord(currentEquipment.model!.description.toString())}",
                                // "${currentEquipment.model!.manufacturer.name!.toUpperCase()} ${currentEquipment.model!.description!.toUpperCase()}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(currentEquipment.serialNumber?.toUpperCase() ?? "",
                                    style: TextStyle(
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16
                                    ),
                                  ),
                                  Text(currentEquipment.manufacturedDate.toString(),
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.italic
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }

              ),
            ),
          ],
        ),
      ),
    );
  }
}
