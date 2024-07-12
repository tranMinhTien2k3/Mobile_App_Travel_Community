import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Provider để lưu trữ mật khẩu hiện tại
final currentPasswordProvider = StateProvider<String?>((ref) => null);

// Provider để lưu trữ mật khẩu cũ
final oldPasswordProvider = StateProvider<String?>((ref) => null);

// Provider để lưu trữ mật khẩu mới
final newPasswordProvider = StateProvider<String?>((ref) => null);

// Provider để lưu trữ xác nhận mật khẩu mới
final confirmPasswordProvider = StateProvider<String?>((ref) => null);

// Provider để lưu trữ độ mạnh của mật khẩu
final passwordStrengthProvider = StateProvider<String>((ref) => "");

// Provider để lưu trữ thông báo lỗi
final errorMessageProvider = StateProvider<String?>((ref) => null);

// Provider để lưu trữ trạng thái mật khẩu cũ có đúng không
final isOldPasswordCorrectProvider = StateProvider<bool>((ref) => false);

// Provider cho Firebase Auth
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

enum PasswordStrength {
  weak,
  medium,
  strong,
}


