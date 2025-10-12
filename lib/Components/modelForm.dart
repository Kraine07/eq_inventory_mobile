import 'dart:convert';

import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:equipment_inventory/Model/manufacturerModel.dart';
import 'package:equipment_inventory/messageHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';


import '../Service/model_service.dart';
import 'icon.dart';

class ModelForm extends StatelessWidget {

  final ManufacturerModel manufacturer;
  ModelForm({super.key, required this.manufacturer});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _modelController = TextEditingController();






  Future<void> _addModel( BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      ModelService modelService = Provider.of<ModelService>(context, listen: false);
      final model = {
        'description': _modelController.text,
        'manufacturer': manufacturer.toJson()
      };

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      Response? response = await modelService.addModel(model);
      Navigator.pop(context);


      if (response != null && response.statusCode == 200) {
        modelService.retrieveModelList();
        MessageHandler.showMessage(context, message: "Model added successfully");
        Navigator.pop(context);
      }
      else{
        String errorMessage = "Error adding model";
        if (response?.body.isNotEmpty == true) {
          try {
            final decoded = jsonDecode(response!.body);
            if (decoded is Map && decoded.containsKey("error")) {
              errorMessage = decoded["error"];
            }
          } catch (_) {}

        }
        MessageHandler.showMessage(context, message: errorMessage, isSuccessMessage: false);
      }
    }
  }







  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Model"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppInputField(controller: _modelController, obscureText: false, validator:(val){ if(val == null || val.isEmpty){ return "Model name is required";} return null;}, icon: AppIcon(icon: Symbols.manufacturing, weight: 300), onChanged: (val){}, label: "Description",)
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
            _addModel(context);
          },

          child: Text("Add",),
        )
      ],

    );


  }




}

