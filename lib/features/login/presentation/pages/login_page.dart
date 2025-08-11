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
        final authLoading = authBloc.states<AuthLoading>();
        final authError = authBloc.states<AuthError>();

        // Handle loading state
        if (abState is AuthLoading && authLoading != null) {
          authLoading.loading
              ? LoadingDialog.show(context)
              : LoadingDialog.hide();
        }

        // Handle error state
        if (abState is AuthError &&
            authError != null &&
            authError.message.isNotEmpty) {
          LoadingDialog.hide();
          context.appScaffoldMsgr.hideCurrentSnackBar();
          context.appScaffoldMsgr.showSnackBar(
            SnackBar(
              content: Text(authError.message),
              backgroundColor: context.appColors.error,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                left: 16,
                right: 16,
              ),
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
