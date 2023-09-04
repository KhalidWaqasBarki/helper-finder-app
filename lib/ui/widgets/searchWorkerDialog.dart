import 'package:flutter/material.dart';
import 'package:helper_finder/core/utils/constants.dart';
import 'package:helper_finder/ui/screens/hire_page/hire_page_view_model.dart';
import 'package:helper_finder/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import '../screens/sign_up_screen/sign_up_screen_view_model.dart';

class ShowWorkerDialog extends StatefulWidget {
  final Function() press;

  final String type;

  const ShowWorkerDialog({
    Key? key,
    required this.press,
    required this.type,
  }) : super(key: key);

  @override
  _ShowWorkerDialogState createState() => _ShowWorkerDialogState();
}

class _ShowWorkerDialogState extends State<ShowWorkerDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  Tween<double> marginTopTween = Tween<double>(begin: 300, end: 200);
  late Animation<double> marginTopAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    marginTopAnimation = marginTopTween.animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<SignUpProvider>(builder: (context, register, child) {
    return Consumer<HireProvider>(builder: (context, hire, child) {
      return FadeTransition(
        opacity: opacityTween.animate(controller),
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 80),
                  child: register.isListEmpty
                      ? ListView.builder(
                          itemCount: register.dropDownItems.length,
                          itemBuilder: (context, i) {
                            return Card(
                              child: InkWell(
                                onTap: () {
                                  hire.filterWorker(register.dropDownItemsIds[i]);
                                  Navigator.of(context).pop();
                                },
                                child: ListTile(
                                  title: Text(register.dropDownItems[i]),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: RoundedButton(
                        text: "Cancel",
                        color: kPrimaryColor,
                        press: () => Navigator.of(context).pop(),
                        cir: 10),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
