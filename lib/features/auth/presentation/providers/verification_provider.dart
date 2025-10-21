import 'package:clozii/features/auth/presentation/states/verification_state.dart';
import 'package:clozii/features/auth/presentation/viewmodels/verification_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verificationProvider =
    NotifierProvider.autoDispose<VerificationViewModel, VerificationState>(
      VerificationViewModel.new,
    );
