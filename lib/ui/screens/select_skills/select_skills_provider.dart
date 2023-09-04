import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helper_finder/core/models/skillsIndivituals.dart';

import '../../../core/models/skills_model.dart';

class SelectSkillsProvider extends ChangeNotifier {
  SelectSkillsProvider(){
    setSkills();
  }

  List<List<SingleSkill>> singleSkills=[[
    SingleSkill("Electric Scooter Technician", true),
    SingleSkill("Automobile painting at home", false),
    SingleSkill("Mobile puncture work", false),
    SingleSkill("Mobile bike repair", false),
    SingleSkill("Car AC work at home", false),
    SingleSkill("LPG Conversion", false),
    SingleSkill("Mobile car repair", false),
  ], [
    SingleSkill("Cable TV", false),
    SingleSkill("Internet Connection", false),
    SingleSkill("FTTH", false),
    SingleSkill("DTH", false),
  ]];






  List<SkillModel> skills = [];


  changeCheckBox(int i,int x){
    bool val = !skills[i].contents[x].isSelected;
    String valName=
        skills[i].contents.elementAt(x).name;

    skills[i].contents.removeAt(x);
    Iterable<SingleSkill> skill= {SingleSkill(valName,val)
    };
    // skills[i].contents.insertAll(x,skill);
    skills[i].contents[x].name=valName;
    skills[i].contents[x].isSelected=val;

    notifyListeners();
  }

  void setSkills() {

    List<SingleSkill> sSkill=[
      SingleSkill("Electric Scooter Technician", true),
      SingleSkill("Automobile painting at home", false),
      SingleSkill("Mobile puncture work", false),
      SingleSkill("Mobile bike repair", false),
      SingleSkill("Car AC work at home", false),
      SingleSkill("LPG Conversion", false),
      SingleSkill("Mobile car repair", false),
    ];
    SkillModel skill= SkillModel(
        'Automobile',
        Icons.pedal_bike_outlined,
        true,
        sSkill
    );
    skills.add(skill);


    List<SingleSkill> sSkill1=[

      SingleSkill("Cable TV", false),
      SingleSkill("Internet Connection", false),
      SingleSkill("FTTH", false),
      SingleSkill("DTH", false),

    ];

    SkillModel skill1= SkillModel(
        'Connectivity', Icons.private_connectivity_outlined,
        true,
        sSkill1
    );
    skills.add(skill1);
  }

}
