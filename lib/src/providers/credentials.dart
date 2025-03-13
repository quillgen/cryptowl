import 'package:cryptowl/src/providers/repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kdbx/kdbx.dart';
import 'package:logging/logging.dart';

import '../domain/user.dart';

class OnboardingNotifier extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  OnboardingNotifier(this.ref) : super(const AsyncValue.loading()) {
    check();
  }

  Future<void> check() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(appServiceProvider).isInitialized();
    });
  }

  Future<void> completeOnboarding(ProtectedValue password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(appServiceProvider).initialize(password);
      return ref.read(appServiceProvider).isInitialized();
    });
  }
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, AsyncValue<bool>>((ref) {
  return OnboardingNotifier(ref);
});

class AsyncLoginNotifier extends AsyncNotifier<Session?> {
  final logger = Logger("AsyncLoginNotifier");

  @override
  Future<Session?> build() async {
    return null;
  }

  Future<void> login(ProtectedValue password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = await ref.read(appServiceProvider).login(password);

      ref.onDispose(() {
        logger.fine("Disposing db...");
        session.sqliteDb.close();
      });
      return session;
    });
  }

  Future<void> logout() async {
    logger.fine("Logging out...");
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return null;
    });
  }
}

final asyncLoginProvider =
    AsyncNotifierProvider<AsyncLoginNotifier, Session?>(() {
  return AsyncLoginNotifier();
});
