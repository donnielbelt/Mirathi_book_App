// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/model/response_model.dart';
import 'package:mirathi_book_app/model/user_model.dart';
import 'package:mirathi_book_app/service/custom_service.dart';

class UserOperation {
  var customLTBloc;

  var customTBloc;

  UserOperation({this.customLTBloc, this.customTBloc});

  listData(
      {required String classQueryString,
      required String objectType,
      required UserFilter filter}) {
    customLTBloc.add(CustomGetDataEvent<List<User>, UserFilter, UserPayload>(
      filter: filter,
      graphqlObjectTypeString: objectType,
      queryString: classQueryString,
      fToJson: (UserFilter data) {
        return {"filtering": data.toJson()};
      },
      tFromJson: (data) {
        return userFromJson(List<Map<String, dynamic>>.from(data));
      },
      getData: ({
        required UserFilter filter,
        required Function(UserFilter f) fToJson,
        required List<User> Function(dynamic tData) tFromJson,
        required String graphqlObjectTypeString,
        required String queryString,
      }) =>
          CustomService<List<User>, UserFilter, UserPayload>().getData(
        filter: filter,
        graphqlObjectTypeString: graphqlObjectTypeString,
        queryString: queryString,
        fToJson: fToJson,
        tFromJson: tFromJson,
      ),
    ));
  }

  postData({
    context,
    required UserPayload body,
    required String classQueryString,
    required String objectType,
    required Function(String error) whenErrorAction,
    required whenLoadingAction,
    required Function(ResponseBody<User> response) whenSuccessAction,
  }) {
    customTBloc.add(CustomPostDataEvent<User, UserFilter, UserPayload>(
      whenErrorAction: (String e) {
        return whenErrorAction(e);
      },
      whenLoadingAction: () {
        return whenLoadingAction();
      },
      whenSuccessAction: (response) {
        whenSuccessAction(response);
      },
      context: context,
      payload: body,
      graphqlObjectTypeString: objectType,
      queryString: classQueryString,
      pToJson: (UserPayload data) {
        return {"input": data.toJson()};
      },
      tFromJson: (data) {
        return User.fromJson(Map<String, dynamic>.from(data));
      },
      postData: ({
        required UserPayload payload,
        required Function(UserPayload p) pToJson,
        required User Function(dynamic tData) tFromJson,
        required String graphqlObjectTypeString,
        required String queryString,
        required BuildContext context,
        required Function(String error) whenErrorAction,
        required Function() whenLoadingAction,
        required Function(ResponseBody<User> response) whenSuccessAction,
      }) =>
          CustomService<User, UserFilter, UserPayload>().postData(
        payload: payload,
        graphqlObjectTypeString: graphqlObjectTypeString,
        queryString: queryString,
        pToJson: pToJson,
        tFromJson: tFromJson,
        context: context,
        whenErrorAction: whenErrorAction,
        whenLoadingAction: whenLoadingAction,
        whenSuccessAction: whenSuccessAction,
      ),
    ));
  }

  singleData({required String classQueryString, required String objectType}) {
    customTBloc.add(CustomGetDataEvent<User, UserFilter, UserPayload>(
      filter: UserFilter(),
      graphqlObjectTypeString: objectType,
      queryString: classQueryString,
      fToJson: (UserFilter data) {
        return {
          "filtering": {}
        }; // {"filtering": data.toJson()} // HERE YOU CAN SET WHATEVER YOU LIKe
      },
      tFromJson: (data) {
        return User.fromJson(Map<String, dynamic>.from(data));
      },
      getData: ({
        required UserFilter filter,
        required Function(UserFilter f) fToJson,
        required User Function(dynamic tData) tFromJson,
        required String graphqlObjectTypeString,
        required String queryString,
      }) =>
          CustomService<User, UserFilter, UserPayload>().getData(
              graphqlObjectTypeString: graphqlObjectTypeString,
              queryString: queryString,
              tFromJson: tFromJson,
              fToJson: fToJson,
              filter: filter),
    ));
  }
}
