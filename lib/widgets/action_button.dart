import 'dart:developer';

import 'package:copyable/data/local_data.dart';
import 'package:copyable/widgets/responsive.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color? fillColor;
  final bool isFilled;
  const ActionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fillColor,
    this.isFilled = false,
  }) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  late double width, height;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return MouseRegion(
      child: GestureDetector(
        onTap: () {
          widget.onPressed((value) {
            log("Updating Button State to $value");
            isLoading = value;
            setState(() {});
          });
        },
        onPanDown: (v) {},
        child: Container(
          height: isLoading
              ? 50
              : Responsive.isDesktop(context)
                  ? 0.075 * height
                  : 0.06 * height,
          width: isLoading ? 50 : double.maxFinite,
          decoration: BoxDecoration(
            color: appData.value.globalColor,
            borderRadius: BorderRadius.circular(isLoading ? 60 : 10.0),
          ),
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Center(
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
