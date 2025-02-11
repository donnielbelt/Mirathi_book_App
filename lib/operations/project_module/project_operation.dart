// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/model/project_model.dart';
import 'package:mirathi_book_app/model/response_model.dart';
import 'package:mirathi_book_app/service/custom_service.dart';

class ProjectOperation {
  var customLTBloc;

  var customTBloc;

  ProjectOperation({this.customLTBloc, this.customTBloc});

  listData(
      {required String classQueryString,
      required String objectType,
      required ProjectFilter filter}) {
    customLTBloc
        .add(CustomGetDataEvent<List<Project>, ProjectFilter, ProjectPayload>(
      filter: filter,
      graphqlObjectTypeString: objectType,
      queryString: classQueryString,
      fToJson: (ProjectFilter data) {
        return {"filtering": data.toJson()};
      },
      tFromJson: (data) {
        return projectFromJson(List<Map<String, dynamic>>.from(data));
      },
      getData: ({
        required ProjectFilter filter,
        required Function(ProjectFilter f) fToJson,
        required List<Project> Function(dynamic tData) tFromJson,
        required String graphqlObjectTypeString,
        required String queryString,
      }) =>
          CustomService<List<Project>, ProjectFilter, ProjectPayload>().getData(
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
    required ProjectPayload body,
    required String classQueryString,
    required String objectType,
    required Function(String error) whenErrorAction,
    required whenLoadingAction,
    required Function(ResponseBody<Project> response) whenSuccessAction,
  }) {
    customTBloc.add(CustomPostDataEvent<Project, ProjectFilter, ProjectPayload>(
      whenErrorAction: whenErrorAction,
      whenLoadingAction: whenLoadingAction,
      whenSuccessAction: whenSuccessAction,
      context: context,
      payload: body,
      graphqlObjectTypeString: objectType,
      queryString: classQueryString,
      pToJson: (ProjectPayload data) {
        return {"input": data.toJson()};
      },
      tFromJson: (data) {
        return Project.fromJson(Map<String, dynamic>.from(data));
      },
      postData: ({
        required ProjectPayload payload,
        required Function(ProjectPayload p) pToJson,
        required Project Function(dynamic tData) tFromJson,
        required String graphqlObjectTypeString,
        required String queryString,
        required BuildContext context,
        required Function(String error) whenErrorAction,
        required Function() whenLoadingAction,
        required Function(ResponseBody<Project> response) whenSuccessAction,
      }) =>
          CustomService<Project, ProjectFilter, ProjectPayload>().postData(
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
    customTBloc.add(CustomGetDataEvent<Project, ProjectFilter, ProjectPayload>(
      filter: ProjectFilter(),
      graphqlObjectTypeString: objectType,
      queryString: classQueryString,
      fToJson: (ProjectFilter data) {
        return {
          "filtering": {}
        }; // {"filtering": data.toJson()} // HERE YOU CAN SET WHATEVER YOU LIKe
      },
      tFromJson: (data) {
        return Project.fromJson(Map<String, dynamic>.from(data));
      },
      getData: ({
        required ProjectFilter filter,
        required Function(ProjectFilter f) fToJson,
        required Project Function(dynamic tData) tFromJson,
        required String graphqlObjectTypeString,
        required String queryString,
      }) =>
          CustomService<Project, ProjectFilter, ProjectPayload>().getData(
              graphqlObjectTypeString: graphqlObjectTypeString,
              queryString: queryString,
              tFromJson: tFromJson,
              fToJson: fToJson,
              filter: filter),
    ));
  }
}
