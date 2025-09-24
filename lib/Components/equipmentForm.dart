import 'dart:convert';

import 'package:equipment_inventory/Components/appDropDownInput.dart';
import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:equipment_inventory/Model/equipmentModel.dart';
import 'package:equipment_inventory/Model/modelModel.dart';
import 'package:equipment_inventory/Service/equipmentService.dart';
import 'package:equipment_inventory/Service/manufacturerService.dart';
import 'package:equipment_inventory/Service/propertyService.dart';
import 'package:equipment_inventory/messageHandler.dart';
import 'package:equipment_inventory/yearMonth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../Model/locationModel.dart';
import '../theme.dart';
import '../utilityMethods.dart';
import 'icon.dart';

class EquipmentForm extends StatefulWidget {
  final EquipmentModel? equipment;
  final LocationModel? selectedLocation;
  final bool fromLocation;
  final bool isEditing;


  const EquipmentForm({
    super.key,
    this.selectedLocation,
    this.fromLocation = false,
    this.isEditing = false,
    this.equipment
  });

  @override
  State<EquipmentForm> createState() => _EquipmentFormState();
}

class _EquipmentFormState extends State<EquipmentForm> {
  final _formKey = GlobalKey<FormState>();
   BigInt? _equipmentId= null;
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late LocationModel? _selectedLocation = widget.selectedLocation;
  ModelModel? _selectedModel;





  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text =
        YearMonth.fromString("${picked.year}-${picked.month}").toString();
        ;
      });
    }
  }


  @override
  void initState() {

    super.initState();

    if(widget.equipment != null){
      _equipmentId = widget.equipment?.id;
      _selectedLocation = widget.equipment?.location;
      _selectedModel = widget.equipment?.model;
      _serialNumberController.text = widget.equipment?.serialNumber ?? "";
      _dateController.text = widget.equipment?.manufacturedDate.toString()??"";
    }

    Future.microtask(() => {
      Provider.of<PropertyService>(context, listen: false).retrieveLocationList(),
      Provider.of<ManufacturerService>(context, listen: false).retrieveManufacturerList(),
      Provider.of<ManufacturerService>(context, listen: false).retrieveModelList(),
    });
  }


  @override
  Widget build(BuildContext context) {




    // submit form



    void submitForm() async {
      if (_formKey.currentState!.validate()) {
        final equipmentService = EquipmentService();

        final equipmentData = {
          'id': _equipmentId != null ? _equipmentId.toString() : null,
          'serialNumber': _serialNumberController.text,
          'manufacturedDate': _dateController.text,
          'model': _selectedModel?.toJson(),
          'location': _selectedLocation?.toJson(),
        };

        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false, // prevent closing by tapping outside
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );

        try {
          final Response addEquipmentResponse = await equipmentService.post(
            endpoint: "api/v1/save-equipment",
            data: equipmentData,
          );

          Navigator.pop(context); // close loading dialog

          if (addEquipmentResponse.statusCode == 200) {
            final Map<String, dynamic> responseBody =
            jsonDecode(addEquipmentResponse.body);

            if (responseBody.isNotEmpty) {
              MessageHandler.showMessage(
                context,
                "Equipment added successfully",
                true,
              );
            }
          } else {
            MessageHandler.showMessage(context, "Error adding equipment", false);
          }
        } catch (e) {
          Navigator.pop(context); // close loading dialog if error
          MessageHandler.showMessage(context, "Something went wrong: $e", false);
        }

        // Refresh equipment list after request finishes
        Provider.of<EquipmentService>(context, listen: false).retrieveList();
        Navigator.pop(context); // close equipment form
      }
    }








    return Consumer2<PropertyService, ManufacturerService>(
      builder: (context, propertyService, manufacturerService, child) {


          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 12,
                  children: [

                    // Property/location dropdown
                    Visibility(
                      visible: !widget.fromLocation,
                      child: AppDropdownInput(
                        selectedItem: _selectedLocation,
                        // type: s,
                        prefixIcon: AppIcon(icon: Symbols.apartment, weight: 300),
                          labelText: "Location",

                          items: locationListBuilder(propertyService),

                          onChanged: (value) {
                            // Handle selection
                            if (value != null) {
                              setState(() {
                                _selectedLocation = value as LocationModel?;
                              });
                            }
                          },


                          selectedItemBuilder: (context) {
                          return propertyService.propertyList.expand((property) {
                            final locations = propertyService
                                .retrieveLocationsAtProperty(property);

                            // Return property header + location items to match the original items list
                            return [


                              // Property header (disabled item)
                              Text(
                                UtilityMethods.capitalizeEachWord(
                                    property.name ?? ""),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.appWhite,
                                ),
                              ),


                              // Location items
                              ...locations.map((location) {
                                return Text(
                                  UtilityMethods.capitalizeEachWord(
                                      "${property.name} - ${location.name}"),
                                  style: const TextStyle(
                                    // fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                );
                              }),


                            ];
                          }).toList();
                        }
                      ),
                    ),






                    // Manufacturer/model dropdown
                    AppDropdownInput<ModelModel>(
                      prefixIcon: AppIcon(icon: Symbols.factory, weight: 300),
                      labelText: "Model",
                      selectedItem: _selectedModel,


                      // items
                      items: modelListBuilder(manufacturerService),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedModel = value;
                          });
                        }
                      },


                      // selected items
                      selectedItemBuilder: (context) {
                        // What to show when something is selected
                        return manufacturerService.manufacturerList.expand((manufacturer) {


                            final models = Text(
                              UtilityMethods.capitalizeEachWord(manufacturer.name ?? ""),
                              style:  TextStyle(
                                fontSize: 20,
                              ),
                            );


                            // Models under this manufacturer
                            final modelItems = manufacturerService.modelList
                                .where((m) => m.manufacturer.id == manufacturer.id)
                              .map((model) {
                          return Text(
                          UtilityMethods.capitalizeEachWord("${model.manufacturer.name} - ${model.description}"),
                          style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          ),
                          );
                          });

                          return [models, ...modelItems];


                        }).toList();
                      },
                    ),







                    //Serial number
                    AppInputField(
                        label: "Serial Number",
                        controller: _serialNumberController,
                        obscureText: false,
                        validator: (val) => null,
                        icon: AppIcon(icon: Symbols.barcode, weight: 500),
                        onChanged: (val) => {}
                    ),






                    //Manufactured date
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      // prevent keyboard
                      decoration: const InputDecoration(
                        prefixIcon: AppIcon(icon: Symbols.calendar_add_on, weight: 300),
                        labelText: "Manufactured Date",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => _pickDate(context),
                      validator: (value) {
                        return null;
                      },
                    ),

                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery
                            .of(context)
                            .size
                            .width,
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            backgroundColor: AppColors.appBlue,
                          ),
                          onPressed: () {
                            submitForm();
                          },
                          child: widget.isEditing ? Text("Update Equipment") : Text("Add Equipment"),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );

      });
  }





  // model list builder
  List<DropdownMenuItem<ModelModel>> modelListBuilder(ManufacturerService manufacturerService) {
    return manufacturerService.manufacturerList.expand((manufacturer) {
      // Header (non-selectable)
      final header = DropdownMenuItem<ModelModel>(
        value: null,
        enabled: false,
        child: Text(
          UtilityMethods.capitalizeEachWord(manufacturer.name ?? ""),
          style: const TextStyle(
            backgroundColor: AppColors.appLightBlue40,
            decoration: TextDecoration.underline,
            decorationThickness: 2,
            decorationColor: AppColors.appWhite,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      );

      // Models under this manufacturer
      final models = manufacturerService.modelList
          .where((m) => m.manufacturer.id == manufacturer.id) // filter
          .map((model) {
        return DropdownMenuItem<ModelModel>(
          value: model,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              UtilityMethods.capitalizeEachWord(model.description ?? ""),
            ),
          ),
        );
      });

      return [header, ...models];
    }).toList();
  }





  // location list builder
  List<DropdownMenuItem<LocationModel>> locationListBuilder(PropertyService propertyService) {
    return propertyService.propertyList.expand((property) {
      final locations = propertyService.retrieveLocationsAtProperty(property);

      // property header
      final propertyHeader = DropdownMenuItem<LocationModel>(
        value: null,
        enabled: false,
        child: Text(
          UtilityMethods.capitalizeEachWord(property.name ?? ""),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: AppColors.appWhite,
          ),
        ),
      );

      // locations
      final locationItems = locations.map((location) {
        return DropdownMenuItem<LocationModel>(
          value: location,
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
              UtilityMethods.capitalizeEachWord(location.name ?? ""),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          ),
        );
      });

      return [propertyHeader, ...locationItems];
    }).toList();
  }
}
