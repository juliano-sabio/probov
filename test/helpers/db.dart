import 'dart:ffi';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:probov/data/database.dart';
import 'package:sqlite3/open.dart';

var _configurado = false;

/// Cria um banco limpo em memória. Chame em cada `setUp`.
///
/// O override do Windows existe porque `sqlite3_flutter_libs` só entrega a
/// biblioteca dentro do app, não na VM de teste — sem isto, `flutter test`
/// falha com "Couldn't open sqlite3 library". `winsqlite3.dll` ja vem no
/// Windows 10/11, então não é preciso baixar nada.
AppDatabase dbDeTeste() {
  if (!_configurado) {
    if (Platform.isWindows) {
      open.overrideFor(
        OperatingSystem.windows,
        () => DynamicLibrary.open('winsqlite3.dll'),
      );
    }
    _configurado = true;
  }
  return AppDatabase(NativeDatabase.memory());
}
