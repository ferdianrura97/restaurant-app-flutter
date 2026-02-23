sealed class ResultState<T> {
  const ResultState();
}

class ResultStateLoading<T> extends ResultState<T> {
  const ResultStateLoading();
}

class ResultStateNoData<T> extends ResultState<T> {
  final String message;
  const ResultStateNoData(this.message);
}

class ResultStateHasData<T> extends ResultState<T> {
  final T data;
  const ResultStateHasData(this.data);
}

class ResultStateError<T> extends ResultState<T> {
  final String error;
  const ResultStateError(this.error);
}
