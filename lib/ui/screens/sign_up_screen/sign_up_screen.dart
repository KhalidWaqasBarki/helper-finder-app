import 'package:flutter/material.dart';
import 'package:helper_finder/ui/screens/sign_up_screen/registration.dart';
import 'package:helper_finder/ui/screens/sign_up_screen/select_type.dart';
import 'package:helper_finder/ui/screens/sign_up_screen/worker_details.dart';
import 'package:provider/provider.dart';
import 'sign_up_screen_view_model.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<SignUpProvider>(
      builder: (context, register, child) {
        return SizedBox(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                register.selectType==0
                    ? const SelectUserType()
                    :  register.selectType==1
                    ? const Registration()
                    : register.selectType==2
                    ? const WorkerDetails()
                    :
                const Registration()
              ],
            ),
          );
      },
    );
  }
}
