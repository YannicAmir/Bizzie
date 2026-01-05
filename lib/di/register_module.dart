import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @lazySingleton
  FirebaseRemoteConfig get remoteConfig => FirebaseRemoteConfig.instance;

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn.instance;

  @lazySingleton
  FirebaseStorage get storage => FirebaseStorage.instance;

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // We need a way to get the API key.
  // For now, assuming it's available via an environment variable or a constant.
  // Since we don't have the Envied setup visible in this context (it was mentioned in rules),
  // I will check if there is an 'AppSecrets' or similar.
  // If not found, I'll put a placeholder or throw.
  // BUT: The user rules mention "Secrets Management: envied".
  // Check lib/app/env/env.dart or similar?
}
