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
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFDF4F4)
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                widget.icon,
              ),
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
