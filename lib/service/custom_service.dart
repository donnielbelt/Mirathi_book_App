// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mirathi_book_app/service/graphql_service.dart';
import 'package:mirathi_book_app/model/response_model.dart' as model;

class CustomService<T, F, P> {
  // For Filtering Purpose
  Future<model.ResponseBody<T>?> getData(
      {required F filter,
      required Function(F f) fToJson,
      required T Function(dynamic tData) tFromJson,
      required String queryString,
      required String graphqlObjectTypeString}) async {
    final graphQLService = await GraphQLService.create();
    try {
      final result = await graphQLService.performMutation(queryString,
          variables: fToJson(filter));
      if (result.hasException) {
        throw Exception("Something went wrong from the server.");
      }

      if (result.data != null &&
          result.data![graphqlObjectTypeString] != null) {
        var query = result.data![graphqlObjectTypeString];
        if (query['response']['id'] == "1") {
          model.ResponseBody<T>? returnedData = model.ResponseBody<T>();
          if (query['response'] != null) {
            returnedData.response = model.Response.fromJson(query['response']);
          }
          if (query['page'] != null) {
            returnedData.page = model.Page.fromJson(query['page']);
          }
          if (query['data'] != null) {
            returnedData.data = tFromJson(query['data']);
          }
          return returnedData;
        } else {
          throw Exception(query['response']['message']);
        }
      }
      throw Exception("Something went wrong from the server.");
    } catch (e) {
      throw Exception("Failed to filter data due to $e");
    }
  }

  // For Post Purpose
  Future<model.ResponseBody<T>?> postData({
    required P payload,
    required Function(P p) pToJson,
    required T Function(dynamic tData) tFromJson,
    required String queryString,
    required String graphqlObjectTypeString,
    required BuildContext context,
    required Function(String error) whenErrorAction,
    required whenLoadingAction,
    required Function(model.ResponseBody<T> response) whenSuccessAction,
  }) async {
    try {
      whenLoadingAction();

      final graphQLService = await GraphQLService.create();
      var result;

      try {
        result = await graphQLService.performMutation(queryString,
            variables: pToJson(payload));
      } catch (e) {
        throw Exception("Something went wrong from the server1.");
      }

      if (result.hasException) {
        throw Exception("Something went wrong from the server2.");
      }

      if (result.data != null &&
          result.data![graphqlObjectTypeString] != null) {
        var query = result.data![graphqlObjectTypeString];
        if (query['response']['id'] == "1") {
          model.ResponseBody<T>? returnedData = model.ResponseBody<T>();
          if (query['response'] != null) {
            returnedData.response = model.Response.fromJson(query['response']);
          }
          if (query['page'] != null) {
            returnedData.page = model.Page.fromJson(query['page']);
          }
          if (query['data'] != null) {
            returnedData.data = tFromJson(query['data']);
          }
          whenSuccessAction(returnedData);
          return returnedData;
        } else {
          throw Exception(query['response']['message']);
        }
      }
      throw Exception("Something went wrong from the server.");
    } catch (e) {
      whenErrorAction(e.toString());
      throw Exception("Failed to filter data due to $e");
    }
  }
}
