String truncateTxt(String str, int len) {
  if (str.length <= len) return str;
  return str.substring(0, len) + '...';
}

// time
String getTimestamp() => DateTime.now().toIso8601String().split('T').last.substring(0,8);

String cleanLine(String input) {
  var noNewlines = input.replaceAll('\r\n', ' ').replaceAll('\n', ' ');
  return noNewlines.trim();
}
