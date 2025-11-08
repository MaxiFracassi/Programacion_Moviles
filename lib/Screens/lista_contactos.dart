import 'package:flutter/material.dart';
import 'package:flutter_evs/Providee/contacto_provider.dart';
import 'package:provider/provider.dart';

class ListaContactos extends StatelessWidget {
  const ListaContactos({super.key});
  @override
  Widget build(BuildContext context) {
    final contactoProvider = context.watch<ContactoProvider>();
    final Contacto = contactoProvider.contactosFiltrados;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: /*contactoProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          :*/ Contacto.isEmpty
          ? Center(
              child: contactoProvider.contactos.isEmpty
                  ? Text(" Aun no hay contactos. ")
                  : Text("No se encontraron contactos."),
            )
          : ListView.separated(
              itemCount: Contacto.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (Context, index) {
                final contacto = Contacto[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  title: Text(
                    '${contacto.getNombre()} ${contacto.getApellido()}',
                  ),
                  subtitle: Text('Tel: ${contacto.getTelefono().toString()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.call),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                );
              },
            ),
    );
  }
}
