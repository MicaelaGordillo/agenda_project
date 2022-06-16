import 'package:flutter/material.dart';

class AlarmaBD {
  int cod_alarma;
  String fecha;
  String hora;
  String descripcion;

  AlarmaBD({required this.cod_alarma, required this.fecha, required this.hora, required this.descripcion});

  Map<String, dynamic> toMap() {
    return {
      'fecha': fecha,
      'hora': hora,
      'descripcion': descripcion
    };
  }
}