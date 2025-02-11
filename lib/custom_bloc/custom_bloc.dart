import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mirathi_book_app/model/response_model.dart';

part 'custom_event.dart';
part 'custom_state.dart';

class CustomBloc<T, F, P>
    extends Bloc<CustomEvent<T, F, P>, CustomState<T, F, P>> {
  CustomBloc() : super(CustomInitial<T, F, P>()) {
    // For Get Purpose
    on<CustomGetDataEvent<T, F, P>>((event, emit) async {
      try {
        emit(LoadingState<T, F, P>());
        ResponseBody<T>? responseBody = await event.getData(
            fToJson: event.fToJson,
            filter: event.filter,
            graphqlObjectTypeString: event.graphqlObjectTypeString,
            queryString: event.queryString,
            tFromJson: event.tFromJson);
        if (responseBody!.response!.id == "1") {
          emit(SuccessState(responseBody: responseBody, filter: event.filter));
        } else {
          emit(ErrorState(errorMessage: responseBody.response!.message!));
        }
      } catch (e) {
        emit(ErrorState<T, F, P>(errorMessage: e.toString()));
      }
    });

    // For Post Purpose
    on<CustomPostDataEvent<T, F, P>>((event, emit) async {
      try {
        emit(LoadingState<T, F, P>());
        ResponseBody<T>? responseBody = await event.postData(
          context: event.context,
          payload: event.payload,
          graphqlObjectTypeString: event.graphqlObjectTypeString,
          queryString: event.queryString,
          pToJson: event.pToJson,
          tFromJson: event.tFromJson,
          whenErrorAction: event.whenErrorAction,
          whenLoadingAction: event.whenLoadingAction,
          whenSuccessAction: event.whenSuccessAction,
        );
        if (responseBody!.response!.id == "1") {
          emit(SuccessState(responseBody: responseBody));
        } else {
          emit(ErrorState(errorMessage: responseBody.response!.message!));
        }
      } catch (e) {
        emit(ErrorState<T, F, P>(errorMessage: e.toString()));
      }
    });
  }
}
