/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
    SearchResponse({
        required this.page,
        required this.totalPages,
        required this.results,
        required this.totalResults,
    });

    int page;
    int totalPages;
    List<dynamic> results;
    int totalResults;

    factory SearchResponse.fromJson(Map<dynamic, dynamic> json) => SearchResponse(
        page: json["page"],
        totalPages: json["total_pages"],
        results: List<dynamic>.from(json["results"].map((x) => x)),
        totalResults: json["total_results"],
    );

    Map<dynamic, dynamic> toJson() => {
        "page": page,
        "total_pages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x)),
        "total_results": totalResults,
    };
}
