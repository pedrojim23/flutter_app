import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/pages/auth_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa Firebase con las opciones predeterminadas para la plataforma actual.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Este widget es la raíz de tu aplicación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      // Establece la página de inicio como AuthPage.
      home: const AuthPage(),
    );
  }
}
