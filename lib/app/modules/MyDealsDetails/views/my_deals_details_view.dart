import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quopon/common/deal_card.dart';
import 'package:quopon/common/my_deals_card.dart';

class MyDealsDetailsView extends StatefulWidget {
  const MyDealsDetailsView({super.key});

  @override
  State<MyDealsDetailsView> createState() => _MyDealsDetailsViewState();
}

class _MyDealsDetailsViewState extends State<MyDealsDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FBFC),
        title: Center(child: Text('Deal Details')),
        actions: [Image.asset("assets/images/MyDealsDetails/Upload.png")],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/MyDealsDetails/Starbucks.png',
                    fit: BoxFit.cover,
                    width: 398,
                    height: 220,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 5,
                  child: Container(
                    width: 92,
                    height: 24,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xFFD62828)
                    ),
                    child: Center(
                      child: Text(
                        "Expire in 21 hours",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            // Title Row with Text centered
            SizedBox(
              width: 398,
              child: Row(
                children: [
                  Text(
                    "50% Off Any Grande Beverage",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 26,
                    width: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xFFECFDF5),
                    ),
                    child: const Center(
                      child: Text(
                        'Active',
                        style: TextStyle(
                          color: Color(0xFF2ECC71),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6F7E8D), // Default color for the text
                ),
                children: [
                  TextSpan(
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book ",
                  ),
                  TextSpan(
                    text: "Read more...",
                    style: TextStyle(
                      color: Color(0xFFD62828), // Red color for "Read more..."
                      fontWeight: FontWeight.bold, // Optional: Make it bold
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle tap action
                        print("Read more clicked!");
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Align "Vendor" to left
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Vendor",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
              ),
            ),
            SizedBox(height: 5),
            DealCard(
              brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
              dealStoreName: 'Starbucks',
              dealValidity: '11:59 PM, May 31',
            ),
            SizedBox(height: 10),
            // Align "Redemption Method" to left
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Redemption Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 92,
                  width: 195,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => )
                      );*/
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/MyDealsDetails/Pickup Icon.png',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(height: 2.5),
                          Text(
                            "Pickup",
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFF020711)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: 92,
                    width: 195,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/MyDealsDetails/Delivery Icon.png',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(height: 2.5),
                          Text(
                            "Delivery",
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFF020711)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Align "Location" to left
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Location",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: 398,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/images/MyDealsDetails/Location.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),


    );
  }
}
