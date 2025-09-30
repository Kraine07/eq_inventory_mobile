import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:equipment_inventory/Model/manufacturerModel.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../Service/manufacturerService.dart';
import 'icon.dart';

class ModelForm extends StatelessWidget {

  final ManufacturerModel manufacturer;
  const ModelForm({super.key, required this.manufacturer});

  @override
  Widget build(BuildContext context) {
    final manufacturerService = Provider.of<ManufacturerService>(context);
    final TextEditingController _modelController = TextEditingController();
    return AlertDialog(
      title: Text("Add Model"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppInputField(controller: _modelController, obscureText: false, validator:(val){}, icon: AppIcon(icon: Symbols.manufacturing, weight: 300), onChanged: (val){}, label: "Description",)
          ],

        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel",),
        ),

        TextButton(
          onPressed: () {
            final model = {
              'description': _modelController.text,
              'manufacturer': manufacturer
            };
            manufacturerService.post(endpoint: "api/v1/add-model", data: model);
            Navigator.pop(context);
          },
          child: Text("Add",),
        )
      ],

    );


  }
}

