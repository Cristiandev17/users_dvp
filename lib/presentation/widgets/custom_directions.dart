import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:users_dvp_app/core/theme/app_colors.dart';
import 'package:users_dvp_app/domain/models/address_model.dart';

class CustomDirections extends StatelessWidget {
  const CustomDirections({super.key, required this.addresses});

  final List<AddressModel> addresses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final item = addresses[index];
          return ListTile(
            leading: Container(
              decoration: BoxDecoration(
                color: const Color(0xffe8f0fe),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(RemixIcons.map_pin_line, color: AppColors.primary),
            ),
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: item.country,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' - '),
                  TextSpan(text: item.city),
                  TextSpan(text: ', '),
                  TextSpan(text: item.department),
                ],
              ),
            ),
            subtitle: Text(item.complement, maxLines: 3, overflow: TextOverflow.ellipsis),
          );
        },
      ),
    );
  }
}
