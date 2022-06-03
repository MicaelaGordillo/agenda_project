import 'package:flutter/material.dart';

class Alarm {
  DateTime _fecha;
  TimeOfDay _hora;
  String _descripcion;

  Alarm(this._fecha, this._hora, this._descripcion);

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  TimeOfDay get hora => _hora;

  set hora(TimeOfDay value) {
    _hora = value;
  }

  DateTime get fecha => _fecha;

  set fecha(DateTime value) {
    _fecha = value;
  }
}