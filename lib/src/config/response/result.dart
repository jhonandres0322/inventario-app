sealed class Result<T> {
  const Result();
  R when<R>({required R Function(T) ok, required R Function(String) err}) {
    final self = this;
    if (self is Ok<T>) return ok(self.value);
    if (self is Error<T>) return err(self.message);
    throw StateError('Invalid Result state');
  }
}

class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

class Error<T> extends Result<T> {
  final String message;
  const Error(this.message);
}
