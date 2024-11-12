import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/enums/payment_method.dart';
import 'package:quickmart/extension/num_price_ext.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/product_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  final String from;
  const CartScreen({super.key, required this.from});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  late PaymentMethod selectedPaymentMethod;
  bool firstRun = true;

  late final List<String> paymentMethods;
  @override
  void initState() {
    super.initState();
    selectedPaymentMethod = PaymentMethod.credit;
    paymentMethods = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstRun) {
      TargetPlatform platform = Theme.of(context).platform;
      paymentMethods.addAll(PaymentMethod.values
          .where((method) => method.isSupported(platform))
          .map((method) => method.name)
          .toList());
      
      selectedPaymentMethod = PaymentMethod.applePay.isSupported(platform)
          ? PaymentMethod.applePay
          : PaymentMethod.googlePay.isSupported(platform)
              ? PaymentMethod.googlePay
              : PaymentMethod.samsungPay.isSupported(platform)
                  ? PaymentMethod.samsungPay
                  : PaymentMethod.credit;
      firstRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProviderNotifier);
    final cart = cartState.items;
    final products = ref.watch(productProviderNotifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.black,
          onPressed: () {
            context.go(widget.from);
          },
        ),
        title: const Text('My Cart',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            color: Colors.black,
            onPressed: () {
              ref.read(cartProviderNotifier.notifier).clearCart();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8.0),
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(0.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // toggle to pickup
                    },
                    icon: const Icon(Icons.storefront),
                    label: const Text('Pickup'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(16.0),
                          left: Radius.circular(16),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // toggle to delivery
                    },
                    icon: const Icon(Icons.delivery_dining),
                    label: const Text('Delivery'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView(
              children: [
                buildAddressSection(),
                buildDeliveryInfo(),
                buildDeliveryMethod(),
                Column(
                  children: List.generate(cart.length, (index) => buildListItem(
                    products.firstWhere((product) => product.id == cart.elementAt(index).id),
                    cart.elementAt(index).quantity,
                  )),
                ),
                const Divider(thickness: .35),
                if (cart.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 48.0),
                        Text('Your cart is empty',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)
                              ),
                        const SizedBox(height: 48.0),
                      ],
                    ),
                  ),
                buildCouponSection(),
                const SizedBox(height: 230.0, width: double.infinity),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: myBottomSheet(),
    );
  }

  Widget buildAddressSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.home_filled, size: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Home',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('1234, Home Street',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text('1234567890',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
              Spacer(),
              Icon(Icons.chevron_right, size: 28),
            ],
          )
        ],
      ),
    );
  }

  Widget buildDeliveryInfo() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.schedule, size: 30),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delivery Within 31 minutes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Press to schedule delivery',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          Spacer(),
          Icon(Icons.chevron_right, size: 28),
        ],
      ),
    );
  }

  Widget buildDeliveryMethod() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.delivery_dining, size: 30),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delivery By Bicycle',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Delivery By Bicycle',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          Spacer(),
          Icon(Icons.info, size: 28),
        ],
      ),
    );
  }

  Widget buildCouponSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.local_offer, size: 30),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Apply Coupon Code',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Enter coupon code to get discount',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, size: 28),
        ],
      ),
    );
  }

  Widget myBottomSheet() {
    final cartState = ref.watch(cartProviderNotifier);
    final isCartEmpty = cartState.items.isEmpty;
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12, width: .35),
        ),
      ),
      child: Column(
        children: [
          buildPaymentDropdown(isCartEmpty),
          const SizedBox(height: 16.0),
          buildOrderSummary(isCartEmpty),
          const Spacer(flex: 2),
          buildCheckoutButtons(isCartEmpty),
        ],
      ),
    );
  }

  Widget buildPaymentDropdown(bool isEmpty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Payment Method',
            style: TextStyle(fontSize: 16, color: Colors.grey)),
        Flexible(
          child: DropdownButton<String>(
            value: selectedPaymentMethod.name,
            disabledHint: isEmpty ? Text('Not Available') : null,
            icon: isEmpty ? Icon(Icons.disabled_visible_outlined) : Icon(Icons.arrow_drop_down),
            style: TextStyle(fontSize: 16, color: isEmpty ? Colors.grey : Colors.black),
            underline: Container(
              height: 2,
              color: isEmpty ? Colors.grey : Colors.blue,
            ),
            onChanged: isEmpty ? null : (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedPaymentMethod = PaymentMethod.values.firstWhere(
                    (method) => method.name == newValue,
                  );
                });
              }
            },
            items: paymentMethods.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildOrderSummary(bool isEmpty) {
    return Column(
      children: [  
        if (isEmpty)
          const Text('Your cart is empty',
              style: TextStyle(fontSize: 16, color: Colors.grey)),
        if (!isEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delivery Fee',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text('\$5',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        if (!isEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text((ref.watch(cartProviderNotifier.notifier).getTotalPrice() + 5).formattedPrice,
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        
      ],
    );
  }
  Widget buildCheckoutButtons(bool isCartEmpty) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: isCartEmpty
                ? null
                : () {
                    // Proceed to checkout with selected payment method
                  },
            icon: Icon(
              selectedPaymentMethod.icon,
            ),
            label: Text('Pay with ${selectedPaymentMethod.name}'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isCartEmpty
                  ? Colors.grey
                  : selectedPaymentMethod.color,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50), // Full width button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Less round corners
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(Product product, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    color: Colors.grey.shade200,
                    child: Image.asset(
                      product.imageUrl,
                      width: 80, 
                      height: 80, 
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0), 
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: const [
                          Icon(Icons.chat_bubble_outline, size: 18),
                          SizedBox(width: 4.0),
                          Text(
                            'Add Special Note',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCartItemCounterPriceRow(product, quantity),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildCartItemCounterPriceRow(Product product, int quantity) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 
              8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 65,
                        height: 0,
                      ),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      color: Colors.grey.shade50,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ref
                                .watch(cartProviderNotifier.notifier)
                                .removeProductFromCart(product);
                            },
                            icon: Icon(
                              Icons.remove,
                              ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () {
                              ref.watch(cartProviderNotifier.notifier).addProductToCart(product);
                            },
                            icon: Icon(Icons.add),
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
