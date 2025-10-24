import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:users_dvp_app/core/constants/location_constants.dart';
import 'package:users_dvp_app/core/theme/app_colors.dart';
import 'package:users_dvp_app/presentation/cubits/add_user/add_user_cubit.dart';
import 'package:users_dvp_app/presentation/cubits/list_user/list_user_cubit.dart';
import 'package:users_dvp_app/presentation/widgets/custom_directions.dart';
import 'package:users_dvp_app/presentation/widgets/custom_text_field.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _datePickController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AddUserCubit>().reset();
  }

  @override
  void dispose() {
    _datePickController.dispose();
    super.dispose();
  }

  void _onSelectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked == null) {
      _datePickController.text = '';
    } else {
      final date = picked.toString().split(' ')[0];
      _datePickController.text = date;
    }
    if (!context.mounted) return;
    context.read<AddUserCubit>().onBirthDateChanged(_datePickController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear usuario')),
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextField(
                  title: 'Nombre',
                  placeholder: 'Ingrese su nombre',
                  startIcon: const Icon(RemixIcons.account_circle_line),
                  onChanged: (value) => context.read<AddUserCubit>().onNameChanged(value),
                  errorMessage: context.read<AddUserCubit>().state.name.errorMessage,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  title: 'Apellido',
                  placeholder: 'Ingrese su apellido',
                  startIcon: const Icon(RemixIcons.account_circle_line),
                  onChanged: (value) => context.read<AddUserCubit>().onLastNameChanged(value),
                  errorMessage: context.read<AddUserCubit>().state.lastName.errorMessage,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  title: 'Fecha de nacimiento',
                  placeholder: 'Ingrese la fecha',
                  typeKeyboard: TextInputType.datetime,
                  startIcon: const Icon(RemixIcons.calendar_line),
                  isReadOnly: true,
                  controller: _datePickController,
                  onTap: () => _onSelectDate(context),
                  errorMessage: context.read<AddUserCubit>().state.birthDate.errorMessage,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Agregar direccion'),
                    IconButton(
                      onPressed: () => appearingBottomSheetAddAddress(context),
                      icon: const Icon(RemixIcons.add_line),
                    ),
                  ],
                ),
                BlocBuilder<AddUserCubit, AddUserState>(
                  builder: (context, state) {
                    return context.read<AddUserCubit>().state.addresses.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('No hay direcciones'),
                              SizedBox(height: 20),
                              Icon(RemixIcons.map_pin_line),
                            ],
                          )
                        : CustomDirections(addresses: state.addresses);
                  },
                ),

                const Spacer(),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () async {
                      await context.read<AddUserCubit>().onSubmittedUser();
                      if (!context.mounted) return;
                      if (context.read<AddUserCubit>().state.status == FormStatus.success) {
                        context.read<ListUserCubit>().getUsers();
                        context.pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('Agregar', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void appearingBottomSheetAddAddress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                items: countries.entries
                    .map((e) => DropdownMenuItem(value: e.value, child: Text(e.value)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  context.read<AddUserCubit>().onCountryChanged(value);
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.accent),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                  labelText: 'Pais',
                  hintText: 'Ingrese el pais',
                  counterText: '',
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                items: departments.entries
                    .map((e) => DropdownMenuItem(value: e.value, child: Text(e.value)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  context.read<AddUserCubit>().onDepartmentChanged(value);
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.accent),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                  labelText: 'Departamento',
                  hintText: 'Ingrese el departamento',
                  counterText: '',
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'Ciudad o Municipio',
                placeholder: 'Ingrese la ciudad o municipio',
                onChanged: (value) {
                  context.read<AddUserCubit>().onCityChanged(value);
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'Complemento',
                placeholder: 'Ingrese el complemento',
                maxLines: 2,
                onChanged: (value) {
                  context.read<AddUserCubit>().onComplementChanged(value);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AddUserCubit>().onAddressChanged();

                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text('Agregar', style: TextStyle(fontSize: 16)),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
