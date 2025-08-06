import 'package:flappt/core/extensions/index.dart';
import 'package:flappt/core/keys/app_key.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: AppKey.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormBuilderTextField(
            name: 'username',
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
              prefixIcon: Icon(
                Icons.person,
                color: context.appColors.primary,
              ),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Username is required'),
            ]),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'password',
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icon(
                Icons.lock_outline,
                color: context.appColors.primary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: context.appColors.onSurfaceVariant,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            obscureText: !_isPasswordVisible,
            textInputAction: TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Password is required'),
            ]),
            onSubmitted: (_) => _handleLogin(context: context),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                _handleLogin(context: context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: context.appColors.primary,
                foregroundColor: context.appColors.onPrimary,
                shadowColor: context.appColors.primary.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Sign In',
                style: context.appTextTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.appColors.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin({required BuildContext context}) {
    final authBloc = context.read<AuthBloc>();
    final formState = AppKey.loginFormKey.currentState;

    // Dismiss keyboard and remove focus from fields
    context.appFocusScope.unfocus();

    if (formState != null && formState.saveAndValidate()) {
      final formData = formState.value;
      final username = formData['username'] as String;
      final password = formData['password'] as String;

      authBloc.add(
        AuthExecuteLogin(
          username: username,
          password: password,
        ),
      );
    }
  }
}
