import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/MyReviews/controllers/my_reviews_controller.dart';

class MyReviewsCardView extends GetView<MyReviewsController> {
  final String image;
  final String title;
  final String offer;
  final Review review;
  final VendorFeedback feedback;
  final int rating;

  const MyReviewsCardView({
    required this.image,
    required this.title,
    required this.offer,
    this.review = const Review(review: '', reviewer: '', time: ''),
    this.feedback = const VendorFeedback(image: '', title: '', feedback: '', time: ''),
    required this.rating,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 56,
                    width: 56,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                        ),
                      ),
                      SizedBox(
                        width: 190,
                        child: Text(
                          offer,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFD62828),
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Text(
                  'Reorder',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              )
            ],
          ),

          SizedBox(height: 5,),

          Divider(thickness: 1, color: Color(0xFFEAECED),),

          SizedBox(height: 5,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              rating >= 1 ?
              Icon(
                Icons.star_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ) :
              Icon(
                Icons.star_border_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ),

              rating >= 2 ?
              Icon(
                Icons.star_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ) :
              Icon(
                Icons.star_border_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ),
              rating >= 3 ?
              Icon(
                Icons.star_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ) :
              Icon(
                Icons.star_border_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ),

              rating >= 4 ?
              Icon(
                Icons.star_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ) :
              Icon(
                Icons.star_border_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ),

              rating == 5 ?
              Icon(
                Icons.star_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ) :
              Icon(
                Icons.star_border_rounded,
                size: 31.107,
                color: Color(0xFFFFA81C),
              ),
            ],
            ),

              Row(
                children: [
                  Image.asset(
                    'assets/images/MyReviews/Edit.png'
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'Edit Review',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFD62828)),
                  )
                ],
              )
            ],
          ),

          review.review != '' ? SizedBox(height: 10,) : SizedBox.shrink(),

          review.review != '' ?
              Text(
                review.review,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
              ) : SizedBox.shrink(),

          review.review != '' ? SizedBox(height: 10,) : SizedBox.shrink(),

          review.review != '' ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'by ${review.reviewer}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF020711)),
                  ),
                  Text(
                    '${review.time} ago',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ],
              ) : SizedBox.shrink(),

          feedback.feedback != '' ? SizedBox(height: 5,) : SizedBox.shrink(),

          feedback.feedback != '' ? Divider(thickness: 1, color: Color(0xFFEAECED),) : SizedBox.shrink(),

          feedback.feedback != '' ? SizedBox(height: 5,) : SizedBox.shrink(),

          feedback.feedback != '' ?
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(feedback.image),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 309,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              feedback.title,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF020711)),
                            ),
                            Text(
                              '${feedback.time} ago',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 309,
                        child: Text(
                          feedback.feedback,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                        ),
                      )
                    ],
                  )
                ],
              ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}
