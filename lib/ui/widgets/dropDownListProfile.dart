
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helper_finder/core/utils/constants.dart';
import 'package:helper_finder/ui/screens/profile_update/profile_update_view_model.dart';
import 'package:provider/provider.dart';

import '../screens/sign_up_screen/sign_up_screen_view_model.dart';

class DropDownListProfile extends StatelessWidget {
  const DropDownListProfile({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Consumer<ProfileUpdateProvider>(builder: (context, register, child) {
      return Container(
        margin:const  EdgeInsets.symmetric(vertical: 10),
        padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButton<String>(

          isExpanded: true,
          value: register.dropDownItems[register.dropDownVal],
          items: register.dropDownItems
              .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Container( margin:const  EdgeInsets.symmetric(vertical: 10),
                            padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: size.width * 0.8,

                            child: Text(value)),
                      ))
              .toList(),
          onChanged: (v) {
            // get index
            int index = register.dropDownItems.indexOf(v!);
            register.setDropDownVal(index);
          },
        ),

      );
    });
  }
}
