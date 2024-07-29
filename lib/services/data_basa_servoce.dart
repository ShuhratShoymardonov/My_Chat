import 'package:my_chat/models/user_profil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBasaServoce {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference? _userColection;

  DataBasaServoce() {}

  void _setupCalectionReferences() {
    _userColection =
        _firebaseFirestore.collection('users').withConverter<UserProfile>(
              fromFirestore: (sinapshos, _) =>
                  UserProfile.fromJson(sinapshos.data()!),
              toFirestore: (userProfile, _) => userProfile.toJson(),
            );
  }

  Future<void> createUserProfile({required UserProfile userProfile}) async {
    await _userColection?.doc(userProfile.uid).set(userProfile);
  }
}
