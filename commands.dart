import 'clipboard.dart';
import 'storage.dart';
import 'utils.dart';

void execSave() {
  var currentClip = getSystemClipboard();
  saveToHistory(currentClip);
}

void execList() {
  List data = fetchHistory();
  int idx = 0;
  for (var entry in data) {
    var safeText = cleanLine(entry['txt']);
    print('[$idx] ${entry['time']} | ${truncateTxt(safeText, 50)}');
    idx++;
  }
}

void execSearch(String query) {
  var db = fetchHistory();
  var q = query.toLowerCase();
  
  for (int i=0; i<db.length; i++) {
    var txt = db[i]['txt'].toString();
    if(txt.toLowerCase().contains(q)) {
      print('[$i] ${truncateTxt(cleanLine(txt), 60)}');
    }
  }
}

void execCopy(String idParam) {
   var id = int.tryParse(idParam) ?? -99;
   var records = fetchHistory();
   
   if (id >= 0 && id < records.length) {
      setSystemClipboard(records[id]['txt']);
      print('Restored to clipboard!');
   } else {
     print('Invalid ID');
   }
}
