import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class userShowHeader extends StatefulWidget {
  final Function sortByDep;
  final Function sortByName;
  final Function sortByEmail;
  final Function sortByExtNo;
  final Function sortByMobNum;
  final Function sortByMobCode;
  const userShowHeader({
    Key? key,
    required this.sortByDep,
    required this.sortByName,
    required this.sortByEmail,
    required this.sortByExtNo,
    required this.sortByMobNum,
    required this.sortByMobCode,
  }) : super(key: key);

  @override
  State<userShowHeader> createState() => _userShowHeaderState();
}

class _userShowHeaderState extends State<userShowHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByDep();
            },
            child: Text(
              'Department',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByName();
            },
            child: Text(
              'Name',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByEmail();
            },
            child: Text(
              'Email',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByExtNo();
            },
            child: Text(
              'Extension NO.',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByMobNum();
            },
            child: Text(
              'Mobile Num',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByMobCode();
            },
            child: Text(
              'Mobile Code',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
