import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _topLevelProviders,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: 'DevFest Bari 2024',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        builder: (context, child) {
          return BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: _authListener,
            child: LoaderOverlay(
              useDefaultLoading: false,
              overlayColor: Colors.black.withOpacity(.4),
              overlayWidgetBuilder: (_) {
                return const Center(
                  child: CustomLoader(),
                );
              },
              child: child!,
            ),
          );
        },
      ),
    );
  }
}

List<BlocProvider> _topLevelProviders = <BlocProvider>[
  BlocProvider<AuthenticationCubit>(
    lazy: false,
    create: (context) => AuthenticationCubit(),
  ),
  BlocProvider<TalkCubit>(
    lazy: false,
    create: (context) => TalkCubit(),
  ),
  BlocProvider<QuizCubit>(
    lazy: false,
    create: (context) => QuizCubit(),
  ),
];

void _authListener(
  BuildContext context,
  AuthenticationState state,
) async {
  switch (state.status) {
    case AuthenticationStatus.initial:
      break;
    case AuthenticationStatus.initialAuthFailure:
      context.loaderOverlay.hide();
      FlutterNativeSplash.remove();
      break;
    case AuthenticationStatus.authenticationInProgress:
    case AuthenticationStatus.signOutInProgress:
      context.loaderOverlay.show();
      break;
    case AuthenticationStatus.authenticationSuccess:
      context.loaderOverlay.hide();
      context.read<TalkCubit>().getTalkList();
      appRouter.goNamed(RouteNames.dashboardRoute.name);
      FlutterNativeSplash.remove();
      break;
    case AuthenticationStatus.authenticationFailure:
      context.loaderOverlay.hide();
      String errorMessage = '';
      switch (state.error) {
        case AuthenticationError.invalidCredentials:
          errorMessage = 'Credenziali errate';
          break;
        case AuthenticationError.userNotFound:
          errorMessage = 'Utente non trovato';
          break;
        case AuthenticationError.missingUserData:
          errorMessage = 'Dati utente mancanti';
          break;
        case AuthenticationError.unknown:
          errorMessage = 'Errore sconosciuto';
          break;
        default:
          break;
      }
      final ctx = appRouter.routerDelegate.navigatorKey.currentContext;
      if (ctx != null) {
        showAuthenticationErrorDialog(ctx, errorMessage);
      }
      break;
    case AuthenticationStatus.signOutSuccess:
      context.loaderOverlay.hide();
      appRouter.goNamed(RouteNames.welcomeRoute.name);
      break;
  }
}
