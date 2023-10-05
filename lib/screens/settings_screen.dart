import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subspace/providers/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.grey,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          title: const Text("Settings"),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 22),
                  ),
                  Switch(
                    value: themeProvider.getDarkTheme,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
