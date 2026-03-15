import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../res/models/user_model.dart';
import '../../auth/service/auth_service_provider.dart';

final userProfileProvider = FutureProvider<UserModel>((ref) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) throw Exception('Not authenticated');
  return ref.read(authServiceProvider).getUserProfile(uid);
});
