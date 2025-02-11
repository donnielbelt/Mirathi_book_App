List<Project> projectFromJson(List<Map<String, dynamic>> str) =>
    List<Project>.from(str.map((x) => Project.fromJson(x)));

List<Map<String, dynamic>> projectToJson(List<Project> data) =>
    List<Map<String, dynamic>>.from(data.map((x) => x.toJson()));

class Project {
  String? uniqueId;
  String? projectName;
  String? projectDescription;
  String? projectCode;
  String? projectManager;
  DateTime? startDate;
  DateTime? endDate;
  String? projectBudget;
  String? projectStatus;

  Project({
    this.uniqueId,
    this.projectName,
    this.projectDescription,
    this.projectCode,
    this.projectManager,
    this.startDate,
    this.endDate,
    this.projectBudget,
    this.projectStatus,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        uniqueId: json["uniqueId"],
        projectName: json["projectName"],
        projectDescription: json["projectDescription"],
        projectCode: json["projectCode"],
        projectManager: json["projectManager"],
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"])
            : null,
        endDate:
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        projectBudget: json["projectBudget"],
        projectStatus: json["projectStatus"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "projectName": projectName,
        "projectDescription": projectDescription,
        "projectCode": projectCode,
        "projectManager": projectManager,
        "startDate":
            "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
        "projectBudget": projectBudget,
        "projectStatus": projectStatus,
      };
}

class ProjectFilter {
  bool? isActive;
  int? pageNumber;
  int? pageSize;
  String? projectStatus;
  String? searchKey;
  String? zone;
  String? uniqueId;

  ProjectFilter({
    this.isActive,
    this.pageNumber,
    this.pageSize,
    this.projectStatus,
    this.searchKey,
    this.zone,
    this.uniqueId,
  });

  factory ProjectFilter.fromJson(Map<String, dynamic> json) => ProjectFilter(
        isActive: json["isActive"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        projectStatus: json["projectStatus"],
        searchKey: json["searchKey"],
        zone: json["zone"],
        uniqueId: json["uniqueId"],
      );

  Map<String, dynamic> toJson() {
    return {
      "pageNumber": pageNumber ?? 1,
      "pageSize": pageSize ?? 10,
      if (isActive != null) "isActive": isActive,
      if (projectStatus != null) "projectStatus": projectStatus,
      if (searchKey != null) "searchKey": searchKey,
      if (zone != null) "zone": zone,
      if (uniqueId != null) "uniqueId": uniqueId,
    };
  }
}

class ProjectPayload {
  toJson() {
    return {};
  }
}
