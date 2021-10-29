class Hefth_Model {
  String studentNameHefth;
  String beginAya;
  String beginSora;
  String endAya;
  String endSora;
  String pageNumber;
  String revisionPage;
  String estimate;
  String date;
  String chainName;

  Hefth_Model(
      {
        this.studentNameHefth,
        this.beginAya,
        this.beginSora,
        this.endAya,
        this.endSora,
        this.pageNumber,
        this.revisionPage,
        this.estimate,
        this.date,
        this.chainName
        });

  factory Hefth_Model.fromMap(Map<String, dynamic> map) {
    return Hefth_Model(
      studentNameHefth: map['studentNameHefth'],
      beginAya:map['beginAya'],
      beginSora:map['beginSora'],
      endAya:map['endAya'],
      endSora:map['endSora'],
      pageNumber:map['pageNumber'],
      revisionPage:map['revisionPage'],
      estimate:map['estimate'],
      date:map['date'],
      chainName:map['chainName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'studentNameHefth':studentNameHefth,'beginAya':beginAya,'beginSora':beginSora
      ,'endAya':endAya,'endSora':endSora,'pageNumber':pageNumber,'revisionPage':revisionPage,'estimate':estimate,'date':date,'chainName':chainName};
  }
}
