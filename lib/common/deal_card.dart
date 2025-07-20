import 'package:flutter/material.dart';

class DealCard extends StatefulWidget {
  final String brandLogo;
  final String dealStoreName;
  final String dealValidity;


  const DealCard({
    super.key,
    required this.brandLogo,
    required this.dealStoreName,
    required this.dealValidity,
  });

  @override
  State<DealCard> createState() => _DealCardState();
}

class _DealCardState extends State<DealCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), 
              offset: Offset(4, 4), 
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ]
      ),
      height: 76,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(widget.brandLogo, ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.dealStoreName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Valid Until: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFD62828),
                          ),
                        ),
                        Text(
                          widget.dealValidity,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 63,
              height: 22,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0xFFD62828)
              ),
              child: Center(
                child: Text(
                  '50% OFF',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
