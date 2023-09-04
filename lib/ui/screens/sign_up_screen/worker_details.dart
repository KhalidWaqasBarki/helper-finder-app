import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helper_finder/ui/widgets/dropDownList.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_input_field.dart';
import 'sign_up_screen_view_model.dart';

class WorkerDetails extends StatelessWidget {
  const WorkerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<SignUpProvider>(
      builder: (context, register, child) {
        return SizedBox(
          width: size.width,
          height: size.height / 1.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Worker Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),

                  register.isListEmpty ?const DropDownList():const CircularProgressIndicator(),

                  RoundedInputField(
                    controller: register.otherSkillController,
                    icon: Icons.play_for_work,
                    textInputType: TextInputType.name,
                    hintText: "Other Skills",
                    onChanged: (value) {},
                  ),

                  RoundedInputField(
                    textInputType: TextInputType.number,
                    controller: register.wageController,
                    icon: Icons.currency_pound,
                    hintText: "Daily wage",
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    textInputType: TextInputType.multiline,
                    controller: register.noteController,
                    icon: Icons.note,
                    hintText: "Note",
                    onChanged: (value) {},
                  ),

                  RoundedButton(
                    text: "Next",
                    press: () {
                      if(register.otherSkillController.text.isEmpty){
                        EasyLoading.showError("Other Skill Field is Empty");
                        EasyLoading.dismiss();
                      }else{

                        register.setSelectType(3);
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      register.clearAll(context);

                    },
                  ),
                  SizedBox(height: size.height * 0.03),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
