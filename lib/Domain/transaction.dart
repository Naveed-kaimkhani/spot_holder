class TransactionModel {
 String? senderUid;
 String? receiverUid;
 String? senderName;
 String? receiverName;
//  String? documentId;
 String? transactionTime;
 String? transactionDate; 
 int? payment;
  TransactionModel(
      {
        // this.documentId,
        required this.senderUid,
      required this.senderName,
required this.receiverName,
     required this.transactionDate,
required this.receiverUid,
     required this.transactionTime,
     required this.payment, 
      });

  Map<String, dynamic> toMap(TransactionModel user) {
    var data = Map<String, dynamic>();
    data['senderUid'] = user.senderUid;
    data['receiverUid'] = user.receiverUid;
    
    // data['documentId'] = user.documentId;
    data['senderName'] = user.senderName;
    data['receiverName'] = user.receiverName;
    data['transactionDate'] = user.transactionDate;
    data['transactionTime'] = user.transactionTime;
   data['payment'] = user.payment;
    return data;
  }

  TransactionModel.fromMap(Map<String, dynamic> mapData) {
// documentId = mapData['documentId'];
    senderUid = mapData['senderUid'];   
    receiverUid = mapData['receiverUid'];
    senderName = mapData['senderName'];
    receiverName = mapData['receiverName'];
  transactionDate = mapData['transactionDate'];
   transactionTime = mapData['transactionTime'];
    payment = mapData['payment'];
   

  }
}
