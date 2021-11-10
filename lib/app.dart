import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/navigation_wrapper.dart';
import 'package:flutter_podcast_app/services/color_service.dart';
import 'package:provider/provider.dart';

class AnimatedAppThemeWrapper extends StatelessWidget {
  const AnimatedAppThemeWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: context.read<PrimaryColourSelection>(),
        builder: (context, child) {
          return MaterialAppEntryPoint();
        });
  }
}

class MaterialAppEntryPoint extends StatelessWidget {
  const MaterialAppEntryPoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme:
          // _theme.getTheme,
          context.read<PrimaryColourSelection>().getTheme,
      darkTheme: context.read<PrimaryColourSelection>().getDarkTheme,
      themeMode: ThemeMode.system,
      //     ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      routeInformationParser: BeamerParser(),
      routerDelegate: NavigationWrapper.routerDelegate,
    );
  }
}
