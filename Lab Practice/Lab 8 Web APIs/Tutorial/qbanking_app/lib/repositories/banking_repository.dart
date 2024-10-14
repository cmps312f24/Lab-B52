import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:qbanking_app/model/account.dart';
import 'package:qbanking_app/model/beneficiary.dart';
import 'package:qbanking_app/model/transfer.dart';

class BankingRepository {
  //create the Dio object and the base url
  final _dio = Dio();

  //create the base url _baseUrl
  final String _baseUrl = 'https://api1.codedbyyou.com/api';

  // documentation can be found at
  // https://api1.codedbyyou.com/docs

  // dio.get(url)
  // dio.delete(url)
  // dio.post(url, data: {'key': 'value' , 'key2': 'value2'})
  // dio.put(url, data: {'key': 'value' , 'key2': 'value2'})

//Add the getCustomerAccounts method
//https://api1.codedbyyou.com/api/accounts/:cid
  Future<List<Account>> getCustomerAccounts(int customerId) async {
    Response response = await _dio.get('$_baseUrl/accounts/$customerId');
    if (response.statusCode != 200) {
      throw Exception('Failed to load accounts');
    }

    List<Account> accounts = [];
    for (var accountMap in response.data) {
      accounts.add(Account.fromJson(accountMap));
    }
    return accounts;
  }

//https://api1.codedbyyou.com/api/transfers/1
// add the getTransfers method
  Future<List<Transfer>> getTransfers(int customerId) async {
    Response response = await _dio.get('$_baseUrl/transfers/$customerId');
    if (response.statusCode != 200) {
      throw Exception('Failed to load transfers');
    }
    List<Transfer> transfers = [];
    for (var transferMap in response.data) {
      transfers.add(Transfer.fromJson(transferMap));
    }
    return transfers;
  }

  //add the getBeneficiaries method
  Future<List<Beneficiary>> getBeneficiaries(int customerId) async {
    // read the json file
    Response response = await _dio.get('$_baseUrl/beneficiaries/$customerId');
    // convert the json to a list of map
    if (response.statusCode != 200) {
      throw Exception('Failed to load beneficiaries');
    }
    // convert the list of map to a list of account
    List<Beneficiary> beneficiaries = [];
    for (var beneficiaryMap in response.data) {
      beneficiaries.add(Beneficiary.fromJson(beneficiaryMap));
    }
    return beneficiaries;
  }

  //add the addTransfer method
  Future<Transfer> addTransfer(Transfer transfer) async {
    final url = '$_baseUrl/transfers/${transfer.cid}';
    Response response = await _dio.post(url, data: transfer.toJson());
    if (response.statusCode != 201) {
      throw Exception('Failed to add transfer');
    }
    return transfer;
  }

  Future<bool> removeTransfer(Transfer transfer) async {
    return true;
  }
}
