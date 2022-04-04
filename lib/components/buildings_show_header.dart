import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class BuildingsHeader extends StatefulWidget {
  const BuildingsHeader({Key? key}) : super(key: key);

  @override
  _BuildingsHeaderState createState() => _BuildingsHeaderState();
}

class _BuildingsHeaderState extends State<BuildingsHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Text(
            'Build Name',
            style: TextStyle(fontSize: SizeConfig.w(8)),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            'Edit',
            style: TextStyle(fontSize: SizeConfig.w(5)),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            'Delete',
            style: TextStyle(fontSize: SizeConfig.w(5)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
