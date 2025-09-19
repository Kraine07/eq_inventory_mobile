import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:equipment_inventory/Model/propertyModel.dart';
import 'package:equipment_inventory/Service/propertyService.dart';
import 'package:equipment_inventory/yearMonth.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../Model/locationModel.dart';
import '../theme.dart';
import '../utilityMethods.dart';
import 'icon.dart';

class EquipmentForm extends StatefulWidget {
  final List<PropertyModel> propertyList;
  const EquipmentForm({
    super.key,
    required this.propertyList
  });

  @override
  State<EquipmentForm> createState() => _EquipmentFormState();
}

class _EquipmentFormState extends State<EquipmentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
   LocationModel? _selectedLocation;



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
    Future.microtask(() => {
      Provider.of<PropertyService>(context, listen: false).retrieveLocationList(),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyService>(
      builder: (context, propertyService, child) {


          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 12,
                  children: [



                    DropdownButtonFormField<LocationModel>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: "Location",
                        prefixIcon: AppIcon(icon: Symbols.apartment, weight: 300),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.borderColor,
                            width: 1.0
                          )
                        ),

                          // focused border style
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColors.appWhite,
                                  width: 3.0
                              )
                          ),


                          // error border style
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColors.accentColor,
                                  width: 1.0
                              )
                          ),

                          // focused error border style
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColors.accentColor,
                                  width: 3.0
                              )
                          )
                      ),


                      items: widget.propertyList.expand((property) {
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
                      }).toList(),

                      onChanged: (value) {
                        // Handle selection
                        if (value != null) {
                          setState(() {
                            _selectedLocation = value;
                          });
                        }
                      },

                      selectedItemBuilder: (context) {
                        return widget.propertyList.expand((property) {
                          final locations = propertyService.retrieveLocationsAtProperty(property);

                          // Return property header + location items to match the original items list
                          return [
                            // Property header (disabled item)
                            Text(
                              UtilityMethods.capitalizeEachWord(property.name ?? ""),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: AppColors.appWhite,
                              ),
                            ),
                            // Location items
                            ...locations.map((location) {
                              return Text(
                                UtilityMethods.capitalizeEachWord("${property.name} - ${location.name}"),
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              );
                            }),
                          ];
                        }).toList();
                      },

                      // Add value to track selection
                      initialValue: _selectedLocation,
                    ),








                    AppInputField(
                        label: "Model",
                        controller: _modelController,
                        obscureText: false,
                        validator: (val) => null,
                        icon: AppIcon(icon: Symbols.manufacturing,
                            weight: 500),
                        onChanged: (val) => {}
                    ),


                    AppInputField(
                        label: "Serial Number",
                        controller: _serialNumberController,
                        obscureText: false,
                        validator: (val) => null,
                        icon: AppIcon(icon: Symbols.barcode, weight: 500),
                        onChanged: (val) => {}
                    ),

                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      // prevent keyboard
                      decoration: const InputDecoration(
                        labelText: "Select Date",
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
                            Navigator.of(context).pop();
                          },
                          child: Text("Add Equipment")
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );

      });
  }
}
