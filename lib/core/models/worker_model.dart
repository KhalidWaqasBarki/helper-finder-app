class WorkerModel {
  String name;
  String lat;
  String long;
  String skill;
  String skillNo;
  String otherSkills;
  String address;
  String phone;
  String type;
  String uid;
  String wage;
  String email;
  String createdAt;
  String kms;
  String note;
  bool availableSunday;
  bool showProfile;

  WorkerModel(
      this.name,
      this.skill,
      this.skillNo,
      this.lat,
      this.long,
      this.type,
      this.address,
      this.createdAt,
      this.email,
      this.phone,
      this.uid,
      this.wage,
      this.otherSkills,
      this.kms,
      this.availableSunday,
      this.showProfile,
      this.note);
}
