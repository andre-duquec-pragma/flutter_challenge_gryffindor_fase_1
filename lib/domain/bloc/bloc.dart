import 'dart:async';

class Bloc<T> {
  /// The las emitted state.
  T state;

  final StreamController<T> _stream = StreamController.broadcast();

  final StreamController<T> _stateStreamController = StreamController();

  Stream<T> get stateStream => _stateStreamController.stream;

  Bloc({required T initialState}) : state = initialState {
    _stream.stream.listen(
      (newState) {
        state = newState;
        _stateStreamController.sink.add(newState);
      },
    );

    emit(initialState);
  }

  /// To emit a new state change.
  void emit(T newState) {
    _stream.sink.add(newState);
  }

  /// To close state streams.
  void close() {
    _stream.close();
    _stateStreamController.close();
  }
}
