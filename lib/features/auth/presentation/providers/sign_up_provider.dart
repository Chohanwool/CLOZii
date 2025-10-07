import 'package:clozii/features/auth/presentation/states/sign_up_state.dart';
import 'package:clozii/features/auth/presentation/viewmodels/sign_up_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpProvider = NotifierProvider<SignUpViewModel, SignUpState>(
  SignUpViewModel.new,
);
