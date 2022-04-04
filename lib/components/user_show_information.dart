import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class UserShowInformation extends StatelessWidget {
  final String department, name, email, exNo, mobileNum, mobileCode;
  final bool color;
  const UserShowInformation({
    Key? key,
    required this.department,
    required this.name,
    required this.email,
    required this.exNo,
    required this.color,
    required this.mobileNum,
    required this.mobileCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      color:
          color == true ? Color.fromARGB(255, 146, 197, 228) : Colors.white70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              department,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              email,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              exNo,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              mobileNum,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              mobileCode,
              style: TextStyle(fontSize: SizeConfig.w(6)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
