// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromJson(jsonString);

import 'dart:convert';

PlacesResponse placesResponseFromJson(String str) => PlacesResponse.fromJson(json.decode(str));

String placesResponseToJson(PlacesResponse data) => json.encode(data.toJson());

class PlacesResponse {
    PlacesResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    String type;
    List<String> query;
    List<Feature> features;
    String attribution;

    factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
    };
}

class Feature {
    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.properties,
        required this.textEs,
        required this.placeNameEs,
        required this.text,
        required this.placeName,
        required this.center,
        required this.geometry,
        required this.context,
        this.languageEs,
        this.language,
        this.matchingText,
        this.matchingPlaceName,
    });

    String id;
    String type;
    List<String> placeType;
    Properties properties;
    String textEs;
    String placeNameEs;
    String text;
    String placeName;
    List<double> center;
    Geometry geometry;
    List<Context> context;
    String? languageEs;
    String? language;
    String? matchingText;
    String? matchingPlaceName;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
        languageEs: json["language_es"],
        language: json["language"],
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toJson(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
        "language_es": languageEs,
        "language": language,
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
    };
}

class Context {
    Context({
        required this.id,
        required this.mapboxId,
        required this.textEs,
        required this.text,
        this.wikidata,
        this.languageEs,
        this.language,
        this.shortCode,
    });

    String id;
    String mapboxId;
    String textEs;
    String text;
    String? wikidata;
    Language? languageEs;
    Language? language;
    String? shortCode;

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"],
        languageEs: languageValues.map[json["language_es"]]!,
        language: languageValues.map[json["language"]]!,
        shortCode: json["short_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mapbox_id": mapboxId,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata,
        "language_es": languageValues.reverse[languageEs],
        "language": languageValues.reverse[language],
        "short_code": shortCode,
    };
}

enum Language { ES }

final languageValues = EnumValues({
    "es": Language.ES
});

class Geometry {
    Geometry({
        required this.coordinates,
        required this.type,
    });

    List<double> coordinates;
    String type;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
    };
}

class Properties {
    Properties({
        this.foursquare,
        this.landmark,
        this.address,
        this.category,
        this.wikidata,
        this.mapboxId,
    });

    String? foursquare;
    bool? landmark;
    String? address;
    String? category;
    String? wikidata;
    String? mapboxId;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
        wikidata: json["wikidata"],
        mapboxId: json["mapbox_id"],
    );

    Map<String, dynamic> toJson() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
        "wikidata": wikidata,
        "mapbox_id": mapboxId,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
