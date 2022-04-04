import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GetUserInformation {
  getUserInformation(String department, String name, String email, String exNo,
      String mobileNum, String mobileCode, bool color) {
    return pw.Container(
      margin: pw.EdgeInsets.symmetric(
        horizontal: 50,
      ),
      color: color == true
          ? PdfColor.fromHex('#92c5e4')
          : PdfColor.fromHex('#d1e0e0'),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          pw.Expanded(
            child: pw.Text(
              department,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              name,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              email,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              exNo,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              mobileNum,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              mobileCode,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
