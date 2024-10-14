import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qbanking_app/providers/transfer_provider.dart';
import 'package:qbanking_app/routes/app_router.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    var transfers = ref.watch(transferNotifierProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRouter.newTransfer.name);
              },
              iconAlignment: IconAlignment.start,
              child: const Text('New Transfer')),
        ),
        const Text(
          'Previous Transfers',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: transfers.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Text('Id : ${transfers[index].transferId}'),
                  title: Text(
                      'Transferred Amount : ${transfers[index].amount.ceilToDouble()} QAR'), //format to two decimal places
                  subtitle:
                      Text('Beneficiary: ${transfers[index].beneficiaryName}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(transferNotifierProvider.notifier)
                          .removeTransfer(transfers[index]);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
