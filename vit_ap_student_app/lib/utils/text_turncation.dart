String truncateText(String text, int maxCharacters) {
  return text.length > maxCharacters
      ? text.substring(0, maxCharacters - 3) + '...'
      : text;
}
