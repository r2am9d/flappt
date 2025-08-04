import 'package:flappt/core/extensions/index.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flappt/features/login/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (abContext, abState) {
        final authLoading = authBloc.states<AuthLoading>()!;
        final authError = authBloc.states<AuthError>()!;

        if (abState is AuthLoading && authLoading.loading) {
          LoadingDialog.show(context);
        } else {
          LoadingDialog.hide();
        }

        if (abState is AuthError && authError.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authError.message),
              backgroundColor: context.appColors.error,
            ),
          );
        }
      },
      child: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 48),

                // App Logo/Icon
                AppIconWidget(),

                SizedBox(height: 48),

                // Login Form
                LoginFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
