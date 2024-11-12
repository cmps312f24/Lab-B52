import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/providers/category_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/search_provider.dart';

class FilterModal extends ConsumerStatefulWidget {
  const FilterModal({super.key});

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends ConsumerState<FilterModal> {
  @override
  Widget build(BuildContext context) {
    final searchFilter = ref.watch(searchProviderNotifier);
    final categories = ref.watch(categoryProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Filter Products',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerLeft,
            child: const Text('Categories:',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = searchFilter.categories.contains(category);
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? Colors.black : Colors.blueGrey[100],
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  ref.read(productProviderNotifier.notifier).filterProducts(ref
                      .read(searchProviderNotifier.notifier)
                      .toggleCategory(category));
                },
                child: Text(category),
              );
            },
          ),

          Row(
            children: [
              const Text('Price Range:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: TextField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: searchFilter.minPrice != null
                              ? searchFilter.minPrice.toString()
                              : '',
                          selection: TextSelection.collapsed(
                            offset: searchFilter.minPrice != null
                                ? searchFilter.minPrice.toString().length
                                : 0,
                          ),
                        ),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Min Price',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        int? newValue = value.isEmpty ? null : int.tryParse(value);
                        ref
                            .read(productProviderNotifier.notifier)
                            .filterProducts(
                              ref
                                  .read(searchProviderNotifier.notifier)
                                  .setPriceRange(
                                    newValue,
                                    searchFilter.maxPrice,
                                  ),
                            );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: TextField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: searchFilter.maxPrice != null
                              ? searchFilter.maxPrice.toString()
                              : '',
                          selection: TextSelection.collapsed(
                            offset: searchFilter.maxPrice != null
                                ? searchFilter.maxPrice.toString().length
                                : 0,
                          ),
                        ),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Max Price',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        int? newValue = int.tryParse(value);
                        ref
                            .read(productProviderNotifier.notifier)
                            .filterProducts(
                              ref
                                  .read(searchProviderNotifier.notifier)
                                  .setPriceRange(
                                    searchFilter.minPrice,
                                    newValue,
                                  ),
                            );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  ref.read(productProviderNotifier.notifier).filterProducts(
                      ref.read(searchProviderNotifier.notifier).clearFilters());
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: const Text('Clear Filters'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
