class Actividad{
  int cod_actividad;
  String descripcion;
  String fecha_inicio;
  String fecha_final;
  String hora_inicio;
  String hora_final;


  Actividad({required this.cod_actividad, required this.descripcion, required this.fecha_inicio,
      required this.fecha_final, required this.hora_inicio, required this.hora_final});

  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'fecha_inicio': fecha_inicio,
      'fecha_final': fecha_final,
      'hora_inicio': hora_inicio,
      'hora_final': hora_final,
    };
  }

  // Implementa toString para que sea más fácil ver información sobre cada perro
  // usando la declaración de impresión.
  @override
  String toString() {
    return 'Actividad{id: $cod_actividad, desc: $descripcion, inicio: $fecha_inicio $hora_inicio, final: $fecha_final $hora_final}';
  }

}