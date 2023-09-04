import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final double cir;
  final bool isSmall;
  final Function() press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.isSmall = false,
    this.cir = 15,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: isSmall?2:10),
      width: isSmall?size.width/5:size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cir),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: isSmall?const EdgeInsets.symmetric(horizontal: 10, vertical:3):const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          textStyle: TextStyle(
              color: textColor, fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}
