class Review {
  final String id;
  final String userId;
  final String content;
  final double rating;
  final DateTime timestamp;

  Review({
    required this.id,
    required this.userId,
    required this.content,
    required this.rating,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'rating': rating,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static Review fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      userId: map['userId'],
      content: map['content'],
      rating: map['rating'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
