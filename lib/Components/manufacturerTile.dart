

import 'dart:convert';

import 'package:equipment_inventory/Components/modelForm.dart';
import 'package:equipment_inventory/Model/manufacturerModel.dart';
import 'package:equipment_inventory/Model/modelModel.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

import '../Service/manufacturerService.dart';
import '../Service/modelService.dart';
import '../messageHandler.dart';
import '../utilityMethods.dart';
import 'icon.dart';

class ManufacturerTile extends StatefulWidget {

  final List<ManufacturerModel> manufacturers;
  const ManufacturerTile({
    super.key,
    required this.manufacturers,
  });

  @override
  State<ManufacturerTile> createState() => _ManufacturerTileState();
}






Future<void> _deleteManufacturer(BuildContext context, BigInt? id) async{
  ManufacturerService manufacturerService = Provider.of<ManufacturerService>(context, listen: false);


  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false, // prevent closing by tapping outside
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  Response? response = await manufacturerService.deleteManufacturer(id);
  Navigator.pop(context); // close loading dialog

  if( response?.statusCode == 200){
    manufacturerService.retrieveManufacturerList();
    MessageHandler.showMessage(context, message: "Manufacturer deleted successfully");
    Navigator.pop(context);
  }
  else{
    String errorMessage = "Error deleting manufacturer";
    if(response?.body.isNotEmpty == true){
      try{
        final decoded = jsonDecode(response!.body);
        if(decoded is Map && decoded.containsKey("error")){
          errorMessage = decoded["error"];
        }
      }
      catch(_){}
    }
    MessageHandler.showMessage(context, message: errorMessage);

  }
  print(response?.statusCode);
}







class _ManufacturerTileState extends State<ManufacturerTile> {
  @override
  Widget build(BuildContext context) {
    final List<ModelModel> models = Provider.of<ModelService>(context).modelList;

    return Expanded(
      child: SingleChildScrollView(
          child: ExpansionPanelList.radio(
            materialGapSize: 20,
            expandedHeaderPadding: EdgeInsets.symmetric(vertical: 20),
            dividerColor: AppColors.appLightBlue,
            children: widget.manufacturers.map((manufacturer) {

              final List<ModelModel> manufacturerModels = models.where((model) =>
              model.manufacturer.id == manufacturer.id).toList();


              return ExpansionPanelRadio(
                  backgroundColor: AppColors.appDarkBlue40,
                  value: widget.manufacturers.indexOf(manufacturer),
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Text(UtilityMethods.capitalizeEachWord(manufacturer.name ?? ""),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),


                          // manufacturer action buttons
                          Visibility(
                              visible: isExpanded,
                              child: Row(
                                spacing: 4,
                                mainAxisSize: MainAxisSize.min,
                                children: [


                                  // delete manufacturer button
                                  InkWell(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AlertDialog(
                                                  title: Text("Delete Manufacturer"),
                                                  content: Text("Are you sure you want to delete this manufacturer?"),
                                                  actions: [

                                                    TextButton(onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                      child: Text("No")
                                                    ),


                                                    TextButton(onPressed: (){
                                                      _deleteManufacturer(context,manufacturer.id);
                                                    },


                                                      child: Text("Yes")
                                                    )
                                                  ],
                                                )
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AppIcon(icon: Symbols.delete, weight: 300, color: AppColors.inactiveColor,),
                                      )
                                  ),




                                  // edit model button
                                  InkWell(
                                    onTap: (){

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AppIcon(icon: Symbols.stylus, weight: 300,color: AppColors.accentColor,),
                                    ),
                                  ),
                                ],
                              )
                          ),




                        ],
                      ),
                    );
                  },
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                     InkWell(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    ModelForm(manufacturer: manufacturer)
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                              decoration: BoxDecoration(
                                  color: AppColors.appLightBlue.withAlpha(80),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 8,
                                children: [
                                  AppIcon(icon: Symbols.add, weight: 300, ),
                                  Text("Model")
                                ],
                              ))),


                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: manufacturerModels.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 2.5),
                        itemBuilder: (context, index){


                          return Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.appLightBlue.withAlpha(100),
                                  offset: Offset(-2, -2),
                                  blurStyle: BlurStyle.solid


                                ),
                                BoxShadow(
                                  color: AppColors.appDarkBlue,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                  // blurStyle: BlurStyle.solid

                                ),
                              ],

                              color: AppColors.appBlue,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: Text(UtilityMethods.capitalizeEachWord(manufacturerModels[index].description ?? ""),

                              ),
                            )
                          );
                        }
                      ),
                    ],
                  )
              );
            }).toList()
          )
      ),
    );
  }
}