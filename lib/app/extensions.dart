extension NotNullString on String? {
  String orEmpty() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }
}

extension NotNullInt on int? {
  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}
