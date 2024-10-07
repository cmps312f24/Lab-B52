import 'package:flutter/material.dart';
import 'package:qbanking_app/model/account.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var accounts = <Account>[];

  @override
  Widget build(BuildContext context) {
    // print(accounts);
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          child: ListTile(
            title: Text(accounts[index].accountNo),
            subtitle: Text(accounts[index].type),
            trailing: Text(accounts[index].balance.toString()),
          ),
        );
      },
    );
  }
}
