

import 'package:equipment_inventory/Components/equipmentForm.dart';
import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/Components/locationsAtProperty.dart';
import 'package:equipment_inventory/Model/manufacturerModel.dart';
import 'package:equipment_inventory/Service/equipmentService.dart';
import 'package:equipment_inventory/Service/manufacturerService.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:equipment_inventory/utilityMethods.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'package:provider/provider.dart';

import '../Components/manufacturerTile.dart';
import '../Model/locationModel.dart';
import '../Service/propertyService.dart';
import '../Service/userService.dart';

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
      Provider.of<EquipmentService>(context, listen: false).retrieveList(),
      Provider.of<PropertyService>(context, listen: false).retrievePropertyList(),
      Provider.of<ManufacturerService>(context, listen: false).retrieveManufacturerList(),
      Provider.of<ManufacturerService>(context, listen: false).retrieveModelList(),
    });
  }


  @override
  Widget build(BuildContext context) {

    final authUser = Provider.of<UserService>(context).authUser;
    final propertyList = Provider.of<PropertyService>(context).propertyList;

    return Consumer2<EquipmentService, ManufacturerService>(
      builder: (context, eqService, manufacturerService, child){

        final equipmentList = eqService.equipmentList;
        final manufacturerList = manufacturerService.manufacturerList;

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // manufacturers/models management button
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          backgroundColor: AppColors.appLightBlue,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height *.9,
                            maxWidth: 960,
                            minHeight: MediaQuery.of(context).size.height *.7
                          ),
                          context: context,
                          builder: (context){
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                spacing: 20,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Center(child: Text("Manufacturers/Models",)),
                                  ),
                                  ManufacturerTile(manufacturers: manufacturerList,)
                                ],
                              ),
                            );

                          }
                        );
                      },
                      child: Container(
                        padding:  EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.appDarkBlue40,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(icon: Symbols.manufacturing, weight: 300),
                            Text("Manufacturers/Models")
                          ]
                        ),
                      ),
                    ),




                    // add equipment button
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height *.7,
                            maxWidth: 960,
                            minHeight: MediaQuery.of(context).size.height *.5
                          ),
                          context: context,
                          builder: (BuildContext sheetContext){
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: EquipmentForm(),
                            );
                          }
                        );

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: AppColors.appDarkBlue40,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(
                          spacing: 8,
                          children: [
                            AppIcon(icon: Symbols.add, weight: 300),
                            Text("New Equipment")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),



                // property list
                ExpansionPanelList.radio(
                  elevation: 0,
                  dividerColor: AppColors.borderColor,
                  expandedHeaderPadding: EdgeInsets.symmetric(vertical: 20),
                  materialGapSize: 20,
                  children: propertyList.where((property) => (authUser?.isAdmin ?? false || property.user?.id == authUser?.id) && equipmentList.any((eq) => eq.location?.property?.id == property.id) ).map((property) {



                    // create a set of locations for this property
                    Set<LocationModel> locations = Set();

                    equipmentList.forEach((eq) {
                      if (eq.location?.property?.id == property.id && !locations.contains(eq.location)) {
                        locations.add(eq.location!);
                      }
                    });

                    return ExpansionPanelRadio(
                      canTapOnHeader: true,
                      backgroundColor: AppColors.appDarkBlue40,
                      value: propertyList.indexOf(property),
                      headerBuilder: (BuildContext context, bool isExpanded) => Padding(
                        padding: const EdgeInsets.all(20.0),

                        // property name
                        child:  Text(UtilityMethods.capitalizeEachWord(property.name??"",)),
                      ),


                      body: LocationsAtProperty(locations: locations, context: context,equipmentList: equipmentList,),
                    );

                  }).toSet().toList(),


                ),
              ],
            )
          ),
        );
      }
    );
  }
}

