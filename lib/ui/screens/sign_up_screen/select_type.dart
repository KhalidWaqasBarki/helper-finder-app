import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../authentication/authenticate_view_model.dart';
import 'sign_up_screen_view_model.dart';
class SelectUserType extends StatelessWidget {
  const SelectUserType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Consumer<SignUpProvider>(
      builder: (context, register, child) {
        return  SizedBox(
          width: size.width,
          height: size.height/2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
           child: Stack(
              children: [

               Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 5,
                        child: Center(
                          child: Image.asset(
                            "assets/images/worker.png",
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Card(



                         color: Colors.black54,
                        shadowColor: Colors.black12,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                          child: InkWell(
                            onTap: (){
                              register.setSelectType(1);
                              register.setType("client");
                            },
                            child: Container(
                              color: Colors.black12,
                              height: 50,
                              width: size.width/2.5,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(

                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(8)
                                  ),

                                  child:const Center(child:  Text("I need a Worker",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(



                         color: Colors.black54,
                        shadowColor: Colors.black12,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                          child: InkWell(
                            onTap: (){
                              register.setSelectType(2);
                              register.setType("worker");
                            },
                            child: Container(
                              color: Colors.black12,
                              height: 50,
                              width: size.width/2.5,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(

                                    color:kPrimaryColor,
                                    borderRadius: BorderRadius.circular(8)
                                  ),

                                  child:const Center(child:  Text("Register as a Worker",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          final auth = Provider.of<AuthProvider>(context, listen: false);
                          auth.toggleView();

                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
