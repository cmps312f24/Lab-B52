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
      name: map['name'] ?? '',
      accountNo: map['accountNo'] ?? '',
      cid: map['cid'] ?? 10001,
    );
  }

  // Method to convert a Beneficiary object to a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'accountNo': accountNo,
      'cid': cid,
    };
  }
}
