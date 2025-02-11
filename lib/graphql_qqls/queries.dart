import 'package:mirathi_book_app/graphql_qqls/constants.dart';

const String stringSample = """
query GetUserDependants(\$filtering: UserDependantFilterObject) {
  getUserDependants(filtering: \$filtering) {
    data {
      uniqueId
      userProfile
      firstName
      lastName
      dependantType
      dependantTypeUniqueId
      middleName
      dob
      gender
      isActive
      createdAt
    }
    $responseFields
    $pageFields
  }
}
""";

const String queryTourString = """
query GetTours(\$filtering: TourFilteringInputObject!) {
  getTours(filtering: \$filtering) {
    data {
      description
      invitationCount
      landingPhoto
      category
      remarks
      isActive
      tourUniqueId
    }
    $responseFields
    $pageFields
  }
}
""";

const String queryUserString = """
query GetUsers(\$filtering: UsersFilteringInputObject!) {
  getUsers(filtering: \$filtering) {
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
    $pageFields
  }
}
""";

const String queryUserDetailsString = """
query GetUserProfileAndRole {
  getUserProfileAndRole {
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

const String queryProjectString = """
query GetProjects(\$filtering: NhcProjectFilteringInputObject) {
  getProjects(filtering: \$filtering) {
    data {
      uniqueId
      projectName
      projectDescription
      projectCode
      projectManager
      startDate
      endDate
      projectBudget
      projectStatus
    }
    $responseFields
    $pageFields
  }
}
""";
