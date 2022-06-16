import 'package:agenda_project/clases/tarea.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'actividad.dart';
class Operation{
  static Future<Database> _openDB() async{
    return openDatabase(
      join(await getDatabasesPath(), 'prueba6.db'), onCreate: (db, version){
        db.execute("CREATE TABLE Tarea (cod_tarea integer NOT NULL CONSTRAINT Tarea_pk PRIMARY KEY AUTOINCREMENT,"+
            "descripcion text NOT NULL, fecha_inicio text NOT NULL, terminada integer NOT NULL);");
        db.execute("CREATE TABLE Actividad (cod_actividad integer NOT NULL CONSTRAINT Actividad_pk PRIMARY KEY AUTOINCREMENT,"+
            "descripcion text NOT NULL, fecha_realizacion text NOT NULL,hora_inicio text NOT NULL,hora_final text NOT NULL);");
        return db.execute("CREATE TABLE Alarma (cod_alarma integer NOT NULL CONSTRAINT Alarma_pk PRIMARY KEY AUTOINCREMENT,"+
            "fecha text NOT NULL, hora text NOT NULL,descripcion text NOT NULL);"
        );
      }, version: 1);
  }

  //insert tarea
  static Future<int> insertTarea(Tarea tarea) async{
    Database database = await _openDB();
    return database.insert("tarea", tarea.toMap());
  }

  //Mostrar tarea
  static Future<List<Tarea>> tareas() async {
    Database db = await _openDB();
    final List<Map<String, dynamic>> maps = await db.query('tarea');
    return List.generate(maps.length, (i) {
      return Tarea(
        cod_tarea: maps[i]['cod_tarea'],
        descripcion: maps[i]['descripcion'],
        fecha_inicio: maps[i]['fecha_inicio'],
        terminada: maps[i]['terminada']
      );
    });
  }
  //update tarea
  static Future<int> updateTarea(Tarea tarea) async {
    Database db = await _openDB();
    return db.update(
      'tarea',
      tarea.toMap(),
      where: "cod_tarea = ?",
      whereArgs: [tarea.cod_tarea],
    );
  }

  //eliminar tarea
  static Future<int> deleteTarea(int id) async {
    Database db = await _openDB();
    return db.delete(
      'tarea',
      where: "cod_tarea = ?",
      whereArgs: [id],
    );
  }


  //insert actividad
  static Future<int> insertActividad(Actividad actividad) async{
    Database database = await _openDB();
    return database.insert("actividad", actividad.toMap());
  }

  //Mostrar actividad
  static Future<List<Actividad>> actividades() async {
    Database db = await _openDB();
    final List<Map<String, dynamic>> maps = await db.query('actividad');
    return List.generate(maps.length, (i) {
      return Actividad(
          cod_actividad: maps[i]['cod_actividad'],
          descripcion: maps[i]['descripcion'],
          fecha_realizacion: maps[i]['fecha_realizacion'],
          hora_inicio: maps[i]['hora_inicio'],
          hora_final: maps[i]['hora_final']
      );
    });
  }
  //update actividad
  static Future<int> updateActividad(Actividad actividad) async {
    Database db = await _openDB();
    return db.update(
      'actividad',
      actividad.toMap(),
      where: "cod_actividad = ?",
      whereArgs: [actividad.cod_actividad],
    );
  }

  //eliminar actividad
  static Future<int> deleteActividad(int id) async {
    Database db = await _openDB();
    return db.delete(
      'actividad',
      where: "cod_actividad = ?",
      whereArgs: [id],
    );
  }

}