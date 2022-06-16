class Tarea{
  int cod_tarea;
  String descripcion;
  String fecha_inicio;
  int terminada;


  Tarea({required this.cod_tarea, required this.descripcion, required this.fecha_inicio,
      required this.terminada});

  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'fecha_inicio': fecha_inicio,
      'terminada': terminada
    };
  }

  @override
  String toString() {
    return 'Tarea{id: $cod_tarea, desc: $descripcion, inicio: $fecha_inicio, terminada: $terminada}';
  }

}