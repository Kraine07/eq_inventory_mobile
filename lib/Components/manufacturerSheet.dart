


import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../Model/manufacturerModel.dart';
import '../Service/manufacturer_service.dart';
import '../theme.dart';
import 'icon.dart';
import 'manufacturerForm.dart';
import 'manufacturerTile.dart';

class ManufacturerSheet extends StatefulWidget {
  const ManufacturerSheet({
    super.key,
    // required this.manufacturerList,
  });

  // final List<ManufacturerModel> manufacturerList;

  @override
  State<ManufacturerSheet> createState() => _ManufacturerSheetState();
}

class _ManufacturerSheetState extends State<ManufacturerSheet> {

  @override
  Widget build(BuildContext context) {

    List<ManufacturerModel> manufacturerList = Provider.of<ManufacturerService>(context, listen: true).manufacturerList;

    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Text("Manufacturer Management",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context) =>

                          //  manufacturer form
                            ManufacturerForm()
                      );
                    },


                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.appDarkBlue40,
                          borderRadius: BorderRadius.circular(8)

                      ),
                      child: Row(
                        spacing: 4,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppIcon(icon: Symbols.add, weight: 300,size: 20,),
                          Text("Add Manufacturer",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              ManufacturerTile(manufacturers: manufacturerList,)
            ],
          ),
        );

  }
}



