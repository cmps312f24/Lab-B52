import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qbanking_app/model/account.dart';

class AccountNotifier extends Notifier<List<Account>> {
  @override
  List<Account> build() {
    initializeState();
    return [];
  }

  void initializeState() async {
    var data = await rootBundle.loadString('assets/data/accounts.json');

    var accountsMap = jsonDecode(data);
    // List<Account> temp = [];
    for (var accountMap in accountsMap) {
      addAccount(Account.fromJson(accountMap));
    }
  }

  void addAccount(Account account) {
    // state.add(account); very bad
    state = [...state, account];
  }

  void removeAccount(Account account) {
    state = state
        .where((element) => element.accountNo != account.accountNo)
        .toList();
  }

  void updateAccount(Account account) {
    state = state
        .map((element) =>
            element.accountNo == account.accountNo ? account : element)
        .toList();
  }
}

final accountNotifierProvider =
    NotifierProvider<AccountNotifier, List<Account>>(() => AccountNotifier());
