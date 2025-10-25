
import 'package:cached_network_image/cached_network_image.dart';
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

import '../Service/equipment_service.dart';
import '../equipment_image_page.dart';
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

    EquipmentService equipmentService = Provider.of<EquipmentService>(context);
    final String endPoint = "/api/v1/find-by-equipment?equipmentId=${widget.equipment.id}";
    final String imageUrl= "${equipmentService.baseURL}$endPoint";



    final Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      // height: 120,
      width: 180,
      fit: BoxFit.contain,
      placeholder: (context, url) => Image.asset(
        'assets/images/placeholder_image.png',
        // height: 120,
        width: 180,
        fit: BoxFit.contain,
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/placeholder_image.png',
        // height: 120,
        width: 180,
        fit: BoxFit.contain,
      ),
    );




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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Lazy-load equipment image
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context){
                          return EquipmentImagePage(image: image, equipmentId: widget.equipment.id);
                        }));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: image
                      ),
                    ),



                    //equipment info
                    Expanded(
                      // flex: 2,
                      child: Column(
                        spacing: 12,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(UtilityMethods.capitalizeEachWord("${widget.equipment.model?.manufacturer.name} ${widget.equipment.model?.description}",),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,),
),

                              Text(widget.equipment.serialNumber?.toUpperCase() ?? "",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1
                                ),
                              ),
                            ],
                          ),


                          // action buttons
                          Row(
                            spacing: 20,
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              // edit button
                              InkWell(
                                onTap: (){

                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    showBottomSheet(
                                        context: context,
                                        builder: (context){
                                          return EquipmentForm(equipment: widget.equipment, isEditing: true,);
                                        }
                                    );
                                  });

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

                                  WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                  });

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

                        ],
                      ),
                    ),



                  ],
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
