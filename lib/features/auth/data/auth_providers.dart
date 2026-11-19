import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wastepickup/features/scheduler/domain/models/user_model.dart';
import 'auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (_) => AuthRepository(),
);

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges(),
);

final currentAppUserProvider = FutureProvider<AppUser?>((ref) async {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    data: (firebaseUser) async {
      if (firebaseUser == null) return null;
      return ref.read(authRepositoryProvider).getOrCreateUser(firebaseUser);
    },
    loading: () => null,
    error: (e, _) => Future.value(null),
  );
});
