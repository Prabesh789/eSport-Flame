class AmmountModel{
 String? uid;
  
  String? nickName;
  String? ammount;
  String? withdrawammount;

  String? toEmail;

   String? fullName;

  String ?contactNo;

  AmmountModel({this.uid,this.nickName,this.ammount,this.withdrawammount,this.toEmail,this.contactNo,this.fullName});

  // receiving data from server
  factory AmmountModel.fromMap(map) {
    return AmmountModel(
      uid: map['uid'],     
      nickName: map['nickName'],
      ammount: map['ammount'],
      withdrawammount: map['withdrawammount'],
      toEmail:map['toEmail'],
      fullName:map['fullName'],

    

 
     
    );
  }

  

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickName':nickName,
       'ammount':ammount,
       'withdrawammount':withdrawammount,
       'contactNo':contactNo,
       'fullName':fullName,
       'toEmail':toEmail,
      'created at':DateTime.now()
    };
  }
}