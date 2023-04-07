String dateFormat(DateTime dateTime) {
  return '${dateTime.year}/${dateTime.month}/${dateTime.day}';
}

String timeFormat(DateTime dateTime) {
  return '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
}
