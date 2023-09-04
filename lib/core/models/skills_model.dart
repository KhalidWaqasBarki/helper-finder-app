import 'package:flutter/cupertino.dart';
import 'package:helper_finder/core/models/skillsIndivituals.dart';

class SkillModel {
  final String title;
  final bool isSelected;
  final List<SingleSkill> contents;
  final IconData icon;


  SkillModel(this.title,this.icon,this.isSelected,this.contents);
}