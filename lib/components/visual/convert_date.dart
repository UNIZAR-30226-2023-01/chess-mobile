String convertirFecha(String time) {
  time = DateTime.parse(time).toLocal().toString();
  List<String> fields = time.split(" ");
  String originalDate = fields[0];
  String originalHour = fields[1].substring(0, 5);

  List<String> dateFields = originalDate.split("-");
  String year = dateFields[0];
  String month = dateFields[1];
  String day = dateFields[2];

  return "$day-$month-$year $originalHour";
}
