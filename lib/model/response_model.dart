class ResponseBody<T> {
  Response? response;
  Page? page;
  T? data;

  ResponseBody({
    this.response,
    this.page,
    this.data,
  });
}

class Response {
  String? id;
  bool? status;
  int? code;
  String? message;

  Response({
    this.id,
    this.status,
    this.code,
    this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "code": code,
        "message": message,
      };
}

class Page {
  int? number;
  bool? hasNextPage;
  bool? hasPreviousPage;
  int? nextPageNumber;
  int? previousPageNumber;
  int? numberOfPages;
  int? totalItems;
  List<int> pages;

  Page({
    this.number,
    this.hasNextPage,
    this.hasPreviousPage,
    this.nextPageNumber,
    this.previousPageNumber,
    this.numberOfPages,
    this.totalItems,
    required this.pages,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        number: json["number"],
        hasNextPage: json["hasNextPage"],
        hasPreviousPage: json["hasPreviousPage"],
        nextPageNumber: json["nextPageNumber"],
        previousPageNumber: json["previousPageNumber"],
        numberOfPages: json["numberOfPages"],
        totalItems: json["totalItems"],
        pages: List<int>.from(json["pages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "hasNextPage": hasNextPage,
        "hasPreviousPage": hasPreviousPage,
        "nextPageNumber": nextPageNumber,
        "previousPageNumber": previousPageNumber,
        "numberOfPages": numberOfPages,
        "totalItems": totalItems,
        "pages": List<dynamic>.from(pages.map((x) => x)),
      };
}
