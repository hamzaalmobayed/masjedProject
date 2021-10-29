class Chat_model {
  String date;
  String text;
  String sender;
  String receiver;


  Chat_model(
      {
        this.date,
        this.text,
        this.sender,
        this.receiver,
        });

  factory Chat_model.fromMap(Map<String, dynamic> map) {
    return Chat_model(
      date:map['date'],
      text:map['text'],
      sender:map['sender'],
      receiver:map['receiver'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'date':date,'text':text,'sender':sender
      ,'receiver':receiver,};
  }
}
