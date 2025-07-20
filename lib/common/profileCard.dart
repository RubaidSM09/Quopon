import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final String icon;
  final String title;

  const ProfileCard({
    super.key,
    required this.icon,
    required this.title
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              widget.icon,
              height: 40,
              width: 40,
            ),
            SizedBox(width: 15,),
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,),
            )
          ],
        ),
        Image.asset(
          "assets/images/Profile/NextArrow.png",
          height: 18,
          width: 18,
        ),
      ],
    );
  }
}
