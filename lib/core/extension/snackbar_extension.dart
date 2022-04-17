import 'package:esport_flame/app/entitiles/failure.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:flutter/material.dart';

extension ContextExtForBaseState on BuildContext {
  void showErrorSnackBar(BaseError error) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(error.failure.errorMessage)),
    );
  }

  void showFailureSnackBar(Failure failure) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(failure.errorMessage)),
    );
  }

  void showSnackBar(String message, IconData icon, Color iconColor) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            Text(message),
            const SizedBox(width: 15)
          ],
        ),
      ),
    );
  }
}
