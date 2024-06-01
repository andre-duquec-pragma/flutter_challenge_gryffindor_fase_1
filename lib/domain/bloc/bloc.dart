import 'dart:async';

class Bloc<T> {
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

  void emit(T newState) {
    _stream.sink.add(newState);
  }

  void close() {
    _stream.close();
    _stateStreamController.close();
  }
}
