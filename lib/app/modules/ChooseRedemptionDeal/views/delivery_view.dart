import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/deal_card.dart';
import '../../ChooseRedemptionDeal/views/choose_redemption_deal_view.dart';

class DeliveryView extends GetView {
  final String dealImage;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;
  final String dealStoreName;
  final String brandLogo;

  const DeliveryView({
    required this.dealImage,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
    required this.dealStoreName,
    required this.brandLogo,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);  // Close the detail view on tapping outside
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.0),
        body: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
                width: 398,
                height: 416,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: ChooseRedemptionDealView(dealImage: dealImage, dealTitle: dealTitle, dealDescription: dealDescription, dealValidity: dealValidity, dealStoreName: dealStoreName, brandLogo: brandLogo)
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.arrow_back)
                        ),
                        Center(
                            child: Text(
                              "Delivery",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            )
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close, size: 24,)
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Divider(
                      color: Color(0xFFEAECED),
                      thickness: 1,
                    ),
                    SizedBox(height: 5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Image.asset(
                            "assets/images/Delivery/Scooter.gif",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Let’s Get It Delivered",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Color(0xFF020711)),
                            ),
                            Text(
                              "You’ll now use this redeem code during checkout.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFF6F7E8D)),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF8FAFB),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          height: 52,
                          width: 366,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "PN14096",
                                  style: TextStyle(
                                    color: Color(0xFF020711),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Image.asset(
                                    "assets/images/Delivery/copy.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                    DealCard(
                      brandLogo: brandLogo,
                      dealStoreName: dealStoreName,
                      dealValidity: dealValidity,
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}
