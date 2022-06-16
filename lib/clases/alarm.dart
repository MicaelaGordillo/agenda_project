import 'package:flutter/material.dart';

class Alarm {
  int cod_alarma;
  DateTime fecha;
  TimeOfDay hora;
  String descripcion;

  Alarm({required this.cod_alarma, required this.fecha, required this.hora, required this.descripcion});

  Map<String, dynamic> toMap() {
    return {
      'fecha': fecha,
      'hora': hora,
      'descripcion': descripcion
    };
  }
}