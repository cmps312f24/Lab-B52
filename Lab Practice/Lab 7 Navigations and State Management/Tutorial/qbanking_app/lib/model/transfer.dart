import 'dart:math';

class Transfer {
  String fromAccountNo;
  double amount;
  String beneficiaryName;
  String beneficiaryAccountNo;
  String transferId;
  int cid;

  Transfer({
    required this.fromAccountNo,
    required this.amount,
    this.beneficiaryName = '',
    this.beneficiaryAccountNo = '',
    String? transferId,
    this.cid = 10001,
  }) : transferId = transferId ?? Random().nextInt(100000).toString();

  // Factory method to create a Transfer object from a map
  factory Transfer.fromJson(Map<String, dynamic> map) {
    return Transfer(
      fromAccountNo: map['fromAccountNo'] ?? '',
      amount: map['amount'] ?? 0.0,
      beneficiaryName: map['beneficiaryName'] ?? '',
      beneficiaryAccountNo: map['beneficiaryAccountNo'] ?? '',
      transferId: map['transferId'] ?? Random().nextInt(100000).toString(),
      cid: map['cid'] ?? 10001,
    );
  }
}
