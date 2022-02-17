import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/navigation_wrapper.dart';
import 'package:flutter_podcast_app/services/color_service.dart';
import 'package:provider/provider.dart';

/// AnimatedBuilder wrapping MaterialApp ala skeleton template
/// * ref: flutter create -t skeleton
/// * Possibly unecessary, but given that I'm trying to squash some secret
/// performance issues keeping this to a suggested structure is for the best
class AnimatedAppThemeWrapper extends StatelessWidget {
  const AnimatedAppThemeWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: context.watch<PrimaryColourSelection>(),
        builder: (context, child) {
          return MaterialAppEntryPoint();
        });
  }
}

/// Creates the actual MaterialApp
/// * hands off to a router delegate that is currently created by the
/// Beamer package
class MaterialAppEntryPoint extends StatelessWidget {
  const MaterialAppEntryPoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: 'wavy_podcasting_app',
      title: 'Flutter Demo',
      theme:
          // _theme.getTheme,
          context.read<PrimaryColourSelection>().getTheme,
      darkTheme: context.read<PrimaryColourSelection>().getDarkTheme,
      themeMode: context.read<PrimaryColourSelection>().themeMode,
      //     ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      routeInformationParser: BeamerParser(),
      routerDelegate: NavigationWrapper.routerDelegate,
    );
  }
}
