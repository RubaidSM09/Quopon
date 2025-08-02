import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil

import '../../../../common/customTextButton.dart';
import '../controllers/vendor_deal_performance_controller.dart';

class VendorDealPerformanceView extends GetView<VendorDealPerformanceController> {
  const VendorDealPerformanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),  // Use ScreenUtil for padding
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Deal Performance',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,  // Use ScreenUtil for font size
                        color: Color(0xFF020711)
                    ),
                  ),
                  SizedBox.shrink()
                ],
              ),

              SizedBox(height: 20.h),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 16)]
                ),
                padding: EdgeInsets.all(12.r),  // Use ScreenUtil for padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                      child: Image.asset('assets/images/DealPerformance/Shakes.jpg'),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '50% Off Any Grande Beverage',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,  // Use ScreenUtil for font size
                              color: Color(0xFF020711)
                          ),
                        ),
                        Container(
                            height: 26.h,
                            width: 58.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: Color(0xFFECFDF5)
                            ),
                            child: Center(
                                child: Text(
                                  'Active',
                                  style: TextStyle(color: Color(0xFF2ECC71), fontSize: 12.sp, fontWeight: FontWeight.w400),
                                )
                            )
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/DealPerformance/Valid.png'),
                        SizedBox(width: 5.w),
                        Text(
                          '28 May 2025 - 10 Jun 2025',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,  // Use ScreenUtil for font size
                              color: Color(0xFF6F7E8D)
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 16)]
                ),
                padding: EdgeInsets.all(12.r),  // Use ScreenUtil for padding
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 52.w, right: 52.w, top: 12.h, bottom: 12.h),  // Use ScreenUtil for padding
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Color(0xFFEFF6FF),
                              border: Border.all(color: Color(0xFFE2ECFD))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 28.h,
                                width: 28.w,
                                padding: EdgeInsets.all(6.r),  // Use ScreenUtil for padding
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: Image.asset('assets/images/DealPerformance/Views.png'),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                '2,547',
                                style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 16.sp, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'Total Views',
                                style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 12.sp, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 52.w, right: 52.w, top: 12.h, bottom: 12.h),  // Use ScreenUtil for padding
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Color(0xFFFAF5FF),
                              border: Border.all(color: Color(0xFFF3E8FC))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 28.h,
                                width: 28.w,
                                padding: EdgeInsets.all(6.r),  // Use ScreenUtil for padding
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: Image.asset('assets/images/DealPerformance/Activations.png'),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                '864',
                                style: TextStyle(color: Color(0xFF7E22CE), fontSize: 16.sp, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'Activations',
                                style: TextStyle(color: Color(0xFF7E22CE), fontSize: 12.sp, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 48.w, right: 48.w, top: 12.h, bottom: 12.h),  // Use ScreenUtil for padding
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Color(0xFFF0FDF4),
                              border: Border.all(color: Color(0xFFE3F5E9))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 28.h,
                                width: 28.w,
                                padding: EdgeInsets.all(6.r),  // Use ScreenUtil for padding
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: Image.asset('assets/images/DealPerformance/Redemptions.png'),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                '432',
                                style: TextStyle(color: Color(0xFF10B981), fontSize: 16.sp, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'Redemptions',
                                style: TextStyle(color: Color(0xFF10B981), fontSize: 12.sp, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 56.w, right: 56.w, top: 12.h, bottom: 12.h),  // Use ScreenUtil for padding
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Color(0xFFFFFBEB),
                              border: Border.all(color: Color(0xFFFAF1DD))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 28.h,
                                width: 28.w,
                                padding: EdgeInsets.all(6.r),  // Use ScreenUtil for padding
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: Image.asset('assets/images/DealPerformance/Time Left.png'),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                '5 days',
                                style: TextStyle(color: Color(0xFFB45309), fontSize: 16.sp, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'Time Left',
                                style: TextStyle(color: Color(0xFFB45309), fontSize: 12.sp, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),

                    Container(
                      padding: EdgeInsets.only(left: 145.w, right: 145.w, top: 12.h, bottom: 12.h),  // Use ScreenUtil for padding
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Color(0xFFEEF2FF),
                          border: Border.all(color: Color(0xFFE4E7FC))
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 28.h,
                            width: 28.w,
                            padding: EdgeInsets.all(6.r),  // Use ScreenUtil for padding
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: Image.asset('assets/images/DealPerformance/Push Sent.png'),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            '331',
                            style: TextStyle(color: Color(0xFF4338CA), fontSize: 16.sp, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Push Sent',
                            style: TextStyle(color: Color(0xFF4338CA), fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Container(
                width: 398.w,  // Use ScreenUtil for width
                height: 276.h,  // Use ScreenUtil for height
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 16)]
                ),
                padding: EdgeInsets.all(12.r),  // Use ScreenUtil for padding
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        axisNameSize: 16.sp,  // Use ScreenUtil for font size
                        sideTitles: SideTitles(showTitles: true, reservedSize: 37.25),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        axisNameWidget: Text('Performance'),
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameSize: 16.sp,  // Use ScreenUtil for font size
                        sideTitles: SideTitles(showTitles: true, interval: 1, getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('May 1');
                            case 1:
                              return Text('May 2');
                            case 2:
                              return Text('May 3');
                            case 3:
                              return Text('May 4');
                            case 4:
                              return Text('May 5');
                            case 5:
                              return Text('May 6');
                            case 6:
                              return Text('May 7');
                            default:
                              return Text('');
                          }
                        }),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 1100,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 100),
                          FlSpot(1, 150),
                          FlSpot(2, 200),
                          FlSpot(3, 250),
                          FlSpot(4, 300),
                          FlSpot(5, 900),
                          FlSpot(6, 1000),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 4,
                        belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
                      ),
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 50),
                          FlSpot(1, 75),
                          FlSpot(2, 100),
                          FlSpot(3, 125),
                          FlSpot(4, 150),
                          FlSpot(5, 175),
                          FlSpot(6, 200),
                        ],
                        isCurved: true,
                        color: Colors.green,
                        barWidth: 4,
                        belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.3)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 170.h,  // Use ScreenUtil for height
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),  // Use ScreenUtil for padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                onPressed: () {},
                text: "Edit Deal",
                colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                borderRadius: 12.r,  // Use ScreenUtil for border radius
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/DealPerformance/Edit.png'),
                    SizedBox(width: 10.w),
                    Text(
                      "Edit Deal",
                      style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    )
                  ],
                ),
              ),
              GradientButton(
                onPressed: () {},
                text: "Send Push Notification",
                colors: [Color(0xFFD62828), Color(0xFFC21414)],
                borderRadius: 12.r,  // Use ScreenUtil for border radius
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/DealPerformance/Send.png'),
                    SizedBox(width: 10.w),
                    Text(
                      "Send Push Notification",
                      style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
