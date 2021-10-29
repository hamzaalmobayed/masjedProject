class Moshref_model {
  String moshrefName;
  String moshrefIdCard;
  String birthDate;
  String feild;
  String mobile;
  String job;
  String familyStatus;
  String password;


  Moshref_model( {
    this.moshrefName,
    this.moshrefIdCard ,
    this.birthDate,
    this.feild ,
    this.mobile,
    this.job,
    this.familyStatus,
    this.password ,
  });

  factory Moshref_model.fromMap(Map<String, dynamic> map) {
    return Moshref_model(
      moshrefName: map['moshrefName'],
      moshrefIdCard:map['moshrefIdCard'],
      birthDate:map['birthDate'],
      feild:map['feild'],
      mobile:map['mobile'],
      job:map['job'],
      familyStatus:map['familyStatus'],
      password:map['password'],




    );
  }

  Map<String, dynamic> toMap() {
    return {'moshrefName':moshrefName,'moshrefIdCard':moshrefIdCard,'birthDate':birthDate
      ,'feild':feild,'mobile':mobile,'job':job,'familyStatus':familyStatus,'password':password};
  }
}
