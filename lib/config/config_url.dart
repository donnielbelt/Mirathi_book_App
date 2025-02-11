import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mirathi_book_app/config/base_url.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../sessions/session_manager.dart';

Future<GraphQLClient> initGraphQLClient() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  final HttpLink httpLink = HttpLink('$baseUrl/graphql');
  String? token = await SessionManager().getAccessToken();

  final AuthLink authLink = AuthLink(
    getToken: () async {
      if (token == null) {
        return null;
      }
      return 'Bearer $token';
    },
  );

  final Link link = authLink.concat(httpLink);
  final GraphQLClient authorizedClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  );

  return authorizedClient;
}
