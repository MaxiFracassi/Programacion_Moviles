import 'package:flutter/material.dart';
import 'package:flutter_evs/Providee/contacto_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_evs/Contacto/contacto.dart';

class NuevoContacto extends StatefulWidget {
  const NuevoContacto({super.key});

  @override
  _NuevoContacto createState() => _NuevoContacto();
}

class _NuevoContacto extends State<NuevoContacto> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _domicilioController = TextEditingController();
  String _genero = 'Masculino';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: _apellidoController,
            decoration: const InputDecoration(labelText: 'Apellido'),
          ),
          TextField(
            controller: _telefonoController,
            decoration: const InputDecoration(labelText: 'Telefono'),
            keyboardType: TextInputType.phone,
          ),
          TextField(
            controller: _domicilioController,
            decoration: const InputDecoration(labelText: 'Domicilio'),
          ),
          DropdownButton<String>(
            value: _genero,
            items: <String>['Masculino', 'Femenino', 'Otro'].map((
              String value,
            ) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _genero = newValue!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              final String nombre = _nombreController.text;
              final String apellido = _apellidoController.text;
              final String telefono = _telefonoController.text;
              final String domicilio = _domicilioController.text;
              final int? telefonoInt = int.tryParse(telefono);
              if (nombre.isNotEmpty &&
                  apellido.isNotEmpty &&
                  domicilio.isNotEmpty &&
                  _genero.isNotEmpty &&
                  telefonoInt != null) {
                final nuevoContacto = Contacto(
                  nombre: nombre,
                  apellido: apellido,
                  telefono: telefonoInt,
                  domicilio: domicilio,
                  genero: _genero,
                );

                context.read<ContactoProvider>().agregarContacto(nuevoContacto);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, complete todos los campos'),
                  ),
                );
              }
            },
            child: const Text('Agregar Contacto'),
          ),
        ],
      ),
    );
  }
}
