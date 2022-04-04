import 'package:abdulaziz_flutter/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class BixesSignedHeader extends StatefulWidget {
  final Function sortByBuilding;
  final Function sortByBix;
  final Function sortByPort;
  final Function sortByExt;
  final Function sortByType;
  final Function sortByLine;
  const BixesSignedHeader({
    Key? key,
    required this.sortByBuilding,
    required this.sortByBix,
    required this.sortByPort,
    required this.sortByExt,
    required this.sortByType,
    required this.sortByLine,
  }) : super(key: key);

  @override
  _BixesSignedHeaderState createState() => _BixesSignedHeaderState();
}

class _BixesSignedHeaderState extends State<BixesSignedHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByBuilding();
            },
            child: Text(
              'Building',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByBix();
            },
            child: Text(
              'Bix Number',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByPort();
            },
            child: Text(
              'Port',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByExt();
            },
            child: Text(
              'Extension',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByType();
            },
            child: Text(
              'Type Of Extension',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              widget.sortByLine();
            },
            child: Text(
              'Line Type',
              style: TextStyle(fontSize: SizeConfig.w(8), color: Colors.black),
              textAlign: TextAlign.center,
            ),
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
