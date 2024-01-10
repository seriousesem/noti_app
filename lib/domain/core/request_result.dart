
abstract class RequestResult<T> {
  final T? data;
  final String? error;

  const RequestResult({this.data, this.error,});
}

class RequestResultSuccess<T> extends RequestResult<T> {
  const RequestResultSuccess(T data) : super(data: data);
}

class RequestResultError<T> extends RequestResult<T> {
  const RequestResultError(String error)
      : super(error: error);
}
