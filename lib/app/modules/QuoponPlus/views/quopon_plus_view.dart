import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/QuoponPlus/views/quopon_plus_benifits_view.dart';
import 'package:quopon/common/red_button.dart';

import '../controllers/quopon_plus_controller.dart';

class QuoponPlusView extends GetView<QuoponPlusController> {
  const QuoponPlusView({super.key});
  @override
  Widget build(BuildContext context) {
    RxBool isMonthly = true.obs;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Qoupon+',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close),
                  )
                ],
              ),

              SizedBox(height: 5,),

              Divider(),

              SizedBox(height: 10,),

              Text(
                'Unlock Exclusive Benefits',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              Text(
                'Access exclusive deals, enhanced savings, and premium member benefits with Qoupon+.',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFF6F7E8D)),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFF9FBFC)
                ),
                padding: EdgeInsetsGeometry.only(left: 16, right: 16, top: 20, bottom: 20),
                child: Column(
                  children: [
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/Access.png',
                      title: 'Access premium-only deals',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                    SizedBox(height: 10,),
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/EarlyAccess.png',
                      title: 'Early access to limited offers',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                    SizedBox(height: 10,),
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/Cashback.png',
                      title: 'Extra cashback on select vendors',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                    SizedBox(height: 10,),
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/MonthlySurprise.png',
                      title: 'Monthly surprise deals',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),

              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(!isMonthly.value){
                          isMonthly.value = !isMonthly.value;
                        }
                      },
                      child: Container(
                        width: 185,
                        height: 112,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: isMonthly.value ? Color(0xFFD62828) : Color(0xFFEAECED), width: 1.6)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Monthly',
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                                  ),
                                  isMonthly.value ?
                                      Container(
                                        height: 16,
                                        width: 16,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFD62828)
                                        ),
                                        child: Center(child: Icon(Icons.check, color: Colors.white, size: 12,)),
                                      ) :
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Color(0xFFEAECED))
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '\$4.99/Month',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Color(0xFF020711)),
                              ),
                              Text(
                                'Billed Monthly',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        if(isMonthly.value){
                          isMonthly.value = !isMonthly.value;
                        }
                      },
                      child: Container(
                        width: 185,
                        height: 112,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isMonthly.value ? Color(0xFFEAECED) : Color(0xFFD62828), width: 1.6)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Yearly',
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                                  ),
                                  isMonthly.value ?
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Color(0xFFEAECED))
                                    ),
                                  ) :
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFD62828)
                                    ),
                                    child: Center(child: Icon(Icons.check, color: Colors.white, size: 12,)),
                                  )
                                ],
                              ),
                              Text(
                                '\$49.99/year',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Color(0xFF020711)),
                              ),
                              Text(
                                'Billed Yearly',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 30,),

              RedButton(buttonText: 'Upgrade Plan', onPressed: () { }),

              SizedBox(height: 10,),

              Text(
                'Cancel anytime. Plan renew automatically',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
              ),

              SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );
  }
}
