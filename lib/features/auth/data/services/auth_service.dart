import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  // ── Google (popup para web) ──────────────────────────────
  Future<UserCredential?> signInWithGoogle() async {
    final provider = GoogleAuthProvider();
    provider.addScope('email');
    return await _auth.signInWithPopup(provider);
  }

  // ── Email / Password ─────────────────────────────────────
  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email, password: password);
  }

  Future<UserCredential> registerWithEmail(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email, password: password);
  }

  Future<void> signOut() async => await _auth.signOut();
}
