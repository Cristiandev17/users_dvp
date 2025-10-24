import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:users_dvp_app/core/utils/providers/snackbar_provider.dart';
import 'package:cherry_toast/resources/arrays.dart';

class SnackbarProviderImpl implements SnackbarProvider {
  @override
  Future<void> errorMessenger(
    BuildContext context,
    String message,
    String title, [
    Position toastPosition = Position.bottom,
  ]) async {
    CherryToast.error(
      title: Text(title),
      action: Text(message),
      toastPosition: toastPosition,
    ).show(context);
  }

  @override
  Future<void> successMessenger(
    BuildContext context,
    String message,
    String title, [
    Position toastPosition = Position.bottom,
  ]) async {
    CherryToast.success(
      title: Text(title),
      action: Text(message),
      toastPosition: toastPosition,
    ).show(context);
  }

  @override
  Future<void> warningMessenger(
    BuildContext context,
    String message,
    String title, [
    Position toastPosition = Position.bottom,
  ]) async {
    CherryToast.warning(
      title: Text(title),
      action: Text(message),
      toastPosition: toastPosition,
    ).show(context);
  }
}
