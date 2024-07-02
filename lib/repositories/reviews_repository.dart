import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/repositories/review.dart';
import 'reviews_repository.dart';

// Tạo một provider cho ReviewsRepository
final reviewsRepositoryProvider = Provider<ReviewsRepository>((ref) {
  return ReviewsRepository();
});