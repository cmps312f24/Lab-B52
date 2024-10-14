import 'dart:math';

class Transfer {
  String fromAccountNo;
  double amount;
  String beneficiaryName;
  String beneficiaryAccountNo;
  int transferId;
  int cid;

  Transfer({
    required this.fromAccountNo,
    required this.amount,
    this.beneficiaryName = '',
    this.beneficiaryAccountNo = '',
    int? transferId,
    this.cid = 10001,
  }) : transferId = transferId ?? Random().nextInt(100000);

  // Factory method to create a Transfer object from a map
  factory Transfer.fromJson(Map<String, dynamic> map) {
    return Transfer(
      fromAccountNo: map['fromAccountNo'] ?? '',
      amount: map['amount'] * 1.0 ?? 0.0,
      beneficiaryName: map['beneficiaryName'] ?? '',
      beneficiaryAccountNo: map['beneficiaryAccountNo'] ?? '',
      transferId: map['transferId'] ?? Random().nextInt(100000),
      cid: map['cid'] ?? 10001,
    );
  }

  // Method to convert a Transfer object to a map
  Map<String, dynamic> toJson() {
    return {
      'fromAccountNo': fromAccountNo,
      'amount': amount,
      'beneficiaryName': beneficiaryName,
      'beneficiaryAccountNo': beneficiaryAccountNo,
      'transferId': transferId,
      'cid': cid,
    };
  }
}
