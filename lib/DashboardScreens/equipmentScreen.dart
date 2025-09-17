

import 'package:equipment_inventory/Service/equipmentService.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:equipment_inventory/utilityMethods.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
      Provider.of<PropertyService>(context, listen: false).retrieveList()
    });
  }


  @override
  Widget build(BuildContext context) {

    final authUser = Provider.of<UserService>(context).authUser;
    final propertyList = Provider.of<PropertyService>(context).propertyList;

    return Consumer<EquipmentService>(
      builder: (context, eqService,child){

        final equipmentList = eqService.equipmentList;

        return SingleChildScrollView(
          child:  ExpansionPanelList.radio(
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
                backgroundColor: AppColors.appDarkBlue,
                value: propertyList.indexOf(property),
                headerBuilder: (BuildContext context, bool isExpanded) => Padding(
                  padding: const EdgeInsets.all(20.0),

                  // property name
                  child:  Text(UtilityMethods.capitalizeEachWord(property.name??"",)),
                ),


                body: GridView.builder(
                  padding: EdgeInsets.all(20),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: locations.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 60,
                      maxCrossAxisExtent: 210,
                      childAspectRatio: 2 / 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20
                    ), 
                    
                    itemBuilder: (context, index){




                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.appLightBlue,
                          borderRadius: BorderRadius.circular(12)
                        ),



                        // location name
                          child: Center(
                            child: Text(UtilityMethods.capitalizeEachWord(locations.elementAt(index).name??"",),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,

                              ),
                            )
                          )
                      );
                    }
                ),
              );

            }).toSet().toList(),


          )
        );
      }
    );
  }
}
