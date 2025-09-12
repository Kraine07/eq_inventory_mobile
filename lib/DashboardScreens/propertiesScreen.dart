import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/Components/propertySheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

import '../Service/propertyService.dart';
import '../theme.dart';
import '../utilityMethods.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({super.key});

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {



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
              return PropertySheet(
                property: property,
                index: index,
              );
            }
            );
      }
    );
  }
}
