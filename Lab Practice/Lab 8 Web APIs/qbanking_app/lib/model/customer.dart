import 'package:qbanking_app/model/account.dart';

class Customer {
  final int cid;
  final String name;
  final List<Account> accounts;

  Customer({required this.cid, required this.name, required this.accounts});

  factory Customer.fromJson(Map<String, dynamic> json) {
    final List<dynamic> accountsData = json['accounts'];
    final List<Account> accounts =
        accountsData.map((json) => Account.fromJson(json)).toList();
    return Customer(
      cid: json['cid'],
      name: json['name'],
      accounts: accounts,
    );
  }
}
