String addNewlines(String input, int maxLength) {
  List<String> words = input.split(' ');
  StringBuffer result = StringBuffer();
  int currentLineLength = 0;

  for (var word in words) {
    if (currentLineLength + word.length > maxLength) {
      if (currentLineLength > 0) {
        result.write('\n');
        currentLineLength = 0;
      }
    } else if (currentLineLength > 0) {
      result.write(' ');
      currentLineLength += 1;
    }
    result.write(word);
    currentLineLength += word.length;
  }
  
  return result.toString();
}