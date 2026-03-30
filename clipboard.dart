import 'dart:io';

String getSystemClipboard() {
  // powershell
  var result = Process.runSync('powershell', ['-command', 'Get-Clipboard']);
  return result.stdout.toString().trim();
}

void setSystemClipboard(String val) {
  var f = File('.cliptmp');
  f.writeAsStringSync(val);
  
  // hack
  Process.runSync('cmd', ['/c', 'clip < .cliptmp']);
  
  if (f.existsSync()) {
    f.deleteSync();
  }
}
