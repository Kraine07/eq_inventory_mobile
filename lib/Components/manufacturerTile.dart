
import 'package:equipment_inventory/Model/manufacturerModel.dart';
import 'package:equipment_inventory/Model/modelModel.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Service/manufacturerService.dart';
import '../utilityMethods.dart';

class ManufacturerTile extends StatelessWidget {

  final List<ManufacturerModel> manufacturers;
  const ManufacturerTile({
    super.key,
    required this.manufacturers,
  });



  @override
  Widget build(BuildContext context) {
    
    final List<ModelModel> models = Provider.of<ManufacturerService>(context).modelList;
    
    return Expanded(
      child: SingleChildScrollView(
          child: ExpansionPanelList.radio(
            materialGapSize: 20,
            expandedHeaderPadding: EdgeInsets.symmetric(vertical: 20),
            dividerColor: AppColors.appLightBlue,
            children: manufacturers.map((manufacturer) {

              final List<ModelModel> manufacturerModels = models.where((model) =>
              model.manufacturer.id == manufacturer.id).toList();

              return ExpansionPanelRadio(
                  backgroundColor: AppColors.appDarkBlue40,
                  value: manufacturers.indexOf(manufacturer),
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(UtilityMethods.capitalizeEachWord(manufacturer.name ?? ""),),
                    );
                  },
                  body: GridView.builder(
                    shrinkWrap: true,
                    itemCount: manufacturerModels.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 2.5),
                    itemBuilder: (context, index){


                      return Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.appDarkBlue40,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Center(
                          child: Text(UtilityMethods.capitalizeEachWord(manufacturerModels[index].description ?? "")),
                        )
                      );
                    }
                  )
              );
            }).toList()
          )
      ),
    );
  }
}