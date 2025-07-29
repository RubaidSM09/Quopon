import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/customTextButton.dart';
import '../controllers/vendor_deal_performance_controller.dart';

class VendorDealPerformanceView
    extends GetView<VendorDealPerformanceController> {
  const VendorDealPerformanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
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
                        fontSize: 18,
                        color: Color(0xFF020711)
                    ),
                  ),
                  SizedBox.shrink()
                ],
              ),

              SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 16)]
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/DealPerformance/Shakes.jpg'
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '50% Off Any Grande Beverage',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF020711)
                          ),
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
                    Row(
                      children: [
                        Image.asset('assets/images/DealPerformance/Valid.png'),
                        SizedBox(width: 5,),
                        Text(
                          '28 May 2025 - 10 Jun 2025',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF6F7E8D)
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 16)]
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 52, right: 52, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFEFF6FF),
                            border: Border.all(color: Color(0xFFE2ECFD))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 28,
                                width: 28,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                                ),
                                child: Image.asset('assets/images/DealPerformance/Views.png'),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                '2,547',
                                style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Total Views',
                                style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 52, right: 52, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFFAF5FF),
                              border: Border.all(color: Color(0xFFF3E8FC))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 28,
                                width: 28,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: Image.asset('assets/images/DealPerformance/Activations.png'),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                '864',
                                style: TextStyle(color: Color(0xFF7E22CE), fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Activations',
                                style: TextStyle(color: Color(0xFF7E22CE), fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 48, right: 48, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFF0FDF4),
                              border: Border.all(color: Color(0xFFE3F5E9))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 28,
                                width: 28,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: Image.asset('assets/images/DealPerformance/Redemptions.png'),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                '432',
                                style: TextStyle(color: Color(0xFF10B981), fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Redemptions',
                                style: TextStyle(color: Color(0xFF10B981), fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 56, right: 56, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFFFFBEB),
                              border: Border.all(color: Color(0xFFFAF1DD))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 28,
                                width: 28,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: Image.asset('assets/images/DealPerformance/Time Left.png'),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                '5 days',
                                style: TextStyle(color: Color(0xFFB45309), fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Time Left',
                                style: TextStyle(color: Color(0xFFB45309), fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15,),

                    Container(
                      padding: EdgeInsets.only(left: 145, right: 145, top: 12, bottom: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFEEF2FF),
                          border: Border.all(color: Color(0xFFE4E7FC))
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 28,
                            width: 28,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: Image.asset('assets/images/DealPerformance/Push Sent.png'),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            '331',
                            style: TextStyle(color: Color(0xFF4338CA), fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Push Sent',
                            style: TextStyle(color: Color(0xFF4338CA), fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),

              Container(
                width: 398,
                height: 276,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 16)]
                ),
                padding: EdgeInsets.all(12),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        axisNameSize: 16,
                        // axisNameWidget: Text('Performance'),
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
                        axisNameSize: 16,
                        // axisNameWidget: Text('Date'),
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
                        // belowBarGradient: LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   colors: [Colors.blue.withOpacity(0.3), Colors.blue.withOpacity(0)],
                        // ),
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
                        // belowBarGradient: LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   colors: [Colors.green.withOpacity(0.3), Colors.green.withOpacity(0)],
                        // ),
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
        height: 160,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                onPressed: () {

                },
                text: "Edit Deal",
                colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                borderRadius: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/DealPerformance/Edit.png'),
                    SizedBox(width: 10,),
                    Text(
                      "Edit Deal",
                      style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    )
                  ],
                ),
              ),
              GradientButton(
                onPressed: () {

                },
                text: "Send Push Notification",
                colors: [Color(0xFFD62828), Color(0xFFC21414)],
                borderRadius: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/DealPerformance/Send.png'),
                    SizedBox(width: 10,),
                    Text(
                      "Send Push Notification",
                      style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
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
