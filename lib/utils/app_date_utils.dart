class AppDateUtils {
  static String toApiFormat(String dateString) {
    if (dateString.isEmpty) return "";

    if (dateString.contains('/')) {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        return "${parts[2]}-${parts[1]}-${parts[0]}";
      }
    }

    return dateString;
  }

  static String toUiFormat(String dateString) {
    if (dateString.isEmpty) return "";

    if (dateString.contains('-')) {
      final parts = dateString.split('-');
      if (parts.length == 3) {
        return "${parts[2]}/${parts[1]}/${parts[0]}";
      }
    }

    return dateString;
  }
}
