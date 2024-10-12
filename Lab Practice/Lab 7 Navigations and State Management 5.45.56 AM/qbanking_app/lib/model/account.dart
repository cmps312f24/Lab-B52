class Account {
  String accountNo;
  String firstName;
  String lastName;
  String type;
  double balance;
  int cid;

  Account({
    this.accountNo = '',
    this.firstName = '',
    this.lastName = '',
    this.type = '',
    this.balance = 0.0,
    this.cid = 10001,
  });

  // Factory method to create an Account object from a map
  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(
      accountNo: map['accountNo'] ?? '',
      type: map['type'] ?? '',
      balance: map['balance'] ?? 0.0,
      cid: map['cid'] ?? 10001,
    );
  }
}
