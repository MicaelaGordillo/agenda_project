
import 'package:agenda_project/clases/tarea.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class funciones{
  late Database db;


  Future open() async{
    db = await openDatabase(
      join(await getDatabasesPath(), 'agenda1.db'),
      onCreate: (db, version) async {
        //query de creacion
        return db.execute(
            "CREATE TABLE Tarea (cod_tarea integer NOT NULL CONSTRAINT Tarea_pk PRIMARY KEY AUTOINCREMENT,"+
                "descripcion text NOT NULL, fecha_inicio text NOT NULL, fecha_final text NOT NULL,terminada integer NOT NULL);"
        );
      },
      version: 1,
    );
  }
  //insertar tarea
  Future<void> insertTarea(Tarea tarea) async {
    await db.insert(
      'tarea',
      tarea.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Mostrar tarea
  Future<List<Tarea>> tareas() async {
    final List<Map<String, dynamic>> maps = await db.query('tarea');
    return List.generate(maps.length, (i) {
      return Tarea(
        cod_tarea: maps[i]['cod_tarea'],
        descripcion: maps[i]['descripcion'],
        fecha_inicio: maps[i]['fecha_inicio'],
        fecha_final: maps[i]['fecha_final'],
        terminada: maps[i]['terminada'],
      );
    });
  }
  //update tarea
  Future<void> updateTarea(Tarea tarea) async {
    await db.update(
      'tarea',
      tarea.toMap(),
      where: "cod_tarea = ?",
      whereArgs: [tarea.cod_tarea],
    );
  }

  //eliminar tarea
  Future<void> deleteTarea(int id) async {
    await db.delete(
      'tarea',
      where: "cod_tarea = ?",
      whereArgs: [id],
    );
  }
  Future close() async => db.close();
}