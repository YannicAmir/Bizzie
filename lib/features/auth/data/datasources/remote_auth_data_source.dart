import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final _logger = BizzieLogger('RemoteAuthDataSource');

abstract class RemoteAuthDataSource {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<User> signInWithEmail({
    required String email,
    required String password,
  });
  Future<User> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<User> signInWithGoogle();
  Future<User> signInWithApple();
  Future<void> signOut();
  Future<void> resetPassword({required String email});
  Future<void> deleteAccount();
}

@LazySingleton(as: RemoteAuthDataSource)
class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  RemoteAuthDataSourceImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _logger.info('Attempting sign in with email: $email');
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.info('Sign in success for uid: ${credential.user?.uid}');
      return credential.user!;
    } catch (e, s) {
      _logger.severe('Sign in failed for email: $email', e, s);
      rethrow;
    }
  }

  @override
  Future<User> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    _logger.info('Attempting sign up with email: $email');
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.info('Sign up success for uid: ${credential.user?.uid}');
      return credential.user!;
    } catch (e, s) {
      _logger.severe('Sign up failed for email: $email', e, s);
      rethrow;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    _logger.info('Starting Google Sign-In flow');
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      _logger.info('Google User authenticated: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final GoogleSignInClientAuthorization? authorization = await googleUser
          .authorizationClient
          .authorizationForScopes([]);

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      _logger.info(
        'Google Sign-In success for uid: ${userCredential.user?.uid}',
      );
      return userCredential.user!;
    } catch (e, s) {
      _logger.severe('Google Sign-In failed', e, s);
      rethrow;
    }
  }

  @override
  Future<User> signInWithApple() async {
    _logger.info('Starting Apple Sign-In flow');
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthProvider provider = OAuthProvider('apple.com');
      final AuthCredential credential = provider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      _logger.info(
        'Apple Sign-In success for uid: ${userCredential.user?.uid}',
      );
      return userCredential.user!;
    } on PlatformException catch (e, s) {
      _logger.severe(
        'Apple Sign-In Platform Error: Code=${e.code}, Message=${e.message}, Details=${e.details}',
        e,
        s,
      );
      rethrow;
    } catch (e, s) {
      _logger.severe('Apple Sign-In Generic Error', e, s);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    final uid = _firebaseAuth.currentUser?.uid;
    _logger.info('Attempting sign out for user: $uid');
    try {
      try {
        await _googleSignIn.signOut();
      } catch (_) {
        // Ignore if google sign in fails to sign out
        // (e.g. user not did not sign in with google)
      }
      await _firebaseAuth.signOut();
      _logger.info('Sign out successful for uid: $uid');
    } catch (e, s) {
      _logger.severe('Sign out failed for uid: $uid', e, s);
      rethrow;
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    _logger.info('Attempting to send password reset email to: $email');
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      _logger.info('Password reset email sent successfully to: $email');
    } catch (e, s) {
      _logger.severe('Failed to send password reset email to: $email', e, s);
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    final uid = _firebaseAuth.currentUser?.uid;
    _logger.info('Attempting to delete account for uid: $uid');
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.delete();
        _logger.info('Account deleted successfully for uid: $uid');
      } else {
        throw Exception('No user signed in to delete.');
      }
    } catch (e, s) {
      _logger.severe('Failed to delete account for uid: $uid', e, s);
      rethrow;
    }
  }
}
