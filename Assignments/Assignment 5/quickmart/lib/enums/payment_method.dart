import 'package:flutter/material.dart';

enum PaymentMethod {
  applePay(
    name: 'Apple Pay',
    icon: Icons.apple,
    color: Colors.black,
    platforms: [TargetPlatform.iOS, TargetPlatform.macOS],
  ),
  googlePay(
    name: 'Google Pay',
    icon: Icons.android,
    color: Colors.blue,
    platforms: [
      TargetPlatform.android,
      TargetPlatform.fuchsia,
      TargetPlatform.windows,
      TargetPlatform.linux
    ],
  ),
  samsungPay(
    name: 'Samsung Pay',
    icon: Icons.phone_android,
    color: Colors.blueAccent,
    platforms: [TargetPlatform.android],
  ),
  cash(name: 'Cash', icon: Icons.money, color: Colors.green, platforms: []),
  debit(name: 'Debit', icon: Icons.money, color: Colors.orange, platforms: []),
  credit(name: 'Credit', icon: Icons.credit_card, color: Colors.blue, platforms: []);

  final String name;
  final IconData icon;
  final Color color;
  final List<TargetPlatform> platforms;

  const PaymentMethod({
    required this.name,
    required this.icon,
    required this.color,
    required this.platforms,
  });

  isSupported(TargetPlatform platform) {
    return platforms.isEmpty || platforms.contains(platform);
  }
}
