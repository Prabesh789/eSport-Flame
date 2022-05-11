class MessageModel{
 String? uid;
  String? message;
  String? nickName;
  String? senderUid;

  MessageModel({this.uid,this.message,this.nickName,this.senderUid});

  // receiving data from server
  factory MessageModel.fromMap(map) {
    return MessageModel(
      uid: map['uid'],     
      nickName: map['nickName'],
      message: map['email'],
     
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'senderUid': uid,
      'message': message,
      'nickName':nickName,
      'created at':DateTime.now()
    };
  }
}