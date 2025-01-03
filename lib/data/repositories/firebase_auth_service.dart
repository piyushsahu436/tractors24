import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final userDoc = await _firestore
          .collection('tractors24')
          .doc(userCredential.user?.uid)
          .get();

      if (!userDoc.exists) {
        throw 'User data not found';
      }

      return {
        'success': true,
        'userType': userDoc.data()?['userType'] as String?,
        'user': userCredential.user,
      };
    } on FirebaseAuthException catch (e) {
      final message = switch (e.code) {
        'user-not-found' => 'No user found for that email',
        'wrong-password' => 'Wrong password provided',
        _ => 'Authentication failed: ${e.message}',
      };
      return {'success': false, 'message': message};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}