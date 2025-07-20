import 'package:flutter/material.dart';

class MyDealsCard extends StatefulWidget {
  const MyDealsCard({super.key});

  @override
  State<MyDealsCard> createState() => _MyDealsCardState();
}

class _MyDealsCardState extends State<MyDealsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: 398,
        height: 82,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                  'assets/images/MyDeals/StarBucks.png'
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '50% Off Any Grande Beverage',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFF020711)
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Valid: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xFFD62828)
                        ),
                      ),
                      Text(
                        '28 May 2025 - 10 Jun 2025',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xFF6F7E8D)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 26,
                width: 58,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xFFECFDF5)
                ),
                child: Center(
                    child: Text('Active', style: TextStyle(color: Color(0xFF2ECC71), fontSize: 12, fontWeight: FontWeight.w400),)
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
