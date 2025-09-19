import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/Model/equipmentModel.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../utilityMethods.dart';

class EquipmentTile extends StatefulWidget {
  final EquipmentModel equipment;
  const EquipmentTile({
    super.key, 
    required this.equipment
  });

  @override
  State<EquipmentTile> createState() => _EquipmentTileState();
}

class _EquipmentTileState extends State<EquipmentTile> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.appDarkBlue40,
        // elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              // edit button
              Material(
                color: Colors.transparent,
                textStyle: TextStyle(
                  fontSize: 12
                ),
                child: Row(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.appDarkBlue40
                      ),
                      padding: EdgeInsets.all(12),

                      child: Row(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppIcon(icon: Symbols.edit, weight: 500,size: 16,),
                          Text("Edit")
                        ],
                      ),
                    ),


                    // delete button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.accentColor40
                      ),
                      padding: EdgeInsets.all(12),

                      child: Row(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppIcon(icon: Symbols.delete, weight: 500,size: 16,),
                          Text("Delete")
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              //equipment info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(UtilityMethods.capitalizeEachWord("${widget.equipment.model?.manufacturer.name} ${widget.equipment.model?.description}",)),

                  Text(widget.equipment.serialNumber?.toUpperCase() ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
