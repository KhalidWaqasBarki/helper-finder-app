import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class contact extends MaterialPageRoute<void> {
  contact()
      : super(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.blue,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ContactUs(
                    logo: AssetImage('assets/images/gssc.jpg'),
                    email: 'khalidwaqas304@gmail.com',
                    companyName: 'GSSC STUDENTS',
                    dividerThickness: 2,
                    tagLine: 'Batch 2018-22 FYP PROJECT',
                    //phoneNumber: '',

                    cardColor: Colors.white,
                    companyColor: Colors.white,
                    taglineColor: Colors.black,
                    textColor: Colors.black,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            debugPrint('Card tapped.');
                          },
                          child: const SizedBox(
                            width: 410,
                            height: 55,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Text("Email us: khalidwaqas304@gmail.com ",
                                    style: TextStyle(

                                      fontSize: 20,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            debugPrint('Card tapped.');
                          },
                          child: const SizedBox(
                            width: 410,
                            height: 55,
                            child: Center(
                              child: Text("Contact us: 03181939770",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black)),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            );
          },
        );
}
