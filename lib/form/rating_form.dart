import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Widgets/notify.dart';
import 'package:travel_app/Widgets/small_text.dart';
import 'package:travel_app/repositories/favorite_provider.dart';
import 'package:travel_app/repositories/reviews_repository.dart';

class RatingForm extends ConsumerWidget {

  final String name;
  final String userId;
  RatingForm({super.key, required this.name, required this.userId});

  final ratingProvider = StateProvider<double>((ref) => 0.0);
  final reviewTextProvider = StateProvider<String>((ref) => '');
  final reviewSubmittedProvider = StateProvider<bool>((ref) => false);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final rating = ref.watch(ratingProvider);
    final reviewText = ref.watch(reviewTextProvider);
    final reviewSubmitted = ref.watch(reviewSubmittedProvider);

    String tempReviewText = '';

    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingStars(
              value: rating,
              onValueChanged: (value){
                ref.read(ratingProvider.notifier).update((state) => value);
              },
              starCount: 5,
              starSize: 40,
              starColor: Colors.amber,
              starOffColor: Colors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value){
                tempReviewText = value;
              },
              maxLines: 10,
              decoration: InputDecoration(
                label: SmallText(
                  text: 'Write your review',
                  color: Colors.black,
                  size: 20,
                ),
                border: OutlineInputBorder()
              ),
            ),
            ElevatedButton(
              onPressed: reviewSubmitted ? null : () async{
                final ratingValue = ref.read(ratingProvider);
                final reviewContent = ref.read(reviewTextProvider);
        
                if(ratingValue > 0 && reviewContent.isNotEmpty){
                  ref.read(reviewTextProvider.notifier).update((value) => tempReviewText);
                  await ref.read(reviewsRepositoryProvider).addReview(name, ratingValue, reviewContent, userId);
                  tempReviewText = '';
                  ref.read(reviewSubmittedProvider.notifier).update((state) => true);
                  showToast(message: 'Review submitted successful');
                } else{
                  showToast(message: 'Please provide a rating and a review');
                }
              }, 
              child: SmallText(
                text: 'Submit Review',
                size: 20,
                color: Colors.black,
              )
            )
          ],
        );
      }
    );
  }
  Future<bool> checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 1));
    return userId.isNotEmpty;
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_stars/flutter_rating_stars.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:travel_app/Widgets/notify.dart';
// import 'package:travel_app/Widgets/small_text.dart';
// import 'package:travel_app/repositories/reviews_repository.dart';

// final ratingProvider = StateProvider<double>((ref) => 0.0);
// final reviewSubmittedProvider = StateProvider<bool>((ref) => false);
//     // Tạo TextEditingController ngoài build method để tránh việc reset lại khi rebuild
// final reviewTextController = TextEditingController();

// class RatingForm extends ConsumerWidget {
//   final String name;
//   final String userId;

//   RatingForm({Key? key, required this.name, required this.userId}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     if (userId == null) {
//       return Center(
//         child: Text('Bạn cần đăng nhập để viết đánh giá'),
//       );
//     }



//     // Lấy giá trị của rating và trạng thái gửi đánh giá
//     final rating = ref.watch(ratingProvider);
//     final reviewSubmitted = ref.watch(reviewSubmittedProvider);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RatingStars(
//           value: rating,
//           onValueChanged: (value) {
//             // Cập nhật giá trị của ratingProvider
//             ref.read(ratingProvider.notifier).state = value;
//           },
//           starCount: 5,
//           starSize: 40,
//           starColor: Colors.amber,
//           starOffColor: Colors.grey,
//         ),
//         const SizedBox(height: 20),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: reviewSubmitted ? null : () async {
//             final ratingValue = ref.read(ratingProvider);
//             if (ratingValue > 0 ) {
//               try {
//                 ref.read(reviewSubmittedProvider.notifier).state = true;
//                 showToast(message: 'Đánh giá đã được gửi thành công');
//               } catch (e) {
//                 showToast(message: 'Có lỗi xảy ra khi gửi đánh giá: $e');
//               }
//             } else {
//               showToast(message: 'Vui lòng cung cấp đánh giá và nhận xét');
//             }
//           },
//           child: SmallText(
//             text: 'Gửi đánh giá',
//             size: 20,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }
// }


