import 'package:flutter/material.dart';
class BuildSwitchWidget extends StatelessWidget {
  String title;
  bool val;
  BuildSwitchWidget({Key? key,required this.title,required this.val}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.white,
        elevation: 1,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),

          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(alignment: Alignment.centerRight,
                    child: Switch(value: val, onChanged: (val) {},)),
              )
            ],
          ),
        ),

      ),
    );
  }
}
