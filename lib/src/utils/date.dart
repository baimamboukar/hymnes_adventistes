class DateUtils {
  static formatFr(String date) {
    var now = DateTime.now();

    List<String> months = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre'
    ];
    String month = months[now.month - 1];
    return '${now.day} $month, ${now.year}';
  }
}
