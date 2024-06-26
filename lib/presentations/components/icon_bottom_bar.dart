import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconBottomBar extends StatelessWidget {
  final String name;
  final String iconActive;
  final String iconInactive;
  final bool selected;
  final Function() onPressed;

  const IconBottomBar(
      {super.key,
      required this.name,
      required this.iconActive,
      required this.iconInactive,
      required this.selected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(children: [
        Positioned(
          top: -4,
          child: Container(
            height: 5,
            width: 50,
            color: Colors.blue,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              selected ? iconActive : iconInactive,
              height: 24,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: TextStyle(
                color: selected ? Colors.red : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            )
          ],
        ),
      ]),
    );
  }
}
