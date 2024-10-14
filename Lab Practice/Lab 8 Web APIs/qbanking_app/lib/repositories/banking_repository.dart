import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:qbanking_app/model/account.dart';
import 'package:qbanking_app/model/beneficiary.dart';
import 'package:qbanking_app/model/transfer.dart';

class BankingRepository {
  //create the Dio object and the base url

  //create the base url _baseUrl
  // final String _baseUrl = 'https://api1.codedbyyou.com/api';

  // documentation can be found at
  // https://api1.codedbyyou.com/docs

//Add the getCustomerAccounts method

  Future<List<Account>> getCustomerAccounts(int customerId) async {
    String data = await rootBundle.loadString('assets/data/accounts.json');
    // convert the json to a list of map
    var accountsMap = jsonDecode(data);
    // convert the list of map to a list of account
    List<Account> accounts = [];
    for (var accountMap in accountsMap) {
      accounts.add(Account.fromJson(accountMap));
    }
    return accounts;
  }

// add the getTransfers method
  Future<List<Transfer>> getTransfers(int customerId) async {
    // read the json file
    String data = await rootBundle.loadString('assets/data/transfers.json');
    // convert the json to a list of map
    var transfersMap = jsonDecode(data);
    // convert the list of map to a list of account
    List<Transfer> transfers = [];
    for (var transferMap in transfersMap) {
      transfers.add(Transfer.fromJson(transferMap));
    }
    return transfers;
  }

  //add the getBeneficiaries method
  Future<List<Beneficiary>> getBeneficiaries(int customerId) async {
    // read the json file
    String data = await rootBundle.loadString('assets/data/beneficiaries.json');
    // convert the json to a list of map
    var beneficiariesMap = jsonDecode(data);
    // convert the list of map to a list of account
    List<Beneficiary> beneficiaries = [];
    for (var beneficiaryMap in beneficiariesMap) {
      beneficiaries.add(Beneficiary.fromJson(beneficiaryMap));
    }
    return beneficiaries;
  }

  //add the addTransfer method
  Future<Transfer> addTransfer(Transfer transfer) async {
    transfer.transferId = Random().nextInt(1000);
    return transfer;
  }

  Future<bool> removeTransfer(Transfer transfer) async {
    return true;
  }
}
