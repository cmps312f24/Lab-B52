
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qbanking_app/model/beneficiary.dart';
import 'package:qbanking_app/repositories/banking_repository.dart';

class BeneficiaryNotifier extends Notifier<List<Beneficiary>> {
  final BankingRepository _bankingRepository = BankingRepository();
  @override
  List<Beneficiary> build() {
    initializeBeneficiaries();
    return [];
  }

  void initializeBeneficiaries() async {
    List<Beneficiary> beneficiaries =
        await _bankingRepository.getBeneficiaries(1);
    state = beneficiaries;
  }

  void addBeneficiary(Beneficiary beneficiary) {
    state = [...state, beneficiary];
  }
}

// provider

final beneficiaryNotifierProvider =
    NotifierProvider<BeneficiaryNotifier, List<Beneficiary>>(
        () => BeneficiaryNotifier());
