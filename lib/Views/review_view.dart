import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/Widgets/small_text.dart';
import 'package:travel_app/form/review_form.dart';

class ReviewPage extends ConsumerWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => showReviewSheet(context),
          child: SmallText(
            text: 'Share your tips or review',
            color: Colors.black,
          )
        )
      ],
    );
  }
}