class ReservedParkingModel {
  // String? receiverUid;
  String? userUid;
  String? documentId;
  String? parkingDocumentId;
  String? userName;
  String? reservedDate;
  String? reservedTime;
  // String? durationDate;
  String? durationTime;
  String? parkingId;
  String? ownerDeviceToken;
  String? owneruid;
  double? locationLat;
  double? locationLong;
  String? parkingAddress;
  int? bookedSlots;
  int? price;
  String? userContact;

  ReservedParkingModel({
    this.documentId,
    this.parkingId,
    this.userName,
    this.userContact,
    this.locationLat,
    this.locationLong,
    this.price,
    this.parkingAddress,
    this.ownerDeviceToken,
    this.userUid,
    this.owneruid,
    this.bookedSlots,
    this.parkingDocumentId,
    this.reservedDate,
    this.reservedTime,
    // this.durationDate,
    this.durationTime,
  });

  Map<String, dynamic> toMap(ReservedParkingModel parking) {
    var data = Map<String, dynamic>();
    data['documentId'] = parking.documentId;
    data['userUid'] = parking.userUid;
    data['userName'] = parking.userName;

    data['userContact'] = parking.userContact;
    data['ownerUid'] = parking.owneruid;
    data['bookedSlots'] = parking.bookedSlots;
    data['price'] = parking.price;
    data['locationLat'] = parking.locationLat;
    data['locationLong'] = parking.locationLong;
    data['parkingAddress'] = parking.parkingAddress;
    data['parkingId'] = parking.parkingId;
    data['parkingDocumentId'] = parking.parkingDocumentId;
    // data['durationDate'] = parking.durationDate;
    data['durationTime'] = parking.durationTime;
    data['reservedDate'] = parking.reservedDate;
    data['reservedTime'] = parking.reservedTime;
    data['ownerDeviceToken'] = parking.ownerDeviceToken;
    return data;
  }

  ReservedParkingModel.fromMap(Map<String, dynamic> mapData) {
    documentId = mapData['documentId'];
    userUid = mapData['userUid'];

    userName = mapData['userName'];
    userContact = mapData['userContact'];
    owneruid = mapData['ownerUid'];
    parkingDocumentId = mapData['parkingDocumentId'];
    reservedDate = mapData['reservedDate'];
    reservedTime = mapData['reservedTime'];
    // durationDate = mapData['durationDate'];
    durationTime = mapData['durationTime'];
    ownerDeviceToken = mapData['ownerDeviceToken'];
    bookedSlots = mapData['bookedSlots'];
    price = mapData['price'];
    locationLat = mapData["locationLat"];
    locationLong = mapData['locationLong'];
    parkingAddress = mapData['parkingAddress'];
    parkingId = mapData['parkingId'];
  }

  // bool equals(ReservedParkingModel user) => user.uid == this.uid;
}
