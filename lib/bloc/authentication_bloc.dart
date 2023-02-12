import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:yardimtakip/model/volunteer_model.dart';
import 'package:yardimtakip/repository/network_repository.dart';

import '../repository/firebase_auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuthRepository _firebaseAuthRepository;
  final INetworkRepository _networkRepository;
  AuthenticationBloc(this._firebaseAuthRepository, this._networkRepository)
      : super(AuthenticationState()) {
    on<AuthenticationEvent>((event, emit) {});
    on<AuthenticationInitialEvent>(_onInitialEvent);
    on<AuthenticationLoginEvent>(loginEvent);
    on<AuthenticationRegisterEvent>(registerEvent);
    on<AuthenticationLogoutEvent>(_onLogoutEvent);
  }

  Future<FutureOr<void>> loginEvent(
      AuthenticationLoginEvent event, Emitter<AuthenticationState> emit) async {
    try {
      EasyLoading.show(status: 'Giriş yapılıyor...');
      emit(state.copyWith(status: AuthenticationStatus.loading));
      await _firebaseAuthRepository.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(state.copyWith(status: AuthenticationStatus.authenticated));
      EasyLoading.dismiss();
      add(AuthenticationInitialEvent());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          emit(state.copyWith(
              status: AuthenticationStatus.error,
              errorMessage: 'Böyle bir kullanıcı bulunamadı.'));
          break;
        case 'wrong-password':
          emit(state.copyWith(
              status: AuthenticationStatus.error,
              errorMessage: 'Şifre yanlış.'));
          break;
        default:
          emit(state.copyWith(
              status: AuthenticationStatus.error, errorMessage: e.message));
          break;
      }
    } catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.error, errorMessage: e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<FutureOr<void>> registerEvent(AuthenticationRegisterEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      EasyLoading.show(status: 'Kayıt olunuyor...');
      emit(state.copyWith(status: AuthenticationStatus.loading));
      var user = await _firebaseAuthRepository.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      await _networkRepository.createNewVolunteer(VolunteerModel(
          id: user?.uid ?? const Uuid().v4(),
          name: event.name,
          email: event.email,
          phone: event.phone,
          isVerified: false,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String()));
      EasyLoading.dismiss();
      emit(state.copyWith(status: AuthenticationStatus.authenticated));
      emit(state.copyWith(status: AuthenticationStatus.authenticated));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          errorMessage: e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<FutureOr<void>> _onInitialEvent(AuthenticationInitialEvent event,
      Emitter<AuthenticationState> emit) async {
    EasyLoading.show(status: 'Giriş yapılıyor...');
    emit(state.copyWith(status: AuthenticationStatus.loading));
    var user = _firebaseAuthRepository.getCurrentUser;
    if (user != null) {
      var volunteer = await _networkRepository.getVolunteerById(user.uid);
      emit(
        state.copyWith(
            status: AuthenticationStatus.authenticated,
            user: user,
            volunteer: volunteer),
      );
    } else {
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
    }
    EasyLoading.dismiss();
  }

  Future<FutureOr<void>> _onLogoutEvent(AuthenticationLogoutEvent event,
      Emitter<AuthenticationState> emit) async {
    EasyLoading.show(status: 'Çıkış yapılıyor...');
    await _firebaseAuthRepository.signOut();
    EasyLoading.dismiss();
    emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
  }
}
