import 'dart:io';
import 'dart:convert';
import 'utils.dart';

final dbFile = File('history_db.json');

List<dynamic> fetchHistory() {
  if(!dbFile.existsSync()) return [];
  try {
    var raw = dbFile.readAsStringSync();
    return jsonDecode(raw);
  } catch(e) {
     return [];
  }
}

void saveToHistory(String text) {
  if (text.isEmpty) return;
  
  var db = fetchHistory();
  
  // dedup
  db.removeWhere((item) => item['txt'] == text);
  
  db.insert(0, {
    'txt': text,
    'time': getTimestamp()
  });
  
  if(db.length > 20) {
     db = db.sublist(0, 20);
  }
  
  dbFile.writeAsStringSync(jsonEncode(db));
}
