import '../../models/cat_detail.dart';
import 'cat_details_event.dart';
import 'cat_details_state.dart';
import 'package:commons/commons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CatDetailsBloc extends Bloc<CatDetailsEvent, CatDetailsState> {
  final GetFavoritesCatUseCase _getFavoritesCatUseCase;
  final DeleteFavoriteCatUseCase _deleteFavoriteCatUseCase;

  CatDetailsBloc({required Cat cat})
      : _getFavoritesCatUseCase = GetIt.I.get(),
        _deleteFavoriteCatUseCase = GetIt.I.get(),
        super(
          CatDetailsStarted(details: CatDetail(details: cat)),
        ) {
    _setUpEventListeners();

    add(LoadCatDetailsEvent(cat: cat));
  }

  void _setUpEventListeners() {
    on<LoadCatDetailsEvent>(_onLoadCatDetailsEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<ReloadCatDetailsEvent>(_onReloadEvent);
  }

  Future _onLoadCatDetailsEvent(
    LoadCatDetailsEvent event,
    Emitter<CatDetailsState> emit,
  ) async {
    try {
      final isFavorite = await _getFavoritesCatUseCase.invoke(id: event.cat.id) != null;

      final details = CatDetail(
        details: event.cat,
        isFavorite: isFavorite,
      );

      emit(CatLoadedState(details: details));
    } catch (_) {
      emit(CatDetailErrorState(
        details: CatDetail(details: event.cat),
      ));
    }
  }

  Future _onDeleteEvent(
    DeleteEvent event,
    Emitter<CatDetailsState> emit,
  ) async {
    await _deleteFavoriteCatUseCase.invoke(id: event.data.details.id);
    final newDetails = event.data.copyWith(isFavorite: false);

    final state = CatDeletedState(details: newDetails);
    emit(state);
  }

  Future _onReloadEvent(
    ReloadCatDetailsEvent event,
    Emitter<CatDetailsState> emit,
  ) async {
    final cat = await _getFavoritesCatUseCase.invoke(id: state.details.details.id);

    final newDetails = state.details.copyWith(details: cat);
    final newState = state.copyWith(details: newDetails);

    emit(newState);
  }
}
