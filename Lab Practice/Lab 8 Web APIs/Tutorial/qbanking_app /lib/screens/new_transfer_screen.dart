import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qbanking_app/model/transfer.dart';
import 'package:qbanking_app/providers/account_provider.dart';
import 'package:qbanking_app/providers/beneficiary_provider.dart';
import 'package:qbanking_app/providers/transfer_provider.dart';

class NewTransferScreen extends ConsumerStatefulWidget {
  const NewTransferScreen({super.key});

  @override
  ConsumerState<NewTransferScreen> createState() => _NewTransferScreenState();
}

class _NewTransferScreenState extends ConsumerState<NewTransferScreen> {
  String? _selectedAccount;
  var _transferAmount = 0.0;
  int? _selectedBeneficiaryIndex;

  @override
  Widget build(BuildContext context) {
    //  get the accounts and beneficiaries from the providers
    var accounts = ref.watch(accountNotifierProvider);
    var beneficiaries = ref.watch(beneficiaryNotifierProvider);

    _selectedAccount = accounts[0].accountNo;

    if (beneficiaries.isEmpty || accounts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              surfaceTintColor: const Color.fromARGB(255, 15, 3, 3),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'New Transfer',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text(
                      'Select Account',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      // style: const TextStyle(fontSize: 20),
                      // dropdownColor: const Color.fromARGB(1, 95, 125, 155),
                      value: _selectedAccount,
                      items: accounts
                          .map((account) => DropdownMenuItem(
                                value: account.accountNo,
                                child: Text(
                                    '${account.accountNo} -  ${account.balance.ceilToDouble()} QAR'),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        _selectedAccount = value;
                        // get the selected account
                        var selectedAccount = accounts.firstWhere(
                            (account) => account.accountNo == value);
                        // update the selected account
                        selectedAccount.balance += 100;

                        // update the account balance
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // do the same for beneficiaries like accounts with drop down selection
                    const Text(
                      'Select Beneficiary',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<int>(
                      value: _selectedBeneficiaryIndex,
                      items: [
                        for (var i = 0; i < beneficiaries.length; i++)
                          DropdownMenuItem(
                            value: i,
                            child: Text(
                                '${beneficiaries[i].accountNo} - ${beneficiaries[i].name}'),
                          )
                      ],
                      onChanged: (int? value) {
                        setState(() {
                          _selectedBeneficiaryIndex = value ?? 0;
                        });
                        // get the selected account
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //amount
                    TextField(
                      onChanged: (value) {
                        _transferAmount = double.parse(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Transfer Amount',
                        hintText: 'Enter Amount you want to transfer',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            var newTransfer = Transfer(
                                fromAccountNo: _selectedAccount!,
                                beneficiaryAccountNo:
                                    beneficiaries[_selectedBeneficiaryIndex!]
                                        .accountNo,
                                beneficiaryName:
                                    beneficiaries[_selectedBeneficiaryIndex!]
                                        .name,
                                amount: _transferAmount,
                                cid: 1);

                            // update the transfer list
                            // navigate to the transfers screen
                            ref
                                .read(transferNotifierProvider.notifier)
                                .addTransfer(newTransfer);
                            context.pop();
                          },
                          iconAlignment: IconAlignment.start,
                          child: const Text('Transfer')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
