



import 'dart:convert';

import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:equipment_inventory/Service/manufacturerService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../messageHandler.dart';
import 'icon.dart';

class ManufacturerForm extends StatelessWidget {
   ManufacturerForm({
    super.key,
    // required this.manufacturerController,
  });

  final TextEditingController _manufacturerController =
  TextEditingController();
  final _formKey = GlobalKey<FormState>();






   Future<void> addManufacturer(BuildContext context) async {
     if (_formKey.currentState!.validate()) {
       ManufacturerService manufacturerService = Provider.of<ManufacturerService>(context, listen: false);


       // Show loading dialog
       showDialog(
         context: context,
         barrierDismissible: false, // prevent closing by tapping outside
         builder: (context) => const Center(child: CircularProgressIndicator()),
       );



       final manufacturerData = {
         'name': _manufacturerController.text,
       };

       Response? response = await manufacturerService.addManufacturer(manufacturerData);

       Navigator.pop(context); // close loading dialog

       if (response != null && response.statusCode == 201) {
         manufacturerService.retrieveManufacturerList();
         MessageHandler.showMessage(context, message: "Manufacturer added successfully");
         // MessageHandler.showMessage(context, "Manufacturer added successfully", true);
         Navigator.pop(context); // close manufacturer form
       } else {


         // show backend or default error message
         String errorMessage = "Error adding manufacturer";
         if (response?.body.isNotEmpty == true) {
           try {
             final decoded = jsonDecode(response!.body);
             if (decoded is Map && decoded.containsKey("error")) {
               errorMessage = decoded["error"];
             }
           } catch (_) {}
         }
         MessageHandler.showMessage(context,message:  errorMessage, isSuccessMessage: false);
       }
     }
   }








   @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Text("Add Manufacturer"),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppInputField(
                  fontSize: 12,
                    label: "Manufacturer name",
                    controller: _manufacturerController,
                    obscureText: false,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Manufacturer name is required";
                      }
                      return null;
                    },
                    icon: AppIcon(icon: Symbols.manufacturing, weight: 300,),
                    onChanged: (value){}
                )
              ],
            )
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
            addManufacturer(context);
          },
          child: Text("Add",),
        )
      ],
    );
  }
}