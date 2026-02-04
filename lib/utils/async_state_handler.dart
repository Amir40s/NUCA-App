enum Status { idle, loading, success, error }

class Resource<T> {
  final Status status;
  final T? data;
  final String? message;

  const Resource._({required this.status, this.data, this.message});

  const Resource.idle() : this._(status: Status.idle);
  const Resource.loading() : this._(status: Status.loading);
  const Resource.success({required T data})
    : this._(status: Status.success, data: data);
  const Resource.error({required String message})
    : this._(status: Status.error, message: message);

  // ✅ Helper getters for UI
  bool get isIdle => status == Status.idle;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;

  String? get errorMessage => message;
  T? get result => data;
}
