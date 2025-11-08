import 'package:flutter/material.dart';
import 'package:flutter_evs/Providee/contacto_provider.dart';
import 'package:flutter_evs/Screens/lista_contactos.dart';
import 'package:flutter_evs/Screens/login.dart';
import 'package:flutter_evs/Screens/nuevo_contacto.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contactos extends StatefulWidget {
  const Contactos({super.key});

  @override
  State<Contactos> createState() => _ContactosState();
}

class _ContactosState extends State<Contactos> {
  bool _buscando = false;
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final Provider = context.read<ContactoProvider>();
      Provider.setQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buscando
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar contacto...',
                  border: InputBorder.none,
                ),
                onChanged: (txt) =>
                    context.read<ContactoProvider>().setQuery(txt),
              )
            : const Text('Contactos'),
        actions: [
          if (_buscando)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<ContactoProvider>().clearQuery();
              },
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() => _buscando = true),
            ),

            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == "config") {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('estadoLogueado', false);
                  print("Sesion cerrada!");

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (contex) => Login()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: "config", child: Text("Cerrar sesion")),
              ],
            ),
          ],
        ],
        leading: _buscando
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() => _buscando = false);
                  _searchController.clear();
                  context.read<ContactoProvider>().clearQuery();
                },
              )
            : null,
      ),

      body: const ListaContactos(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const NuevoContacto(),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
