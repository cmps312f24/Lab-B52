import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qbanking_app/model/beneficiary.dart';

class BeneficiaryProvider extends Notifier<List<Beneficiary>> {
  @override
  List<Beneficiary> build() {
    initializeState();
    return [];
  }

  void initializeState() async {
    var data = await rootBundle.loadString('assets/data/beneficiaries.json');

    var beneficiariesMap = jsonDecode(data);
    for (var beneficiaryMap in beneficiariesMap) {
      addBeneficiary(Beneficiary.fromJson(beneficiaryMap));
    }
  }

  void addBeneficiary(Beneficiary beneficiary) {
    state = [...state, beneficiary];
  }
}

final beneficiaryNotifierProvider =
    NotifierProvider<BeneficiaryProvider, List<Beneficiary>>(
        () => BeneficiaryProvider());
