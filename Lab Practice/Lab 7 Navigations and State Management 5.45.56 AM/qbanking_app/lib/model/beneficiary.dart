class Beneficiary {
  String name;
  String accountNo;
  int cid;

  Beneficiary({
    required this.name,
    required this.accountNo,
    this.cid = 10001,
  });

  // Factory method to create a Beneficiary object from a map
  factory Beneficiary.fromJson(Map<String, dynamic> map) {
    return Beneficiary(
      name: map['fullName'] ?? '',
      accountNo: map['accountNo'] ?? '',
      cid: map['cid'] ?? 10001,
    );
  }
}
