class Contacto {
  int? id;
  String nombre;
  String apellido;
  int telefono;
  String domicilio;
  String genero;

  Contacto({
    this.id,
    required this.nombre,
    required this.telefono,
    required this.apellido,
    required this.domicilio,
    required this.genero,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'apellido': apellido,
      'domicilio': domicilio,
      'genero': genero,
    };
  }

  factory Contacto.fromMap(Map<String, dynamic> map) {
    return Contacto(
      id: map['id'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      telefono: map['telefono'],
      domicilio: map['domicilio'],
      genero: map['genero'],
    );
  }

  String getNombre() {
    return nombre;
  }

  String getApellido() {
    return apellido;
  }

  int getTelefono() {
    return telefono;
  }

  String getDomicilio() {
    return domicilio;
  }

  String getGenero() {
    return genero;
  }
}
