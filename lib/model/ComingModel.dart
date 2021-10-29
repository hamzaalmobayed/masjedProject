class Coming_model {
  String name;
  String status;
  String color;
  String id;
  String date;


  Coming_model(
      {
        this.name,
        this.status,
        this.color,
        this.id,
        this.date});

  factory Coming_model.fromMap(Map<String, dynamic> map) {
    return Coming_model(
      name:map['name'],
      status:map['status'],
      color:map['color'],
      id:map['id'],
      date:map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name':name,'status':status,'color':color
      ,'id':id,'date':date};
  }
}
