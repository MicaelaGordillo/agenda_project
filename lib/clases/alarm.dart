import 'package:flutter/material.dart';

class Alarm {
  String _fecha;
  String _hora;
  String _descripcion;

  Alarm(this._fecha, this._hora, this._descripcion);

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  String get hora => _hora;

  set hora(String value) {
    _hora = value;
  }

  String get fecha => _fecha;

  set fecha(String value) {
    _fecha = value;
  }

}