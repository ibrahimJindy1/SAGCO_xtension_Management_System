class Sorting {
  List<dynamic> sortUsersByDepartment(
      List<dynamic> tempUsers, String typeS, bool reversed) {
    tempUsers.sort((a, b) => a[typeS]
        .toString()
        .toLowerCase()
        .trim()
        .compareTo(b[typeS].toString().toLowerCase().trim()));
    if (reversed) {
      tempUsers = tempUsers.reversed.toList();
    }

    return tempUsers;
  }

  List<dynamic> sortbixesByDepartment(
      List<dynamic> tempBixes, String typeS, bool reversed) {
    tempBixes.sort((a, b) => a[typeS]
        .toString()
        .toLowerCase()
        .trim()
        .compareTo(b[typeS].toString().toLowerCase().trim()));
    if (reversed) {
      tempBixes = tempBixes.reversed.toList();
    }

    return tempBixes;
  }
}
