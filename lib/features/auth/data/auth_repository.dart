import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastepickup/features/scheduler/domain/models/user_model.dart';

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}

String _friendly(String code) {
  return switch (code) {
    'email-already-in-use'      => 'That email is already registered.',
    'invalid-email'             => 'Please enter a valid email address.',
    'weak-password'             => 'Password must be at least 6 characters.',
    'wrong-password'            => 'Incorrect password. Please try again.',
    'invalid-credential'        => 'Incorrect email or password.',
    'user-not-found'            => 'No account found with that email.',
    'too-many-requests'         => 'Too many attempts. Please wait and try again.',
    'network-request-failed'    => 'No internet connection.',
    'invalid-phone-number'      => 'Enter a valid Rwandan phone number.',
    'quota-exceeded'            => 'SMS quota exceeded. Try again later.',
    'invalid-verification-code' => 'The OTP code is incorrect.',
    'session-expired'           => 'The OTP has expired. Please request a new one.',
    _                           => 'Something went wrong. Please try again.',
  };
}

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await getOrCreateUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_friendly(e.code));
    }
  }

  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await getOrCreateUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_friendly(e.code));
    }
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_friendly(e.code));
    }
  }

  Future<void> sendOtp({
    required String phoneE164,
    int? resendToken,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(AppUser user) onAutoVerified,
    required void Function(String message) onError,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneE164,
      forceResendingToken: resendToken,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          final result = await _auth.signInWithCredential(credential);
          final user = await getOrCreateUser(result.user!);
          onAutoVerified(user);
        } on FirebaseAuthException catch (e) {
          onError(_friendly(e.code));
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        onError(_friendly(e.code));
      },
      codeSent: (String verificationId, int? token) {
        onCodeSent(verificationId, token);
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  Future<AppUser> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final result = await _auth.signInWithCredential(credential);
      return await getOrCreateUser(result.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_friendly(e.code));
    }
  }

  Future<AppUser> getOrCreateUser(User firebaseUser) async {
    final ref = _db.collection('users').doc(firebaseUser.uid);
    final snap = await ref.get();

    if (snap.exists) {
      return AppUser.fromMap(snap.data()!, snap.id);
    }

    final newUser = AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email,
      phone: firebaseUser.phoneNumber,
      authMethods: firebaseUser.email != null ? ['email'] : ['phone'],
      onboardingComplete: false,
      createdAt: DateTime.now(),
    );

    await ref.set(newUser.toMap());
    return newUser;
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<void> signOut() => _auth.signOut();
}
