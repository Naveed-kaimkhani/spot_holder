class ParkingModel {
  // String? receiverUid;
  String? ownerUid;
  String? documentId;
  String? ownerName;
  String? ownerPhone;
  String? sentDate;
  String? sentTime;
  String? parkingId;
  String? ownerDeviceToken;
  double? locationLat;
  double? locationLong;
  String? parkingDescription;
  String? ownerProfileImage;
  String? parkingAddress;
  int? availableSlots;
  int? bookedSlots;
  int? price;
  List<dynamic>? pictures;
  ParkingModel({
    this.documentId,
    this.parkingId,
    this.locationLat,
    this.price,
    this.locationLong,
    this.parkingAddress,
    this.ownerDeviceToken,
    this.parkingDescription,
    this.ownerUid,
    this.availableSlots,
    this.bookedSlots,
    this.ownerName,
    this.sentDate,
    this.sentTime,
    this.ownerProfileImage,
    this.ownerPhone,
    this.pictures,
  });

  Map<String, dynamic> toMap(ParkingModel parking) {
    var data = Map<String, dynamic>();
    data['documentId'] = parking.documentId;
    data['ownerUid'] = parking.ownerUid;
    data['availableSlots'] = parking.availableSlots;
    data['bookedSlots'] = parking.bookedSlots;
    
    data['price'] = parking.price;
 data['locationLat'] = parking.locationLat;
 data['locationLong'] = parking.locationLong;
 data['parkingAddress'] = parking.parkingAddress;
 data['parkingId'] = parking.parkingId;
     data['parkingDescription'] = parking.parkingDescription;
    data['ownerPhone'] = parking.ownerPhone;
    data['ownerName'] = parking.ownerName;
    data['ownerProfileImage'] = parking.ownerProfileImage;
    data['sentDate'] = parking.sentDate;
    data['sentTime'] = parking.sentTime;
    data['ownerDeviceToken'] = parking.ownerDeviceToken;
    data['pictures'] = parking.pictures;
    return data;
  }

  ParkingModel.fromMap(Map<String, dynamic> mapData) {
    documentId = mapData['documentId'];
    ownerName = mapData['ownerName'];
    ownerUid = mapData['ownerUid'];
    parkingDescription = mapData['parkingDescription'];
    ownerPhone = mapData['ownerPhone'];
    pictures = mapData['pictures'];
    ownerProfileImage = mapData['ownerProfileImage'];
    sentDate = mapData['sentDate'];
    sentTime = mapData['sentTime'];
    ownerDeviceToken = mapData['ownerDeviceToken'];
availableSlots= mapData['availableSlots'];
 bookedSlots= mapData['bookedSlots'];
 price=mapData['price'];
 locationLat =mapData["locationLat"]; 
 locationLong=mapData['locationLong'];
 parkingAddress=mapData['parkingAddress'];
 parkingId=mapData['parkingId'];
  }

  // bool equals(ParkingModel user) => user.uid == this.uid;
}
