import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';
import 'package:users_dvp_app/core/theme/app_colors.dart';
import 'package:users_dvp_app/core/theme/app_text_styles.dart';
import 'package:users_dvp_app/presentation/cubits/list_user/list_user_cubit.dart';
import 'package:users_dvp_app/presentation/router/route_names.dart';
import 'package:users_dvp_app/presentation/widgets/custom_card_content.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListUserCubit>().getUsers();
    });
  }

  void didPopNext() {
    context.read<ListUserCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ListUserCubit, ListUserState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SpinKitSpinningLines(color: AppColors.primaryDark)],
              );
            }

            if (state.users.isEmpty && state.status != Status.loading) {
              return const _EmptyListView();
            }
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return CustomCardContent(
                  title: state.users[index].name,
                  subtitle: state.users[index].lastName,
                  icon: RemixIcons.arrow_right_s_line,
                  onTap: () {
                    context.push(
                      RouteNames.detailUser,
                      extra: {AppMessage.parameterId: state.users[index].id},
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {context.push(RouteNames.addUser)},
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
        child: const Icon(RemixIcons.add_line),
      ),
    );
  }
}

class _EmptyListView extends StatelessWidget {
  const _EmptyListView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(RemixIcons.user_forbid_fill, size: 100),
          SizedBox(height: 20),
          Text(
            AppMessage.usersNoRegistered,
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineMedium,
          ),
        ],
      ),
    );
  }
}
