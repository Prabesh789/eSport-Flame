class MessageModel {
  MessageModel({
    this.uid,
    this.message,
    this.nickName,
    this.senderUid,
  });
  String? uid;
  String? message;
  String? nickName;
  String? senderUid;

  // receiving data from server
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      uid: map['uid'] as String,
      nickName: map['nickName'] as String,
      message: map['email'] as String,
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderUid': uid,
      'message': message,
      'nickName': nickName,
      'created at': DateTime.now()
    };
  }
}
