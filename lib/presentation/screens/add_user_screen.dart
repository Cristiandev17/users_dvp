import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:users_dvp_app/presentation/widgets/custom_text_field.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
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
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  title: 'Apellido',
                  placeholder: 'Ingrese su apellido',
                  startIcon: const Icon(RemixIcons.account_circle_line),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  title: 'Fecha de nacimiento',
                  placeholder: 'Ingrese la fecha',
                  typeKeyboard: TextInputType.datetime,
                  startIcon: const Icon(RemixIcons.calendar_line),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
