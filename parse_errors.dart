import 'dart:io';

void main() {
  final file = File('analyze_machine.txt');
  final lines = file.readAsLinesSync();
  int count = 0;
  for (final line in lines) {
    if (line.startsWith('ERROR|')) {
      print(line);
      count++;
    }
    if (count >= 30) break;
  }
}
