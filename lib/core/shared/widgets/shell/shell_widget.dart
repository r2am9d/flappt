import 'package:flappt/core/extensions/index.dart';
import 'package:flappt/core/l10n/l10n.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShellWidget extends StatelessWidget {
  const ShellWidget({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final shellBloc = context.read<ShellBloc>();

    return BlocListener<ShellBloc, ShellState>(
      listener: (shellCtx, shellState) {
        final shellLoading = shellBloc.states<ShellLoading>();
        final shellError = shellBloc.states<ShellError>();

        // Handle loading state
        if (shellState is ShellLoading && shellLoading != null) {
          shellLoading.loading
              ? LoadingDialog.show(context)
              : LoadingDialog.hide();
        }

        // Handle error state
        if (shellState is ShellError &&
            shellError != null &&
            shellError.message.isNotEmpty) {
          LoadingDialog.hide();
          context.appScaffoldMsgr.hideCurrentSnackBar();
          context.appScaffoldMsgr.showSnackBar(
            SnackBar(
              content: Text(shellError.message),
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
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.appName)),
        body: navigationShell,
        bottomNavigationBar: BottomNavbarWidget(
          navigationShell: navigationShell,
        ),
      ),
    );
  }
}
