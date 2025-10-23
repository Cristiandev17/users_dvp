import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:users_dvp_app/presentation/router/route_names.dart';
import 'package:users_dvp_app/presentation/widgets/custom_card_content.dart';

class ListUserScreen extends StatelessWidget {
  const ListUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List User')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return CustomCardContent(
            title: 'Title',
            subtitle: 'Subtitle',
            icon: RemixIcons.arrow_right_s_line,
            onTap: () => context.push(RouteNames.detailUser),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.addUser),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
        child: const Icon(RemixIcons.add_line),
      ),
    );
  }
}
