import 'package:flutter/material.dart';

import '../Model/equipmentModel.dart';
import '../theme.dart';
import '../utilityMethods.dart';

class LocationSheet extends StatefulWidget {

  final int locationIndex;
  final int propertyIndex;
  final Map<String, Map<String, List<EquipmentModel>>> byPropertyThenLocation;


  LocationSheet({
    super.key,
    required this.locationIndex,
    required this.propertyIndex,
    required this.byPropertyThenLocation
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
            Text(widget.byPropertyThenLocation.values.elementAt(widget.propertyIndex).keys.elementAt(widget.locationIndex).toUpperCase(),
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.byPropertyThenLocation.values.elementAt(widget.propertyIndex).values.elementAt(widget.locationIndex).length,

                  itemBuilder: (context, gIndex) {
                    EquipmentModel currentEquipment = widget.byPropertyThenLocation.values.elementAt(widget.propertyIndex).values.elementAt(widget.locationIndex).elementAt(gIndex);


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
