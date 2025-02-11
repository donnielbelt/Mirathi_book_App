List<User> userFromJson(List<Map<String, dynamic>> str) => List<User>.from(str.map((x) => User.fromJson(x)));

List<Map<String, dynamic>> userToJson(List<User> data) => List<Map<String, dynamic>>.from(data.map((x) => x.toJson()));

class User {
    String? profileUniqueId;
    String? profileOrganization;
    String? profileFirstname;
    String? profileMiddlename;
    String? profileLastname;
    String? profileEmail;
    String? profilePhone;
    String? profileType;

    User({
        this.profileUniqueId,
        this.profileOrganization,
        this.profileFirstname,
        this.profileMiddlename,
        this.profileLastname,
        this.profileEmail,
        this.profilePhone,
        this.profileType,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        profileUniqueId: json["profileUniqueId"],
        profileOrganization: json["profileOrganization"],
        profileFirstname: json["profileFirstname"],
        profileMiddlename: json["profileMiddlename"],
        profileLastname: json["profileLastname"],
        profileEmail: json["profileEmail"],
        profilePhone: json["profilePhone"],
        profileType: json["profileType"],
    );

    Map<String, dynamic> toJson() => {
        "profileUniqueId": profileUniqueId,
        "profileOrganization": profileOrganization,
        "profileFirstname": profileFirstname,
        "profileMiddlename": profileMiddlename,
        "profileLastname": profileLastname,
        "profileEmail": profileEmail,
        "profilePhone": profilePhone,
        "profileType": profileType,
    };
}


class UserFilter {
    int? itemsPerPage;
    int? pageNumber;
    String? profileUniqueId;
    String? searchKey;

    UserFilter({
        this.itemsPerPage,
        this.pageNumber,
        this.profileUniqueId,
        // this.searchKey,
    });

    factory UserFilter.fromJson(Map<String, dynamic> json) => UserFilter(
        itemsPerPage: json["itemsPerPage"],
        pageNumber: json["pageNumber"],
        profileUniqueId: json["profileUniqueId"],
        // searchKey: json["searchKey"],
    );

    Map<String, dynamic> toJson() => {
        "itemsPerPage": itemsPerPage ?? 20,
        "pageNumber": pageNumber ?? 1,
        if (profileUniqueId != null) "profileUniqueId": profileUniqueId,
        // if (searchKey != null) "searchKey": searchKey
    };
}



class UserPayload {
    String? profileEmail;
    String? profileFirstname;
    String? profileLastname;
    String? profileMiddlename;
    String? profileOrganization;
    String? profilePassword;
    String? profilePhone;
    String? profileUniqueId;

    UserPayload({
        this.profileEmail,
        this.profileFirstname,
        this.profileLastname,
        this.profileMiddlename,
        this.profileOrganization,
        this.profilePassword,
        this.profilePhone,
        this.profileUniqueId,
    });

    factory UserPayload.fromJson(Map<String, dynamic> json) => UserPayload(
        profileEmail: json["profileEmail"],
        profileFirstname: json["profileFirstname"],
        profileLastname: json["profileLastname"],
        profileMiddlename: json["profileMiddlename"],
        profileOrganization: json["profileOrganization"],
        profilePassword: json["profilePassword"],
        profilePhone: json["profilePhone"],
        profileUniqueId: json["profileUniqueId"],
    );

    Map<String, dynamic> toJson() => {
        if (profileEmail != null) "profileEmail": profileEmail,
        if (profileFirstname != null) "profileFirstname": profileFirstname,
        if (profileLastname != null) "profileLastname": profileLastname,
        if (profileMiddlename != null) "profileMiddlename": profileMiddlename,
        if (profileOrganization != null) "profileOrganization": profileOrganization,
        if (profilePassword != null) "profilePassword": profilePassword,
        if (profilePhone != null) "profilePhone": profilePhone,
        if (profileUniqueId != null) "profileUniqueId": profileUniqueId,
    };
}
