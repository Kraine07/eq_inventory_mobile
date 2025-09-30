
import 'package:equipment_inventory/Components/equipmentForm.dart';
import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/Model/equipmentModel.dart';
import 'package:equipment_inventory/loadPage.dart';
import 'package:equipment_inventory/messageHandler.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../Service/equipmentService.dart';
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

    EquipmentService equipmentService = Provider.of<EquipmentService>(context, listen: false);


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
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Material(
                color: Colors.transparent,
                textStyle: TextStyle(
                  fontSize: 12
                ),
                child: Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    // edit button
                    InkWell(
                      onTap: (){
                        showBottomSheet(
                            context: context,
                            builder: (context){
                              return EquipmentForm(equipment: widget.equipment, isEditing: true,);
                            }
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.appDarkBlue40
                        ),
                        padding: EdgeInsets.all(12),

                        child: AppIcon(icon: Symbols.edit, weight: 500,size: 16,),
                      ),
                    ),





                    // delete button
                    InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              
                              // delete confirmation dialog
                              return AlertDialog(
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 12,
                                  children: [
                                    AppIcon(icon: Symbols.warning, weight: 300),
                                    Text("Delete Equipment"),
                                  ],
                                ),
                                content: Text("Are you sure you want to delete this equipment?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }, 
                                      child: AppIcon(icon: Symbols.close, weight: 500)),

                                  TextButton(
                                      onPressed: () async{
                                        Response deleteResponse = await equipmentService.post(endpoint: "api/v1/delete-equipment/${widget.equipment.id}", data: {});
                                        if(deleteResponse.statusCode == 200){


                                          MessageHandler.showMessage(context, message: "Equipment deleted successfully");
                                        }
                                        else{
                                          MessageHandler.showMessage(context, message: "Error deleting equipment", isSuccessMessage: false);
                                        }

                                        equipmentService.retrieveList();
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context){
                                          return LoadPage();
                                        }));
                                      }, 
                                      child: AppIcon(icon: Symbols.check, weight: 500, ))
                                ],

                              );
                            }

                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.accentColor40
                        ),
                        padding: EdgeInsets.all(12),

                        child: AppIcon(icon: Symbols.delete, weight: 500,size: 16,),
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
