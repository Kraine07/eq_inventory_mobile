import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/Service/propertyService.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

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
      Provider.of<PropertyService>(context, listen: false).retrieveList()
    });
  }


  @override
  Widget build(BuildContext context) {



    return Consumer<PropertyService>(
      builder: (context,property, child) {
        return GridView.builder(
          itemCount: property.propertyList.length,
          padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3 / 1
            ),

            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  // show property sheet
                  showCupertinoSheet(
                    useNestedNavigation: true,
                    context: context, builder: (BuildContext context){
                      return Material(
                        child: Container(
                          child: Text(property.propertyList[index].name.toString().toUpperCase())),
                      );
                    }
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.appLightBlue,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: Center(
                    child: Text(
                      property.propertyList[index].name.toString().toUpperCase(),
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
              );
            }
            );
      }
    );
  }
}
