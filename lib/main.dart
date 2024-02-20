import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_vibes/controllers/MenuController.dart';
import 'package:volunteer_vibes/screens/auth_screen.dart';
import 'package:volunteer_vibes/screens/login_screen.dart';
import 'package:volunteer_vibes/screens/register_volunteer.dart';
import 'package:volunteer_vibes/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuControllers()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Volunteer Vibes',
      theme: HAppTheme.lightTheme,
      darkTheme: HAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: AuthScreen(),
    );
  }
}
