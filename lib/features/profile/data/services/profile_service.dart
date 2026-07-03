import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final _db   = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;
  User?   get currentUser => _auth.currentUser;

  // ── Guardar o actualizar perfil ───────────────────────
  Future<void> saveProfile(String name) async {
    if (_uid == null) return;
    await _db.collection('users').doc(_uid).set({
      'name':      name,
      'email':     _auth.currentUser?.email ?? '',
      'photoUrl':  _auth.currentUser?.photoURL ?? '',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ── Obtener perfil ────────────────────────────────────
  Future<Map<String, dynamic>?> getProfile() async {
    if (_uid == null) return null;
    final doc = await _db.collection('users').doc(_uid).get();
    return doc.exists ? doc.data() : null;
  }

  // ── Calcular racha real ───────────────────────────────
  Future<int> calculateStreak() async {
    if (_uid == null) return 0;
    final snap = await _db
      .collection('users')
      .doc(_uid)
      .collection('reflections')
      .orderBy('createdAt', descending: true)
      .get();

    if (snap.docs.isEmpty) return 0;

    final Set<String> days = {};
    for (final doc in snap.docs) {
      final ts = doc.data()['createdAt'];
      if (ts == null) continue;
      final dt = (ts as Timestamp).toDate().toLocal();
      days.add('${dt.year}-${dt.month}-${dt.day}');
    }

    int streak = 0;
    var date = DateTime.now().toLocal();
    while (true) {
      final key = '${date.year}-${date.month}-${date.day}';
      if (days.contains(key)) {
        streak++;
        date = date.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }
}
