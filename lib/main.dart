import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subspace/providers/theme_provider.dart';
import 'package:subspace/screens/home_screen.dart';
import 'package:subspace/utils/user_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPrefs.init();
  ThemeProvider().loadTheme;
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, ThemeProvider themeProvider, child) {
      return MaterialApp(
          color: Colors.white,
          debugShowCheckedModeBanner: false,
          title: 'SubSpace',
          theme: ThemeData(
              colorScheme: themeProvider.getDarkTheme
                  ? const ColorScheme.dark(
                      background: Colors.white12,
                      primary: Colors.grey)
                  : const ColorScheme.light(
                      background: Colors.white,
                    ),
              useMaterial3: true),
          home: const HomeScreen());
    });
  }
}
