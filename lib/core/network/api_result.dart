abstract class ApiResult<T> {
  const ApiResult();
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

class Failure extends ApiResult<Never> {
  final String message;
  final int? statusCode;
  const Failure(this.message, {this.statusCode});
}
