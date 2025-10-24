import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:remixicon/remixicon.dart';
import 'package:users_dvp_app/core/constants/app_constants.dart';
import 'package:users_dvp_app/presentation/cubits/detail_user/detail_user_cubit.dart';
import 'package:users_dvp_app/presentation/widgets/custom_text_field.dart';

class DetailUserScreen extends StatefulWidget {
  final int id;
  const DetailUserScreen({super.key, required this.id});

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData(widget.id);
  }

  Future<void> loadData(int id) async {
    await context.read<DetailUserCubit>().getUserById(id);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    final user = context.read<DetailUserCubit>().state.user;

    if (user != null) {
      _nameController.text = user.name;
      _lastNameController.text = user.lastName;
      _birthDateController.text = user.birthDate;
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del usuario')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(AppConstants.animationDetailUser, width: 100, height: 100),
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    title: 'Nombre',
                    startIcon: const Icon(RemixIcons.account_circle_line),
                    isReadOnly: true,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    title: 'Apellido',
                    startIcon: const Icon(RemixIcons.account_circle_line),
                    isReadOnly: true,
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    title: 'Fecha de nacimiento',
                    typeKeyboard: TextInputType.datetime,
                    startIcon: const Icon(RemixIcons.calendar_line),
                    isReadOnly: true,
                    controller: _birthDateController,
                  ),
                  const SizedBox(height: 25),
                  const Text('Direcciones', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: context.read<DetailUserCubit>().state.user?.addresses?.length,
                      itemBuilder: (context, index) {
                        final item = context.read<DetailUserCubit>().state.user?.addresses?[index];
                        return ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffe8f0fe),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Icon(RemixIcons.map_pin_line, color: Colors.blue),
                          ),
                          title: Text(
                            item?.country ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item?.department ?? ''),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
