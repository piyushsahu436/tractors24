import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHomeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot> getVehiclesStream(String sellerId) {
    return _firestore.collection('tractors24').doc(sellerId).snapshots();
  }

  Future<void> addVehicle({
    required String sellerId,
    required String brandName,
    required String description,
    required String horsePower,
    required String insuranceSecurity,
    required String sellPrice,
  }) async {
    final DocumentReference sellerRef = _firestore.collection('tractors24').doc(sellerId);

    await sellerRef.set({
      'vehicles': FieldValue.arrayUnion([
        {
          'brandName': brandName,
          'description': description,
          'horsePower': horsePower,
          'insuranceSecurity': insuranceSecurity,
          'sellPrice': sellPrice,
        }
      ])
    }, SetOptions(merge: true));
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}