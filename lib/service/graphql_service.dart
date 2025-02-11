import 'package:mirathi_book_app/config/config_url.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  late final GraphQLClient _client;

  GraphQLService._(this._client);

  static Future<GraphQLService> create() async {
    final client = await initGraphQLClient();
    return GraphQLService._(client);
  }

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic>? variables}) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.networkOnly,
    );

    try {
      final result = await _client.query(options);
      if (result.hasException) {
        throw Exception('GraphQL Query Error: ${result.exception}');
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<QueryResult> performMutation(String mutation,
      {Map<String, dynamic>? variables}) async {
    final options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
    );

    try {
      final result = await _client.mutate(options);

      if (result.hasException) {
        throw Exception('GraphQL Mutation Error: ${result.exception}');
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
