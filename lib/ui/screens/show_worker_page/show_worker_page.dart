import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:helper_finder/core/models/worker_model.dart';
import 'package:helper_finder/core/utils/constants.dart';
import 'package:helper_finder/ui/screens/show_worker_page/show_worker_page_view_model.dart';
import 'package:helper_finder/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/build_switch_widget.dart';
import '../../widgets/build_text_widget.dart';

class WorkerProfilePage extends StatelessWidget {
  final WorkerModel model;

  const WorkerProfilePage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    launchCaller() async {
      bool? res = await FlutterPhoneDirectCaller.callNumber(model.phone);
    }
    Size size = MediaQuery
        .of(context)
        .size;
    return ChangeNotifierProvider(
        create: (context) => WorkerProfileProvider(),
        child: Consumer<WorkerProfileProvider>(
          builder: (context, worker, child) {
            return Scaffold(

              appBar: AppBar(
                title: const Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
              body: Container(
                color: Colors.black12,
                width: double.infinity,
                height: size.height,
                child: Stack(
                  children: [

                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height / 6,

                            child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(110),
                                    color: Colors.black12
                                ),
                                child: Container(margin: EdgeInsets.all(2),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(110),
                                      color: Colors.white
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/worker.png",
                                    ),
                                  ),
                                )

                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.black87,
                              height: 5,
                            ),
                          ),
                          BuildTextWidget( title: "Full Name", val:model.name),
                          BuildTextWidget( title: "Skills", val:model.skill),
                          BuildTextWidget( title: "Additional Skills",val: model.otherSkills),
                          BuildTextWidget( title: "Place", val:model.address),
                          BuildTextWidget( title: "Mobile",val: model.phone),
                          BuildTextWidget( title: "Daily Wage",val: model.wage),


                          BuildSwitchWidget(
                              title: "Available on Sundays?",val: model.availableSunday),
                          BuildSwitchWidget(
                              title:  "Show my profile to others",val: model.showProfile),

                          BuildTextWidget( title: "Note", val:model.note),

                         const SizedBox(height: 70),

                        ],
                      ),
                    ),

                    Align(alignment: Alignment.bottomCenter,
                      child: RoundedButton(text: "Make Call",
                          color: kPrimaryColor,
                          press: () async {
                            await FlutterPhoneDirectCaller.callNumber(model
                                .phone);
                          },
                          cir: 10),)
                  ],
                ),
              ),
            );
          },
        ));
  }

  buildTextWidget(String s, String wage) {}

}
