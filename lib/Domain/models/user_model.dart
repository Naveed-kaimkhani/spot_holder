// User ---> NGO
class UserModel {
  String? uid;
  String? profileImage;
  String? name;
  double? lat;
  double? long;
  int? balance;
  String? address;
  String? phone;
  String? email;
  String? deviceToken;

//leran freezed model
  UserModel(
      {required this.uid,
      this.profileImage,
      required this.name,
      required this.phone,
      required this.address,
      this.lat,
      this.long,
      this.balance,
      required this.email,
      required this.deviceToken,
      
      });

  Map<String, dynamic> toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['profileImage'] = user.profileImage;
    data['name'] = user.name;
    data['lat'] = user.lat;
    data['long'] = user.long;
    data['address'] = user.address;
    data['phone'] = user.phone;
    data['balance'] = user.balance;
    data['email'] = user.email;
    data['deviceToken'] = user.deviceToken;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    uid = mapData['uid'];
    profileImage = mapData['profileImage'];
    name = mapData['name'];
    lat = mapData['lat'];
    long = mapData['long'];
    address = mapData['address'];
    phone = mapData['phone'];
    balance = mapData['balance'];    
    email = mapData['email'];
    deviceToken = mapData['deviceToken'];
  }
}
