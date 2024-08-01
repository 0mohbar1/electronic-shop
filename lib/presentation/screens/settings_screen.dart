import 'package:electronic_shop/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(provider.isDark ? Icons.nightlight : Icons.sunny),
            Switch(
              value: provider.isDark,
              onChanged: (val) => provider.toggleTheme(),

            ),
          ],
        ),
      ),
    );
  }
}
