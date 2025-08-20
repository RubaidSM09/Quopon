import 'package:flutter/material.dart';
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/delivery_view.dart';
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/pickup_view.dart';
import 'package:quopon/app/modules/dealDetail/views/deal_detail_view.dart';

class ChooseRedemptionDealView extends StatefulWidget {
  final String dealImage;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;
  final String dealStoreName;
  final String brandLogo;

  const ChooseRedemptionDealView({
    super.key,
    required this.dealImage,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
    required this.dealStoreName,
    required this.brandLogo
  });

  @override
  State<ChooseRedemptionDealView> createState() => _ChooseRedemptionDealViewState();
}

class _ChooseRedemptionDealViewState extends State<ChooseRedemptionDealView> {
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
            onTap: () {}, // Prevent dismiss on card tap
            child: Container(
              /*height: 400,
              width: 350,*/
              width: 398,
              height: 280,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: DealDetailView(dealImage: widget.dealImage, dealTitle: widget.dealTitle, dealDescription: widget.dealDescription, dealValidity: widget.dealValidity, dealStoreName: widget.dealStoreName, brandLogo: widget.brandLogo, redemptionType: '', deliveryCost: '', minOrder: 0,)
                              );
                            },
                          );
                        },
                          child: Icon(Icons.arrow_back)
                      ),
                      Center(
                          child: Text(
                            "Choose Redemption Method",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          )
                      ),
                      SizedBox()
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Color(0xFFEAECED),
                    thickness: 1,
                  ),
                  SizedBox(height: 5,),
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
                                  child: PickupView(dealImage: widget.dealImage, dealTitle: widget.dealTitle, dealDescription: widget.dealDescription, dealValidity: widget.dealValidity, dealStoreName: widget.dealStoreName, brandLogo: widget.brandLogo)
                              );
                              },
                          );
                          },
                        child: Container(
                          height: 92,
                          width: 155,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFF9FBFC),
                          ),
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: DeliveryView(dealImage: widget.dealImage, dealTitle: widget.dealTitle, dealDescription: widget.dealDescription, dealValidity: widget.dealValidity, dealStoreName: widget.dealStoreName, brandLogo: widget.brandLogo)
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 92,
                            width: 155,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFF9FBFC),
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
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 92,
                    width: 366,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFF9FBFC),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/MyDeals/DealsIcon.png',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(height: 2.5),
                          Text(
                            "Save to My Deals",
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFF020711)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
