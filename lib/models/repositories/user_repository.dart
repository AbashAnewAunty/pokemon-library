import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(initialUser: FirebaseAuth.instance.currentUser),
);

class AuthController extends StateNotifier<User?> {
  AuthController({User? initialUser}) : super(initialUser) {
    // Userの変更を検知して状態を更新
    _auth.idTokenChanges().listen((user) {
      state = user;
    });
  }

  final _auth = FirebaseAuth.instance;

  /// アカウント作成
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    state = userCredential.user;
  }

  /// ログイン
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    state = userCredential.user;
  }

  /// ログアウト
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// アカウントを削除する
  Future<void> deleteAccount() async {
    await state?.delete();
  }

  /// 確認メール
  Future<void> verifyEmail() async {
    await FirebaseAuth.instance.setLanguageCode("ja");
    await state?.sendEmailVerification();
  }
}
