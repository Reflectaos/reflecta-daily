import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReflectionRepositoryImpl {
  final _db   = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  // ── Guardar reflexión ────────────────────────────────────
  Future<void> saveReflection(Map<String, dynamic> data) async {
    if (_uid == null) return;
    await _db
      .collection('users')
      .doc(_uid)
      .collection('reflections')
      .add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
  }

  // ── Obtener historial ────────────────────────────────────
  Stream<List<Map<String, dynamic>>> getReflections() {
    if (_uid == null) return const Stream.empty();
    return _db
      .collection('users')
      .doc(_uid)
      .collection('reflections')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => {'id': d.id, ...d.data()}).toList());
  }
}
