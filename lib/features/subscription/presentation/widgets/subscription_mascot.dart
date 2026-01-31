import 'package:flutter/material.dart';

class SubscriptionMascot extends StatelessWidget {
  final String asset;

  const SubscriptionMascot({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 180,
      child: Image.asset(asset, fit: BoxFit.contain),
    );
  }
}
