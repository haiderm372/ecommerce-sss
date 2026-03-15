import 'package:flutter/material.dart';

import '../../../res/models/customer_model.dart';

class HomeUserTile extends StatelessWidget {
  const HomeUserTile({super.key, required this.customer});

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffFF9595),
          ),
          child: ClipOval(
            child: Image.asset(fit: BoxFit.cover, customer.image),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer.name,
                style: textTheme.labelLarge?.copyWith(
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
              Text(
                customer.description,
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: Color(0xff8F8F8F),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
