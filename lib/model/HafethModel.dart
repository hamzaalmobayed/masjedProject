class Hafeth_model {
  String hafethName;
  String hafethIdCard;
  String birthDate;
  String feild;
  String mobile;
  String familyStatus;
  String mohafethName;
  String course;
  String hefthDate;
  String hefthStatus;


  Hafeth_model({
      this.hafethName,
      this.hafethIdCard,
      this.birthDate,
      this.feild,
      this.mobile,
      this.familyStatus,
      this.mohafethName,
      this.course,
      this.hefthDate,
      this.hefthStatus});

  factory Hafeth_model.fromMap(Map<String, dynamic> map) {
    return Hafeth_model(
      hafethName: map['hafethName'],
      hafethIdCard:map['hafethIdCard'],
      birthDate:map['birthDate'],
      feild:map['feild'],
      mobile:map['mobile'],
      familyStatus:map['familyStatus'],
      mohafethName:map['mohafethName'],
      course:map['course'],
      hefthDate:map['hefthDate'],
      hefthStatus:map['hefthStatus'],




    );
  }

  Map<String, dynamic> toMap() {
    return {'hafethName':hafethName,'hafethIdCard':hafethIdCard,'birthDate':birthDate
      ,'feild':feild,'mobile':mobile,'familyStatus':familyStatus,'mohafethName':mohafethName,'course':course,'hefthDate':hefthDate,'hefthStatus':hefthStatus};
  }
}
