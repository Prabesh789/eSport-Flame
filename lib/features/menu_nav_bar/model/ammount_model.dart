class AmmountModel {
  String? uid;

  String? nickName;
  String? ammount;
  String? withdrawammount;

  String? toEmail;

  String? fullName;

  String? contactNo;

  AmmountModel(
      {this.uid,
      this.nickName,
      this.ammount,
      this.withdrawammount,
      this.toEmail,
      this.contactNo,
      this.fullName});

  // receiving data from server
  factory AmmountModel.fromMap(Map<String, dynamic> map) {
    return AmmountModel(
      uid: map['uid'] as String,
      nickName: map['nickName'] as String,
      ammount: map['ammount'] as String,
      withdrawammount: map['withdrawammount'] as String,
      toEmail: map['toEmail'] as String,
      fullName: map['fullName'] as String,
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'nickName': nickName,
      'ammount': ammount,
      'withdrawammount': withdrawammount,
      'contactNo': contactNo,
      'fullName': fullName,
      'toEmail': toEmail,
      'created at': DateTime.now()
    };
  }
}
