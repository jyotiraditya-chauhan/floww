import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:floww/config/constants/app_collection.dart';
import 'package:floww/config/entities/onboarding_details_entity.dart';

class OnboardingException implements Exception {
  OnboardingException(this.message);

  final String message;

  @override
  String toString() => message;
}

class OnboardingService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection(AppCollection.users);

  CollectionReference<Map<String, dynamic>> get _onboardingDetailsCollection =>
      _firestore.collection(AppCollection.onboardingDetails);

  Future<void> submitOnboardingAnswers(Map<String, dynamic> answers) async {
    try {
      final uid = _auth.currentUser!.uid;
      final now = DateTime.now();

      final entity = OnboardingDetailsEntity.fromAnswers(
        uid: uid,
        answers: answers,
        startedAt: now,
        completedAt: now,
        updatedAt: now,
      );

      await _onboardingDetailsCollection.doc(uid).set(entity.toJson());
      await _usersCollection.doc(uid).update({
        'answersSubmitted': true,
        'updatedAt': now.toIso8601String(),
      });
    } catch (e, stackTrace) {
      debugPrint('submitOnboardingAnswers failed: $e\n$stackTrace');
      throw OnboardingException(
        'Could not save your answers. Please try again.',
      );
    }
  }

  Future<void> markWearablesStepDone(bool connected) async {
    try {
      final uid = _auth.currentUser!.uid;
      final now = DateTime.now();

      await _onboardingDetailsCollection.doc(uid).update({
        'targetsPermissions.wearablesConnected': connected,
        'updatedAt': now.toIso8601String(),
      });
      await _usersCollection.doc(uid).update({
        'onboardingCompleted': true,
        'updatedAt': now.toIso8601String(),
      });
    } catch (e, stackTrace) {
      debugPrint('markWearablesStepDone failed: $e\n$stackTrace');
      throw OnboardingException('Something went wrong. Please try again.');
    }
  }
}
