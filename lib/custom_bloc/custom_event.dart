part of 'custom_bloc.dart';

@immutable
sealed class CustomEvent<T, F, P> {}

class CustomGetDataEvent<T, F, P> extends CustomEvent<T, F, P> {
  final Future<ResponseBody<T>?> Function(
      {required F filter,
      required Function(F f) fToJson,
      required T Function(dynamic tData) tFromJson,
      required String queryString,
      required String graphqlObjectTypeString}) getData;
  final F filter;
  final Function(F f) fToJson;
  final T Function(dynamic tData) tFromJson;
  final String queryString;
  final String graphqlObjectTypeString;
  CustomGetDataEvent(
      {required this.getData,
      required this.filter,
      required this.fToJson,
      required this.tFromJson,
      required this.queryString,
      required this.graphqlObjectTypeString});
}

class CustomPostDataEvent<T, F, P> extends CustomEvent<T, F, P> {
  final Future<ResponseBody<T>?> Function({
    required BuildContext context,
    required P payload,
    required Function(P p) pToJson,
    required T Function(dynamic tData) tFromJson,
    required String queryString,
    required String graphqlObjectTypeString,
    required Function(String error) whenErrorAction,
    required Function(ResponseBody<T> response) whenSuccessAction,
    required Function() whenLoadingAction,
  }) postData;
  final BuildContext context;
  final P payload;
  final Function(P p) pToJson;
  final T Function(dynamic tData) tFromJson;
  final String queryString;
  final String graphqlObjectTypeString;
  final Function(String error) whenErrorAction;
  final Function(ResponseBody<T> response) whenSuccessAction;
  final Function() whenLoadingAction;
  CustomPostDataEvent({
    required this.context,
    required this.postData,
    required this.payload,
    required this.pToJson,
    required this.tFromJson,
    required this.queryString,
    required this.graphqlObjectTypeString,
    required this.whenErrorAction,
    required this.whenSuccessAction,
    required this.whenLoadingAction,
  });
}
