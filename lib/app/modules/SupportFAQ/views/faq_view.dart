import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/common/FAQCard.dart';

class FaqView extends GetView {
  const FaqView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FAQCard(
          title: 'Lorem Ipsum is simply dummy text?',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          isPlus: true,
        ),
        SizedBox(height: 15,),
        FAQCard(
          title: 'Lorem Ipsum is simply dummy text?',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        FAQCard(
          title: 'Lorem Ipsum is simply dummy text?',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        FAQCard(
          title: 'Lorem Ipsum is simply dummy text?',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        FAQCard(
          title: 'Lorem Ipsum is simply dummy text?',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        FAQCard(
          title: 'Lorem Ipsum is simply dummy text?',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        FAQCard(
          title: 'Lorem Ipsum is simply dummy text?',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        FAQCard(
          title: 'Lorem Ipsum is simply dummy text?',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        FAQCard(
          title: 'Lorem Ipsum is simply dummy text?',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
      ],
    );
  }
}
