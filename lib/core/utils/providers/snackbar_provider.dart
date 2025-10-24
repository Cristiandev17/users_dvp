import 'package:flutter/material.dart';

abstract class SnackbarProvider {
  Future<void> successMessenger(BuildContext context, String message, String title);

  Future<void> errorMessenger(BuildContext context, String message, String title);

  Future<void> warningMessenger(BuildContext context, String message, String title);
}
