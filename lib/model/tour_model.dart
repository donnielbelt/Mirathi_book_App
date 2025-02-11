List<Tour> tourFromJson(List<Map<String, dynamic>> str) => List<Tour>.from(str.map((x) => Tour.fromJson(x)));

List<Map<String, dynamic>> tourToJson(List<Tour> data) => List<Map<String, dynamic>>.from(data.map((x) => x.toJson()));

class Tour {
    String? description;
    int? invitationCount;
    String? landingPhoto;
    String? category;
    String? remarks;
    bool? isActive;
    String? tourUniqueId;

    Tour({
        this.description,
        this.invitationCount,
        this.landingPhoto,
        this.category,
        this.remarks,
        this.isActive,
        this.tourUniqueId,
    });

    factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        description: json["description"],
        invitationCount: json["invitationCount"],
        landingPhoto: json["landingPhoto"],
        category: json["category"],
        remarks: json["remarks"],
        isActive: json["isActive"],
        tourUniqueId: json["tourUniqueId"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "invitationCount": invitationCount,
        "landingPhoto": landingPhoto,
        "category": category,
        "remarks": remarks,
        "isActive": isActive,
        "tourUniqueId": tourUniqueId,
    };
}

class TourFilter {
    int? pageNumber;
    int? itemsPerPage;
    String? category;
    bool? isActive;
    bool? isInvited;
    bool? isRelatedTour;
    String? searchKey;
    String? status;
    String? tourUniqueId;

    TourFilter({
        this.pageNumber,
        this.itemsPerPage,
        this.category,
        this.isActive,
        this.isInvited,
        this.isRelatedTour,
        this.searchKey,
        this.status,
        this.tourUniqueId,
    });

    factory TourFilter.fromJson(Map<String, dynamic> json) => TourFilter(
        pageNumber: json["pageNumber"],
        itemsPerPage: json["itemsPerPage"],
        category: json["category"],
        isActive: json["isActive"],
        isInvited: json["isInvited"],
        isRelatedTour: json["isRelatedTour"],
        searchKey: json["searchKey"],
        status: json["status"],
        tourUniqueId: json["tourUniqueId"],
    );

    Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber ?? 1,
        "itemsPerPage": itemsPerPage ?? 20,
        if (category != null) "category": category,
        if (isActive != null) "isActive": isActive,
        if (isInvited != null) "isInvited": isInvited,
        if (isRelatedTour != null) "isRelatedTour": isRelatedTour,
        if (searchKey != null) "searchKey": searchKey,
        if (status != null) "status": status,
        if (tourUniqueId != null) "tourUniqueId": tourUniqueId,
    };
}

class TourPayload {
    String? category;
    String? description;
    String? district;
    String? landingPhoto;
    String? region;
    String? tourName;
    String? tourUniqueId;

    TourPayload({
        this.category,
        this.description,
        this.district,
        this.landingPhoto,
        this.region,
        this.tourName,
        this.tourUniqueId,
    });

    factory TourPayload.fromJson(Map<String, dynamic> json) => TourPayload(
        category: json["category"],
        description: json["description"],
        district: json["district"],
        landingPhoto: json["landingPhoto"],
        region: json["region"],
        tourName: json["tourName"],
        tourUniqueId: json["tourUniqueId"],
    );

    Map<String, dynamic> toJson() => {
        if (category != null) "category": category,
        if (description != null) "description": description,
        if (district != null) "district": district,
        if (landingPhoto != null) "landingPhoto": landingPhoto,
        if (region != null) "region": region,
        if (tourName != null) "tourName": tourName,
        if (tourUniqueId != null) "tourUniqueId": tourUniqueId,
    };
}
