import 'dart:io';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qreader/model/scan_model.dart';
export 'package:qreader/model/scan_model.dart';


class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    //Ruta dond se almacenara ala base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //crear base de datos
    return await openDatabase(
      path, 
      version: 1, 
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(''' 
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      }  
    );
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {

    final id    = nuevoScan.id;
    final tipo  = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //verificar la base de datoss
    final db = await database;
    final res = db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor) 
      VALUES ('$id', '$tipo', '$valor')
    ''');
    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  Future<ScanModel> getScanById(int id) async{
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScans() async{
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty 
    ? res.map((s) => ScanModel.fromJson(s)).toList()
    : [];
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async{
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty 
    ? res.map((s) => ScanModel.fromJson(s)).toList()
    : [];
  }
}