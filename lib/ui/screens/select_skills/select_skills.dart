import 'package:flutter/material.dart';
import 'package:helper_finder/core/models/skills_model.dart';
import 'package:helper_finder/ui/screens/select_skills/select_skills_provider.dart';
import 'package:helper_finder/ui/screens/sign_up_screen/sign_up_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/models/skillsIndivituals.dart';

class SelectSkills extends StatelessWidget {
  const SelectSkills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (context) => SelectSkillsProvider(),
        child: Consumer<SelectSkillsProvider>(
          builder: (context, skills, child) {
            return Scaffold(
              body: SizedBox(
                height: size.height,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/images/signup_top.png",
                        width: size.width * 0.35,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/images/main_bottom.png",
                        width: size.width * 0.25,
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height / 2,
                      child: ListView.builder(
                        itemCount: skills.skills.length,
                        itemBuilder: (context, i) {
                          return ExpansionTile(
                            title: Text(
                              skills.skills[i].title,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            children: <Widget>[
                              Column(
                                children: _buildExpandableContent(
                                    skills.skills[i], i, skills),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  _buildExpandableContent(
      SkillModel skills, int index, SelectSkillsProvider skill) {
    List<Widget> columnContent = [];
    int x = 0;
    for (SingleSkill content in skills.contents) {
      bool isSelect = content.isSelected;
      columnContent.add(
        ListTile(
          title: Text(
            content.name,
            style: const TextStyle(fontSize: 18.0),
          ),
          leading: Checkbox(
            value: isSelect,
            onChanged: (val) {
              skill.changeCheckBox(index, x);
            },
          ),
        ),
      );
      x++;
    }

    return columnContent;
  }
}
