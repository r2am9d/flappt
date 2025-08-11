import 'package:flappt/core/extensions/index.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.appSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Page'),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthExecuteLogout());
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
