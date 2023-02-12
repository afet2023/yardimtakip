import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yardimtakip/repository/network_repository.dart';

part 'form_entry_event.dart';
part 'form_entry_state.dart';

class FormEntryBloc extends Bloc<FormEntryEvent, FormEntryState> {
  final INetworkRepository networkRepository;
  FormEntryBloc(this.networkRepository) : super(FormEntryInitial()) {
    on<FormEntryEvent>((event, emit) {});
    
  }
}
