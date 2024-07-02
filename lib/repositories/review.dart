import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Phương thức thêm đánh giá mới vào Firestore
  Future<void> addReview(String name, double rating, String content, String userId) async {
    // Tạo ID duy nhất cho mỗi đánh giá
    final reviewId = _firestore.collection('reviews').doc().id;
    final reviewRef = _firestore.collection('reviews').doc(reviewId);
    final summaryRef = _firestore.collection('summary').doc('data');

    // Bắt đầu một transaction để đảm bảo tính nhất quán của dữ liệu
    await _firestore.runTransaction((transaction) async {
      // Thêm đánh giá mới vào collection `reviews`
      transaction.set(reviewRef, {
        'id': reviewId,
        'name': name,
        'rating': rating,
        'content': content,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Lấy dữ liệu hiện tại của tổng số sao và số lượng đánh giá từ document `summary`
      final snapshot = await transaction.get(summaryRef);

      if (!snapshot.exists) {
        // Nếu chưa có dữ liệu trong `summary`, khởi tạo mới
        transaction.set(summaryRef, {
          'totalRating': rating,
          'reviewCount': 1,
        });
      } else {
        // Nếu đã có dữ liệu, cập nhật tổng số sao và số lượng đánh giá
        final data = snapshot.data()!;
        final totalRating = data['totalRating'] as double;
        final reviewCount = data['reviewCount'] as int;

        transaction.update(summaryRef, {
          'totalRating': totalRating + rating,
          'reviewCount': reviewCount + 1,
        });
      }
    });
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';

// class ReviewsRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Phương thức thêm rating mới và tính toán rating trung bình
//   Future<void> addRatingAndComputeAverage(String name, double rating) async {
//     final summaryRef = _firestore.collection('summary').doc('data');

//     // Bắt đầu một transaction để đảm bảo tính nhất quán của dữ liệu
//     await _firestore.runTransaction((transaction) async {
//       // Lấy dữ liệu hiện tại của tổng số sao và số lượng đánh giá từ document `summary`
//       final snapshot = await transaction.get(summaryRef);

//       if (!snapshot.exists) {
//         // Nếu chưa có dữ liệu trong `summary`, khởi tạo mới
//         transaction.set(summaryRef, {
//           'totalRating': rating,
//           'ratingCount': 1,
//         });
//       } else {
//         // Nếu đã có dữ liệu, cập nhật tổng số sao và số lượng đánh giá
//         final data = snapshot.data()!;
//         final totalRating = data['totalRating'] as double;
//         final ratingCount = data['ratingCount'] as int;

//         transaction.update(summaryRef, {
//           'totalRating': totalRating + rating,
//           'ratingCount': ratingCount + 1,
//         });
//       }
//     });
//   }

//   // Phương thức tính toán rating trung bình
//   Future<double> getAverageRating() async {
//     final summaryRef = _firestore.collection('summary').doc('data');
//     final snapshot = await summaryRef.get();

//     if (snapshot.exists) {
//       final data = snapshot.data()!;
//       final totalRating = data['totalRating'] as double;
//       final ratingCount = data['ratingCount'] as int;

//       if (ratingCount > 0) {
//         return totalRating / ratingCount;
//       }
//     }

//     return 0.0; // Trường hợp không có đánh giá nào
//   }
// }
