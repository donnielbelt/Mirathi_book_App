import 'package:mirathi_book_app/graphql_qqls/constants.dart';

const String postUserString = """
mutation CreateUserMutation(\$input: UserProfileInputObject!) {
  createUserMutation(input: \$input) {
    data {
      profileUniqueId
      profileOrganization
      profileFirstname
      profileMiddlename
      profileLastname
      profileEmail
      profilePhone
      profileType
    }
    $responseFields
  }
}
""";
