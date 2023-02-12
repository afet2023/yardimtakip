import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  }

  Future<FutureOr<void>> loginEvent(
      AuthenticationLoginEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading));
      await _firebaseAuthRepository.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(state.copyWith(status: AuthenticationStatus.authenticated));
      add(AuthenticationInitialEvent());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          emit(state.copyWith(
              status: AuthenticationStatus.unauthenticated,
              errorMessage: 'Böyle bir kullanıcı bulunamadı.'));
          break;
        case 'wrong-password':
          emit(state.copyWith(
              status: AuthenticationStatus.unauthenticated,
              errorMessage: 'Şifre yanlış.'));
          break;
        default:
          emit(state.copyWith(
              status: AuthenticationStatus.unauthenticated,
              errorMessage: e.message));
          break;
      }
    } catch (e) {
      emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> registerEvent(AuthenticationRegisterEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
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
    }
  }

  Future<FutureOr<void>> _onInitialEvent(AuthenticationInitialEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));
    var user = _firebaseAuthRepository.getCurrentUser;
    if (user != null) {
      emit(state.copyWith(
          status: AuthenticationStatus.authenticated, user: user));
      /*  var volunteer = await _networkRepository.getVolunteerById(user.uid);
      if (volunteer != null) {
        if (volunteer.isVerified == false) {
          emit(state.copyWith(
              status: AuthenticationStatus.error,
              errorMessage: 'Hesabınız henüz onaylanmadı.'));
        } else {
          emit(
            state.copyWith(
                status: AuthenticationStatus.authenticated,
                volunteer: volunteer),
          );
    /*     } */
      } else {
        //    await _firebaseAuthRepository.signOut();
        emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          errorMessage: 'Tekrar giriş yapmayı deneyin',
        ));
      } */
    } else {
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
    }
  }
}
