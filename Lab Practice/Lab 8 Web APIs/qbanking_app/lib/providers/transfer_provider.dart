// create the TransferProvider class

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qbanking_app/model/transfer.dart';
import 'package:qbanking_app/repositories/banking_repository.dart';

class TransferNotifier extends Notifier<List<Transfer>> {
  final BankingRepository _bankingRepository = BankingRepository();
  @override
  List<Transfer> build() {
    initializeTransfers();
    return [];
  }

  void initializeTransfers() async {
    var transfers = await _bankingRepository.getTransfers(1);
    state = transfers;
  }

  void addTransfer(Transfer transfer) async {
    Transfer newTransfer = await _bankingRepository.addTransfer(transfer);
    state = [...state, newTransfer];
  }

  void removeTransfer(Transfer transfer) async {
    bool isRemoved = await _bankingRepository.removeTransfer(transfer);
    if (isRemoved) {
      state = state.where((t) => t.transferId != transfer.transferId).toList();
    }
  }
}

final transferNotifierProvider =
    NotifierProvider<TransferNotifier, List<Transfer>>(
        () => TransferNotifier());
