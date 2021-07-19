import 'package:moor/moor_web.dart';
import 'package:moordemo/data_provider/database_manager.dart';


AppDatabase openConnection({bool logStatements = false}) {
  return AppDatabase(WebDatabase('db', logStatements: logStatements));
}
