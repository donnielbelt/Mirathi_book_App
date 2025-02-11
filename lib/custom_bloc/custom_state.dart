part of 'custom_bloc.dart';

@immutable
sealed class CustomState<T, F, P> {}

final class CustomInitial<T, F, P> extends CustomState<T, F, P> {}

final class LoadingState<T, F, P> extends CustomState<T, F, P> {}

final class SuccessState<T, F, P> extends CustomState<T, F, P> {
  final ResponseBody<T> responseBody;
  final F? filter;

  SuccessState({required this.responseBody, this.filter});
}

final class ErrorState<T, F, P> extends CustomState<T, F, P> {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
