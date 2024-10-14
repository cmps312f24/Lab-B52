import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qbanking_app/model/account.dart';
import 'package:qbanking_app/repositories/banking_repository.dart';

class AccountNotifier extends Notifier<List<Account>> {
  final BankingRepository _bankingRepository = BankingRepository();
  @override
  List<Account> build() {
    initializeAccounts();
    return [];
  }

  void initializeAccounts() async {
    List<Account> accounts = await _bankingRepository.getCustomerAccounts(1);
    state = accounts;
  }

  void addAccount(Account account) {
    state = [...state, account];
  }
} // AccountNotifier

final accountNotifierProvider =
    NotifierProvider<AccountNotifier, List<Account>>(() => AccountNotifier());
