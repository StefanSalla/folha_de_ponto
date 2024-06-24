import 'package:ficha_de_ponto/providers/auth_provider.dart';
import 'package:ficha_de_ponto/providers/pontos_provider.dart';
import 'package:ficha_de_ponto/routes.dart';
import 'package:ficha_de_ponto/screens/detalhes_screen.dart';
import 'package:ficha_de_ponto/screens/form_screen.dart';
import 'package:ficha_de_ponto/screens/home_screen.dart';
import 'package:ficha_de_ponto/screens/signin_screen.dart';
import 'package:ficha_de_ponto/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PontosProvider()
          ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider()
          ),
      ],
      child: MaterialApp(
        title: 'Folha de Ponto',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          Routes.SIGNIN:    (context) => SigninScreen(),
          Routes.SIGNUP:    (context) => SignupScreen(),
          Routes.HOME:      (context) => HomeScreen(),
          Routes.DETAILS: (context) => DetalhesScreen(),
          Routes.FORM:      (context) => FormScreen(),
        },
      ),
    );
  }
}
