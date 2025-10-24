import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:remixicon/remixicon.dart';
import 'package:users_dvp_app/core/constants/app_constants.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';
import 'package:users_dvp_app/core/theme/app_colors.dart';
import 'package:users_dvp_app/core/theme/app_text_styles.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';
import 'package:users_dvp_app/presentation/cubits/detail_user/detail_user_cubit.dart';
import 'package:users_dvp_app/presentation/widgets/custom_directions.dart';
import 'package:users_dvp_app/presentation/widgets/custom_text_field.dart';

class DetailUserScreen extends StatefulWidget {
  final int id;
  const DetailUserScreen({super.key, required this.id});

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cubit = context.read<DetailUserCubit>();
      await cubit.getUserById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppMessage.titleDetailUser)),
      body: BlocBuilder<DetailUserCubit, DetailUserState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return SpinKitSpinningLines(color: AppColors.primaryDark);
          }

          if (state.status != Status.loading && state.user == null) {
            return const SizedBox.shrink();
          }

          final user = state.user!;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: _DetailUserView(user: user),
            ),
          );
        },
      ),
    );
  }
}

class _DetailUserView extends StatelessWidget {
  const _DetailUserView({required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Lottie.asset(AppConstants.animationDetailUser, width: 100, height: 100)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 40),
              CustomTextField(
                title: AppMessage.titleName,
                startIcon: const Icon(RemixIcons.account_circle_line),
                isReadOnly: true,
                controller: TextEditingController(text: user.name),
              ),
              const SizedBox(height: 25),
              CustomTextField(
                title: AppMessage.titleLastName,
                startIcon: const Icon(RemixIcons.account_circle_line),
                isReadOnly: true,
                controller: TextEditingController(text: user.lastName),
              ),
              const SizedBox(height: 25),
              CustomTextField(
                title: AppMessage.titleBirthDate,
                typeKeyboard: TextInputType.datetime,
                startIcon: const Icon(RemixIcons.calendar_line),
                isReadOnly: true,
                controller: TextEditingController(text: user.birthDate),
              ),
              const SizedBox(height: 25),
              const Text(AppMessage.titleDirections, style: AppTextStyles.titleMedium),
              const SizedBox(height: 25),
            ],
          ),
        ),

        user.addresses?.isNotEmpty ?? false
            ? CustomDirections(addresses: user.addresses!)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppMessage.addressesNoRegistered),
                  SizedBox(height: 20),
                  Icon(RemixIcons.map_pin_line),
                ],
              ),
      ],
    );
  }
}
