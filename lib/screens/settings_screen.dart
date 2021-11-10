import 'package:flutter/material.dart';
import 'package:flutter_podcast_app/functions/reactivity.dart';
import 'package:flutter_podcast_app/services/color_service.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              child: SettingsOptionTheme(),
              height: Reactivity.menuItemHeight(context),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsOptionTheme extends StatelessWidget {
  const SettingsOptionTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('Theme'),
      trailing: Container(
        width: Reactivity.miniPlayerHeight(context) * 2,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            icon: (context.watch<PrimaryColourSelection>().themeMode ==
                    ThemeMode.dark)
                ? Icon(Icons.nightlight)
                : Icon(Icons.wb_sunny),
          ),
          value: context.read<PrimaryColourSelection>().themeMode.toString(),
          onChanged: (String? newValue) => 1 + 1,
          items: ThemeMode.values
              .map((themeMode) => DropdownMenuItem(
                    child: Text(themeMode.toString().replaceRange(0, 10, '')),
                    value: themeMode.toString(),
                    onTap: () => context
                        .read<PrimaryColourSelection>()
                        .themeMode = themeMode,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
