import 'package:devfest_bari_2025/app.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: AppListener(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          title: 'DevFest Bari 2025',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          ),
          builder: (context, child) {
            return LoaderOverlay(
              overlayColor: Colors.black.withValues(alpha: 0.4),
              overlayWidgetBuilder: (_) => const Center(child: CustomLoader()),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
