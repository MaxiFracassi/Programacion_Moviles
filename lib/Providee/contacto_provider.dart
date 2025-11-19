import 'package:flutter/material.dart';
import 'package:flutter_evs/Contacto/contacto.dart';
import 'package:flutter_evs/Providee/db_helper.dart';

class ContactoProvider extends ChangeNotifier {
  List<Contacto> _contacto = [];
  List<Contacto> _contactosFiltrados = [];

  List<Contacto> get contactos => _contacto;
  List<Contacto> get contactosFiltrados => _contactosFiltrados;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ContactoProvider() {
    this.fetchContactos();
  }

  Future<void> fetchContactos() async {
    _setLoading(true);
    _contacto = await DbHelper().getContactos();
    _setLoading(false);
  }

  Future<void> agregarContacto(Contacto nuevoContacto) async {
    _setLoading(true);

    final int id = await DbHelper().insertContacto(nuevoContacto);
    nuevoContacto.id = id;

    _contacto.add(nuevoContacto);

    _setLoading(false);
  }

  Future<void> borrarContacto(int id) async {
    _setLoading(true);

    await DbHelper().deleteContacto(id);
    _contacto.removeWhere((contacto) => contacto.id == id);
    _setLoading(false);
  }

  void setQuery(String query) {
    if (query.isEmpty) {
      _contactosFiltrados = _contacto;
    } else {
      _contactosFiltrados = _contacto.where((contactos) {
        final queryLower = query.toLowerCase();
        final nombreLower = contactos.nombre.toLowerCase();
        final apellidoLower = contactos.apellido.toLowerCase();
        final telefonoString = contactos.telefono.toString();

        return nombreLower.contains(queryLower) ||
            apellidoLower.contains(queryLower) ||
            telefonoString.contains(queryLower);
      }).toList();
    }
    notifyListeners();
  }

  void clearQuery() {
    _contactosFiltrados = _contacto;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /*  List<Contacto> _contactos = [];
  String _query = '';

  List<Contacto> get contactos => List.unmodifiable(_contactos);

  ContactoProvider() {
    generarContactos();
  }

  void generarContactos() {
    _contactos.add(
      Contacto(
        nombre: "juan",
        telefono: 123654789,
        apellido: "Pereira",
        domicilio: "Jb 102",
        genero: "Masculino",
      ),
    );
    _contactos.add(
      Contacto(
        nombre: "Agos",
        telefono: 123654789,
        apellido: "Fracassi",
        domicilio: "Jb 102",
        genero: "Femenino",
      ),
    );
    _contactos.add(
      Contacto(
        nombre: "Mauri",
        telefono: 123654789,
        apellido: "Ramirez",
        domicilio: "Jb 102",
        genero: "Masculino",
      ),
    );
    _contactos.add(
      Contacto(
        nombre: "Pedro",
        telefono: 123654789,
        apellido: "Arguello",
        domicilio: "Jb 102",
        genero: "Masculino",
      ),
    );
    _contactos.add(
      Contacto(
        nombre: "Gorda",
        telefono: 123654789,
        apellido: "Loca",
        domicilio: "Jb 102",
        genero: "Masculino",
      ),
    );
  }

  List<Contacto> get filtrados {
    final q = _query.toLowerCase().trim();
    if (q.isEmpty) return contactos;
    return contactos.where((c) {
      return c.nombre.toLowerCase().contains(q) ||
          c.apellido.toLowerCase().contains(q);
    }).toList();
  }

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void clearQuery() {
    _query = '';
    notifyListeners();
  }

  void addContacto(Contacto contacto) {
    _contactos.add(contacto);
    notifyListeners();
  }

  void removeContacto(Contacto contacto) {
    _contactos.remove(contacto);
    notifyListeners();
  }

  List<Contacto> filtrarContactos(String criterio) {
    return _contactos
        .where(
          (contacto) =>
              contacto.nombre.toLowerCase().contains(criterio.toLowerCase()) ||
              contacto.apellido.toLowerCase().contains(criterio.toLowerCase()),
        )
        .toList();
  }*/
}
