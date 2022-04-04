import 'package:abdulaziz_flutter/document_printing/get_user_information_pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GetPdfBody {
  getUsers(List<dynamic> tempUsers) {
    List<pw.Widget> rows = [];
    for (var ind = 0; ind < tempUsers.length; ind++) {
      rows.add(GetUserInformation().getUserInformation(
        tempUsers[ind]['Dep'],
        tempUsers[ind]['Username'],
        tempUsers[ind]['Email'],
        tempUsers[ind]['NO'],
        tempUsers[ind]['mobileNum'],
        tempUsers[ind]['mobileCode'],
        ind % 2 == 0 ? true : false,
      ));
    }
    return rows;
  }

  getBixes(List<dynamic> tempBixes) {
    List<pw.Widget> rows = [];
    for (var ind = 0; ind < tempBixes.length; ind++) {
      rows.add(GetUserInformation().getUserInformation(
        tempBixes[ind]['buildName'],
        tempBixes[ind]['bixName'],
        tempBixes[ind]['bixPort'],
        tempBixes[ind]['bixExtension'],
        tempBixes[ind]['bixType'],
        tempBixes[ind]['lineType'],
        ind % 2 == 0 ? true : false,
      ));
    }
    return rows;
  }
}
