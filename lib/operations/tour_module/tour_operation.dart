// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/model/response_model.dart';
import 'package:mirathi_book_app/model/tour_model.dart';
import 'package:mirathi_book_app/service/custom_service.dart';

class TourOperation {
  var customLTBloc;

  var customTBloc;

  TourOperation({this.customLTBloc, this.customTBloc});

  listData(
      {required String classQueryString,
      required String objectType,
      required TourFilter filter}) {
    customLTBloc.add(CustomGetDataEvent<List<Tour>, TourFilter, TourPayload>(
      filter: filter,
      graphqlObjectTypeString: objectType,
      queryString: classQueryString,
      fToJson: (TourFilter data) {
        return {"filtering": data.toJson()};
      },
      tFromJson: (data) {
        return tourFromJson(List<Map<String, dynamic>>.from(data));
      },
      getData: ({
        required TourFilter filter,
        required Function(TourFilter f) fToJson,
        required List<Tour> Function(dynamic tData) tFromJson,
        required String graphqlObjectTypeString,
        required String queryString,
      }) =>
          CustomService<List<Tour>, TourFilter, TourPayload>().getData(
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
    required TourPayload body,
    required String classQueryString,
    required String objectType,
    required Function(String error) whenErrorAction,
    required whenLoadingAction,
    required Function(ResponseBody<Tour> response) whenSuccessAction,
  }) {
    customTBloc.add(CustomPostDataEvent<Tour, TourFilter, TourPayload>(
      whenErrorAction: (String e) {
        return whenErrorAction(e);
      },
      whenLoadingAction: () {
        return whenLoadingAction();
      },
      whenSuccessAction: (response) {
        whenSuccessAction(ResponseBody<Tour>());
      },
      context: context,
      payload: body,
      graphqlObjectTypeString: objectType,
      queryString: classQueryString,
      pToJson: (TourPayload data) {
        return {"input": data.toJson()};
      },
      tFromJson: (data) {
        return Tour.fromJson(Map<String, dynamic>.from(data));
      },
      postData: ({
        required TourPayload payload,
        required Function(TourPayload p) pToJson,
        required Tour Function(dynamic tData) tFromJson,
        required String graphqlObjectTypeString,
        required String queryString,
        required BuildContext context,
        required Function(String error) whenErrorAction,
        required Function() whenLoadingAction,
        required Function(ResponseBody<Tour> response) whenSuccessAction,
      }) =>
          CustomService<Tour, TourFilter, TourPayload>().postData(
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
    customTBloc.add(CustomGetDataEvent<Tour, TourFilter, TourPayload>(
      filter: TourFilter(),
      fToJson: (TourFilter data) {
        return {
          "filtering": {}
        }; // {"filtering": data.toJson()} // HERE YOU CAN SET WHATEVER YOU LIKe
      },
      graphqlObjectTypeString: objectType,
      queryString: classQueryString,
      tFromJson: (data) {
        return Tour.fromJson(Map<String, dynamic>.from(data));
      },
      getData: ({
        required TourFilter filter,
        required Function(TourFilter f) fToJson,
        required Tour Function(dynamic tData) tFromJson,
        required String graphqlObjectTypeString,
        required String queryString,
      }) =>
          CustomService<Tour, TourFilter, TourPayload>().getData(
              graphqlObjectTypeString: graphqlObjectTypeString,
              queryString: queryString,
              tFromJson: tFromJson,
              fToJson: fToJson,
              filter: filter),
    ));
  }
}
