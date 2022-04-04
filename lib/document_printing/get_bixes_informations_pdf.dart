import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GetBixesInformationPDF {
  getBixesInformations(String bixName, String bixPort, String bixExtension,
      String bixType, String lineType, String BuildName, bool color) {
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
              BuildName,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              bixName,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              bixPort,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              bixExtension,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              bixType,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              lineType,
              style: pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
