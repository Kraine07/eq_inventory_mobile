import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:equipment_inventory/utilityMethods.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../Service/app_header_service.dart';
import '../Service/user_service.dart';
import '../loadPage.dart';
import '../theme.dart';
import 'icon.dart';

class Heading extends StatefulWidget {


  final String name;


   Heading({
     super.key,
     required this.name,
  });



  @override
  State<Heading> createState() => _HeadingState();
}



class _HeadingState extends State<Heading> {

  List<String> menuItems = ["update password", "logout"];
  @override
  Widget build(BuildContext context) {

    final TextEditingController _searchController = TextEditingController();

    final AppHeader appHeader = Provider.of<AppHeader>(context);
    return Material(
      color: AppColors.appDarkBlue.withValues(alpha: 0.8),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween
              ,
              spacing: 20,
              children: [

                Text(UtilityMethods.capitalizeEachWord(appHeader.header ?? ""),
                  style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w300,
                      fontSize: 24
                  ),
                ),


                PopupMenuButton<String>(
                  onSelected: (String value){


                    if(value == "update password"){
                      //show update password screen
                      UtilityMethods.showUpdatePassword(context);
                    }


                    else if(value == "logout"){
                      //logout
                      Provider.of<UserService>(context, listen: false).logout();
                      Navigator.of(context).popUntil((route) => route.isFirst);

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadPage()));
                    }
                  },
                  icon: AppIcon(icon: Symbols.menu, weight: 300,size: 32,),
                    itemBuilder: (context){
                    return menuItems.map((item) {
                       return PopupMenuItem<String>(
                        value: item,
                        child: Text(UtilityMethods.capitalizeEachWord(item)),
                      );
                    }).toList();
                }),
                // AppIcon(icon: Symbols.menu, weight: 300,size: 32,)
              ],
            ),



            Text(UtilityMethods.capitalizeEachWord(widget.name),
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary
              ),
            ),



            Center(
              child: AppInputField(
                label: "Search",
                radius: 1000.0,
                borderStyle: BorderStyle.none,
                controller: _searchController,
                obscureText: false,
                validator: (val){},
                icon: AppIcon(icon: Symbols.search, weight: 300,size: 18,),
                  fontSize: 14,
                  verticalPadding: 4,
                onChanged: (val){}
              ),
            ),
          ],
        ),
      ),
    );
  }
}
