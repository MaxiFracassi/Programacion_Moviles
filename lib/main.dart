import 'package:flutter/material.dart';
import 'package:flutter_evs/Providee/contacto_provider.dart';
import 'package:flutter_evs/Screens/contactos.dart';
import 'package:flutter_evs/Screens/lista_contactos.dart';
import 'package:flutter_evs/Screens/login.dart';
import 'package:flutter_evs/Screens/nuevo_contacto.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool estaLogueado = prefs.getBool('estaLogueado') ?? false;

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ContactoProvider())],
      child: MyApp(estaLogueado: estaLogueado),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool estaLogueado;

  const MyApp({Key? Key, required this.estaLogueado}) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: estaLogueado ? '/contactos' : '/login',
      routes: {
        '/login': (context) => const Login(),
        '/contactos': (context) => const Contactos(),
        '/lista_contactos': (context) => ListaContactos(),
        '/nuevo_contacto': (contex) => NuevoContacto(),
      },
    );
  }
}
