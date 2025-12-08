import 'dart:async';

import 'package:clozii/features/auth/core/errors/auth_failures.dart';
import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/entities/user.dart' as domain;
import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:clozii/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<AuthResult<bool>> isPhoneRegistered(String phoneNumber) {
    // TODO: implement isPhoneRegistered
    throw UnimplementedError();
  }

  @override
  Future<AuthResult<String>> sendVerificationCode(String phoneNumber) async {
    var auth = FirebaseAuth.instance;

    try {
      /// Futute를 수동으로 제어하기 위해 Completer 사용
      /// - 보통의 경우, Future는 비동기 함수가 끝나면 자동으로 완료되지만,
      ///   Completer를 통해 **언제 Future를 완료시킬지** 결정할 수 있음
      ///
      /// - completer.complete(value) => Future를 성공으로 완료시킴
      /// - completer.completeError(error) => Future를 실패로 완료시킴
      final Completer<String> completer = Completer<String>();

      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        // Android 기기의 SMS 코드 자동 처리
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          await auth.signInWithCredential(credential);
        },

        // 잘못된 전화번호나 SMS 할당량 초과 여부 등의 실패 이벤트 처리
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('=== Firebase Auth Error ===');
          debugPrint('Error Code: ${e.code}');
          debugPrint('Error Message: ${e.message}');
          debugPrint('=======================');

          if (!completer.isCompleted) {
            completer.completeError(e);
          }
        },

        // Firebase에서 기기로 코드가 전송된 경우를 처리
        codeSent: (String verificationId, int? resendToken) async {
          debugPrint('=== codeSent ===');
          debugPrint('verificationId: $verificationId');

          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },

        // 자동 SMS 코드 처리 실패 시 시간 초과
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('Code auto retrieval timeout');

          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },
      );

      final verificationId = await completer.future;
      return AuthResult.success(verificationId);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      return AuthResult.failure(
        AuthenticationFailure(
          e.message ?? 'Firebase auth error occurred',
          e.code,
        ),
      );
    } catch (e) {
      debugPrint('UnknownError: $e');
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<AuthResult<domain.User>> verifyCode(
    String verificationId,
    String otpCode,
  ) async {
    try {
      /// 인증코드 입력 값과 실제 발송된 값과 비교
      /// - 실제 값은 파이어베이스 서버 전송으로 확인 불가,
      ///   비교 결과만 확인 가능
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );

      var auth = FirebaseAuth.instance;

      // 로그인 시도
      UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        return AuthResult.failure(UnknownFailure('User is null'));
      }

      // Firebase User → Domain User 변환 (uid, phoneNumber만)
      // Phone Auth이므로 phoneNumber는 항상 존재함
      final domainUser = domain.User(
        uid: firebaseUser.uid,
        phoneNumber: firebaseUser.phoneNumber!,
        name: '', // OTP 검증 단계에서는 이름 없음
        isVerified: true,
        createdAt: DateTime.now(),
      );

      debugPrint("======= AuthRepoImpl.verifyCode =======");
      debugPrint(
        'OTP 검증 성공 - uid: ${domainUser.uid}, phone: ${domainUser.phoneNumber}',
      );
      debugPrint("======= AuthRepoImpl.verifyCode =======");

      return AuthResult.success(domainUser);
    } catch (e) {
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<AuthResult<void>> saveUserToFirestore(domain.User user) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Mapper 패턴: Domain Entity → Data Model → JSON
      final userModel = UserModel.fromEntity(user);
      await firestore.collection('users').doc(user.uid).set(userModel.toJson());

      debugPrint('====== AuthRepoImpl.saveUserToFirestore ======');
      debugPrint('사용자 정보 저장 성공: ${user.uid}');
      debugPrint('====== AuthRepoImpl.saveUserToFirestore ======');

      return AuthResult.success(null);
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException: ${e.message}');
      return AuthResult.failure(
        FirestoreSaveFailure('사용자 정보 저장 실패: ${e.message}'),
      );
    } catch (e) {
      debugPrint('UnknownError: $e');
      return AuthResult.failure(FirestoreSaveFailure('사용자 정보 저장 중 오류 발생: $e'));
    }
  }

  @override
  Future<AuthResult<domain.User>> getUserFromFirestore(String uid) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Firestore에서 사용자 정보 조회
      final docSnapshot = await firestore.collection('users').doc(uid).get();

      if (!docSnapshot.exists) {
        debugPrint('사용자 정보가 존재하지 않음: $uid');
        return AuthResult.failure(AuthenticationFailure('사용자 정보를 찾을 수 없습니다.'));
      }

      // JSON 데이터를 도메인 User 엔티티로 변환
      final userData = docSnapshot.data();
      if (userData == null) {
        return AuthResult.failure(AuthenticationFailure('사용자 데이터가 비어있습니다.'));
      }

      // Mapper 패턴: JSON → Data Model → Domain Entity
      final userModel = UserModel.fromJson(userData);
      final userEntity = userModel.toEntity();

      debugPrint('====== AuthRepoImpl.getUserFromFirestore ======');
      debugPrint('사용자 정보 조회 성공: ${userEntity.uid}');
      debugPrint('====== AuthRepoImpl.getUserFromFirestore ======');

      return AuthResult.success(userEntity);
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException: ${e.message}');
      return AuthResult.failure(
        AuthenticationFailure('사용자 정보 조회 실패: ${e.message}'),
      );
    } catch (e) {
      debugPrint('UnknownError: $e');
      return AuthResult.failure(AuthenticationFailure('사용자 정보 조회 중 오류 발생: $e'));
    }
  }

  // ✅ 추가: 현재 로그인된 유저 정보 가져오기
  @override
  Future<AuthResult<domain.User>> getCurrentUser() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        return AuthResult.failure(AuthenticationFailure('로그인되지 않음'));
      }

      debugPrint('====== AuthRepoImpl.getCurrentUser ======');
      debugPrint('현재 유저 uid: ${firebaseUser.uid}');
      debugPrint('====== AuthRepoImpl.getCurrentUser ======');

      // Firestore에서 전체 User 정보 가져오기 (기존 메서드 재사용)
      return await getUserFromFirestore(firebaseUser.uid);
    } catch (e) {
      debugPrint('UnknownError: $e');
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }

  // ✅ 추가: 현재 Firebase Auth 유저 삭제 (롤백용)
  @override
  Future<AuthResult<void>> deleteCurrentFirebaseUser() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        await firebaseUser.delete();
        debugPrint('====== Firebase Auth 사용자 삭제 완료 ======');
      }

      return AuthResult.success(null);
    } catch (e) {
      debugPrint('====== Firebase Auth 사용자 삭제 실패: $e ======');
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }
}
