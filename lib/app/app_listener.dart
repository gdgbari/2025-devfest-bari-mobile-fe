import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AppListener extends StatelessWidget {
  final Widget child;

  const AppListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener>[
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: _authListener,
        ),
        BlocListener<InternetCubit, InternetState>(
          listener: _internetListener,
        ),
      ],
      child: child,
    );
  }
}

void _authListener(
  BuildContext context,
  AuthenticationState state,
) async {
  switch (state.status) {
    case AuthenticationStatus.initialAuthFailure:
      context.loaderOverlay.hide();
      FlutterNativeSplash.remove();
      break;
    case AuthenticationStatus.signUpInProgress:
    case AuthenticationStatus.checkInInProgress:
    case AuthenticationStatus.authenticationInProgress:
    case AuthenticationStatus.signOutInProgress:
      context.loaderOverlay.show();
      break;
    case AuthenticationStatus.checkInRequired:
      context.loaderOverlay.hide();
      appRouter.goNamed(RouteNames.checkInRoute.name);
      FlutterNativeSplash.remove();
      break;
    case AuthenticationStatus.checkInSuccess:
    case AuthenticationStatus.authenticationSuccess:
      context.loaderOverlay.hide();
      context
          .read<LeaderboardCubit>()
          .fetchLeaderboard(state.userProfile.userId);
      appRouter.goNamed(RouteNames.leaderboardRoute.name);
      FlutterNativeSplash.remove();
      break;
    case AuthenticationStatus.signUpFailure:
      context.loaderOverlay.hide();
      String errorMessage = '';
      switch (state.error) {
        case AuthenticationError.userAlreadyRegistered:
          errorMessage =
              'Email already registered.\nPlease use a different email or login.';
          break;
        case AuthenticationError.invalidCredentials:
          errorMessage = 'Invalid data entered.\nPlease try again.';
          break;
        case AuthenticationError.unknown:
          errorMessage = 'An unknown error occurred.\nPlease try again later.';
          break;
        default:
          break;
      }
      final ctx = appRouter.routerDelegate.navigatorKey.currentContext;
      if (ctx != null) {
        await showCustomErrorDialog(ctx, errorMessage);
      }
      break;
    case AuthenticationStatus.authenticationFailure:
      context.loaderOverlay.hide();
      String errorMessage = '';
      switch (state.error) {
        case AuthenticationError.userNotFound:
          errorMessage = 'Email not registered.\nPlease try again.';
          break;
        case AuthenticationError.invalidCredentials:
          errorMessage = 'Invalid data entered.\nPlease try again.';
          break;
        case AuthenticationError.unknown:
          errorMessage = 'An unknown error occurred.\nPlease try again later.';
          break;
        default:
          break;
      }
      final ctx = appRouter.routerDelegate.navigatorKey.currentContext;
      if (ctx != null) {
        await showCustomErrorDialog(ctx, errorMessage);
      }
      break;
    case AuthenticationStatus.signOutSuccess:
      context.loaderOverlay.hide();
      appRouter.goNamed(RouteNames.welcomeRoute.name);
      break;
    default:
      break;
  }
}

void _internetListener(
  BuildContext context,
  InternetState state,
) {
  if (state is InternetDisconnected) {
    context.loaderOverlay.hide();
    appRouter.goNamed(RouteNames.noInternetRoute.name);
    FlutterNativeSplash.remove();
  }

  if (state is InternetConnected) {
    context.read<LeaderboardCubit>().changeLeaderboard(0);
    final route = context.read<AuthenticationCubit>().state.isAuthenticated
        ? RouteNames.leaderboardRoute
        : RouteNames.welcomeRoute;

    appRouter.goNamed(route.name);
  }
}
