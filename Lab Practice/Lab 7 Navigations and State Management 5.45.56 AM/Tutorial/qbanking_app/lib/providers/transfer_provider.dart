import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qbanking_app/model/transfer.dart';

class TransferProvider extends Notifier<List<Transfer>> {
  @override
  List<Transfer> build() {
    initializeState();
    return [];
  }

  void initializeState() async {
    var data = await rootBundle.loadString('assets/data/transfers.json');

    var transfersMap = jsonDecode(data);
    for (var transferMap in transfersMap) {
      addTransfer(Transfer.fromJson(transferMap));
    }
  }

  void addTransfer(Transfer transfer) {
    state = [...state, transfer];
  }

  void removeTransfer(Transfer transfer) {
    state = state
        .where((element) => element.transferId != transfer.transferId)
        .toList();
  }

  void updateTransfer(Transfer transfer) {
    state = state
        .map((element) => element.id == transfer.id ? transfer : element)
        .toList();
  }
}

final transferNotifierProvider =
    NotifierProvider<TransferProvider, List<Transfer>>(
        () => TransferProvider());
