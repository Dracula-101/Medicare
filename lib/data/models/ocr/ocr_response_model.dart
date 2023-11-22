// ignore_for_file: prefer_null_aware_operators

class OCRResponse {
  OCRDocument? document;
  HumanReviewStatus? humanReviewStatus;

  OCRResponse({
    this.document,
    this.humanReviewStatus,
  });

  factory OCRResponse.fromJson(Map<String, dynamic> json) => OCRResponse(
        document: json["document"] == null
            ? null
            : OCRDocument.fromJson(json["document"]),
        humanReviewStatus: json["humanReviewStatus"] == null
            ? null
            : HumanReviewStatus.fromJson(json["humanReviewStatus"]),
      );
}

class OCRDocument {
  String? uri;
  String? mimeType;
  String? text;
  List<OCRPage>? pages;
  List<Entity>? entities;

  OCRDocument({
    this.uri,
    this.mimeType,
    this.text,
    this.pages,
    this.entities,
  });

  factory OCRDocument.fromJson(Map<String, dynamic> json) => OCRDocument(
        uri: json["uri"],
        mimeType: json["mimeType"],
        text: json["text"],
        pages: json["pages"] == null
            ? null
            : List<OCRPage>.from(json["pages"].map((x) => OCRPage.fromJson(x))),
        entities: json["entities"] == null
            ? null
            : List<Entity>.from(
                json["entities"].map((x) => Entity.fromJson(x))),
      );
}

class Entity {
  String? type;
  double? confidence;
  PageAnchor? pageAnchor;
  List<Property>? properties;

  Entity({
    this.type,
    this.confidence,
    this.pageAnchor,
    this.properties,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        type: json["type"],
        confidence:
            json["confidence"] == null ? null : json["confidence"].toDouble(),
        pageAnchor: json["pageAnchor"] == null
            ? null
            : PageAnchor.fromJson(json["pageAnchor"]),
        properties: json["properties"] == null
            ? null
            : List<Property>.from(
                json["properties"].map((x) => Property.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "confidence": confidence == null ? null : confidence,
        "pageAnchor": pageAnchor == null ? null : pageAnchor!.toJson(),
        "properties": properties == null
            ? null
            : List<dynamic>.from(properties!.map((x) => x.toJson())),
      };
}

class PageAnchor {
  List<PageRef>? pageRefs;

  PageAnchor({
    this.pageRefs,
  });

  factory PageAnchor.fromJson(Map<String, dynamic> json) => PageAnchor(
        pageRefs: json["pageRefs"] == null
            ? null
            : List<PageRef>.from(
                json["pageRefs"].map((x) => PageRef.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pageRefs": pageRefs == null
            ? null
            : List<dynamic>.from(pageRefs!.map((x) => x.toJson())),
      };
}

class PageRef {
  PageRef();

  factory PageRef.fromJson(Map<String, dynamic> json) => PageRef();

  Map<String, dynamic> toJson() => {};
}

class Property {
  String? type;
  double? confidence;

  Property({
    this.type,
    this.confidence,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        type: json["type"],
        confidence: json["confidence"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "confidence": confidence,
      };
}

class OCRPage {
  int? pageNumber;
  Dimension? dimension;
  PageLayout? layout;
  List<DetectedLanguage>? detectedLanguages;
  List<Block>? blocks;
  List<Block>? paragraphs;
  List<Line>? lines;
  List<Token>? tokens;
  OCRImage? image;
  ImageQualityScores? imageQualityScores;

  OCRPage({
    this.pageNumber,
    this.dimension,
    this.layout,
    this.detectedLanguages,
    this.blocks,
    this.paragraphs,
    this.lines,
    this.tokens,
    this.image,
    this.imageQualityScores,
  });

  factory OCRPage.fromJson(Map<String, dynamic> json) => OCRPage(
        pageNumber: json["pageNumber"],
        dimension: json["dimension"] == null
            ? null
            : Dimension.fromJson(json["dimension"]),
        layout:
            json["layout"] == null ? null : PageLayout.fromJson(json["layout"]),
        detectedLanguages: json["detectedLanguages"] == null
            ? null
            : List<DetectedLanguage>.from(json["detectedLanguages"]
                .map((x) => DetectedLanguage.fromJson(x))),
        blocks: json["blocks"] == null
            ? null
            : List<Block>.from(json["blocks"].map((x) => Block.fromJson(x))),
        paragraphs: json["paragraphs"] == null
            ? null
            : List<Block>.from(
                json["paragraphs"].map((x) => Block.fromJson(x))),
        lines: json["lines"] == null
            ? null
            : List<Line>.from(json["lines"].map((x) => Line.fromJson(x))),
        tokens: json["tokens"] == null
            ? null
            : List<Token>.from(json["tokens"].map((x) => Token.fromJson(x))),
        image: json["image"] == null ? null : OCRImage.fromJson(json["image"]),
        imageQualityScores: json["imageQualityScores"] == null
            ? null
            : ImageQualityScores.fromJson(json["imageQualityScores"]),
      );
}

class Block {
  BlockLayout? layout;

  Block({
    this.layout,
  });

  factory Block.fromJson(Map<String, dynamic> json) => Block(
        layout: json["layout"] == null
            ? null
            : BlockLayout.fromJson(json["layout"]),
      );

  Map<String, dynamic> toJson() => {
        "layout": layout == null ? null : layout!.toJson(),
      };
}

class BlockLayout {
  TextAnchor? textAnchor;
  double? confidence;
  BoundingPoly? boundingPoly;
  Orientation? orientation;

  BlockLayout({
    this.textAnchor,
    this.confidence,
    this.boundingPoly,
    this.orientation,
  });

  factory BlockLayout.fromJson(Map<String, dynamic> json) => BlockLayout(
        textAnchor: json["textAnchor"] == null
            ? null
            : TextAnchor.fromJson(json["textAnchor"]),
        confidence:
            json["confidence"] == null ? null : json["confidence"].toDouble(),
        boundingPoly: json["boundingPoly"] == null
            ? null
            : BoundingPoly.fromJson(json["boundingPoly"]),
        orientation: json["orientation"] == null
            ? null
            : orientationValues
                .map((key, value) => MapEntry(key, value))[json["orientation"]],
      );

  Map<String, dynamic> toJson() => {
        "textAnchor": textAnchor == null ? null : textAnchor!.toJson(),
        "confidence": confidence,
        "boundingPoly": boundingPoly == null ? null : boundingPoly!.toJson(),
        "orientation": orientation == null
            ? null
            : orientationValues
                .map((key, value) => MapEntry(key, value))[orientation],
      };
}

class BoundingPoly {
  List<Vertex>? normalizedVertices;

  BoundingPoly({
    this.normalizedVertices,
  });

  factory BoundingPoly.fromJson(Map<String, dynamic> json) => BoundingPoly(
        normalizedVertices: json["normalizedVertices"] == null
            ? null
            : List<Vertex>.from(
                json["normalizedVertices"].map((x) => Vertex.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "normalizedVertices": normalizedVertices == null
            ? null
            : List<dynamic>.from(normalizedVertices!.map((x) => x.toJson())),
      };
}

class Vertex {
  double? x;
  double? y;

  Vertex({
    this.x,
    this.y,
  });

  factory Vertex.fromJson(Map<String, dynamic> json) => Vertex(
        x: json["x"] == null ? null : json["x"].toDouble(),
        y: json["y"] == null ? null : json["y"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}

enum Orientation {
  PAGE_UP,
  PAGE_RIGHT,
  PAGE_DOWN,
  PAGE_LEFT,
  UP,
  RIGHT,
  DOWN,
  LEFT,
  UNKNOWN
}

//orientation values
final orientationValues = Map.from({
  "PAGE_UP": Orientation.PAGE_UP,
  "PAGE_RIGHT": Orientation.PAGE_RIGHT,
  "PAGE_DOWN": Orientation.PAGE_DOWN,
  "PAGE_LEFT": Orientation.PAGE_LEFT,
  "UP": Orientation.UP,
  "RIGHT": Orientation.RIGHT,
  "DOWN": Orientation.DOWN,
  "LEFT": Orientation.LEFT,
  "UNKNOWN": Orientation.UNKNOWN,
});

class TextAnchor {
  List<TextSegment>? textSegments;

  TextAnchor({
    this.textSegments,
  });

  factory TextAnchor.fromJson(Map<String, dynamic> json) => TextAnchor(
        textSegments: json["textSegments"] == null
            ? null
            : List<TextSegment>.from(
                json["textSegments"].map((x) => TextSegment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "textSegments": textSegments == null
            ? null
            : List<dynamic>.from(textSegments!.map((x) => x.toJson())),
      };
}

class TextSegment {
  String? endIndex;
  String? startIndex;

  TextSegment({
    this.endIndex,
    this.startIndex,
  });

  factory TextSegment.fromJson(Map<String, dynamic> json) => TextSegment(
        endIndex: json["endIndex"],
        startIndex: json["startIndex"],
      );

  Map<String, dynamic> toJson() => {
        "endIndex": endIndex,
        "startIndex": startIndex,
      };
}

class DetectedLanguage {
  LanguageCode? languageCode;
  double? confidence;

  DetectedLanguage({
    this.languageCode,
    this.confidence,
  });

  factory DetectedLanguage.fromJson(Map<String, dynamic> json) =>
      DetectedLanguage(
        languageCode: json["languageCode"] == null
            ? null
            : languageCodeValues.map(
                (key, value) => MapEntry(key, value))[json["languageCode"]],
        confidence:
            json["confidence"] == null ? null : json["confidence"].toDouble(),
      );
}

enum LanguageCode { EN, GD }

final languageCodeValues = Map.from({
  "en": LanguageCode.EN,
  "gd": LanguageCode.GD,
});

class Dimension {
  int? width;
  int? height;
  String? unit;

  Dimension({
    this.width,
    this.height,
    this.unit,
  });

  factory Dimension.fromJson(Map<String, dynamic> json) => Dimension(
        width: json["width"],
        height: json["height"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "unit": unit,
      };
}

class OCRImage {
  String? content;
  String? mimeType;
  int? width;
  int? height;

  OCRImage({
    this.content,
    this.mimeType,
    this.width,
    this.height,
  });

  factory OCRImage.fromJson(Map<String, dynamic> json) => OCRImage(
        content: json["content"],
        mimeType: json["mimeType"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "mimeType": mimeType,
        "width": width,
        "height": height,
      };
}

class ImageQualityScores {
  double? qualityScore;
  List<Property>? detectedDefects;

  ImageQualityScores({
    this.qualityScore,
    this.detectedDefects,
  });

  factory ImageQualityScores.fromJson(Map<String, dynamic> json) =>
      ImageQualityScores(
        qualityScore: json["qualityScore"] == null
            ? null
            : json["qualityScore"].toDouble(),
        detectedDefects: json["detectedDefects"] == null
            ? null
            : List<Property>.from(
                json["detectedDefects"].map((x) => Property.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "qualityScore": qualityScore == null ? null : qualityScore,
        "detectedDefects": detectedDefects == null
            ? null
            : List<dynamic>.from(detectedDefects!.map((x) => x.toJson())),
      };
}

class PageLayout {
  FluffyTextAnchor? textAnchor;
  double? confidence;
  FluffyBoundingPoly? boundingPoly;
  Orientation? orientation;

  PageLayout({
    this.textAnchor,
    this.confidence,
    this.boundingPoly,
    this.orientation,
  });

  factory PageLayout.fromJson(Map<String, dynamic> json) => PageLayout(
      textAnchor: json["textAnchor"] == null
          ? null
          : FluffyTextAnchor.fromJson(json["textAnchor"]),
      confidence:
          json["confidence"] == null ? null : json["confidence"].toDouble(),
      boundingPoly: json["boundingPoly"] == null
          ? null
          : FluffyBoundingPoly.fromJson(json["boundingPoly"]),
      orientation: json["orientation"] == null
          ? null
          : orientationValues
              .map((key, value) => MapEntry(key, value))[json["orientation"]]);
}

class FluffyBoundingPoly {
  List<Vertex>? vertices;
  List<Vertex>? normalizedVertices;

  FluffyBoundingPoly({
    this.vertices,
    this.normalizedVertices,
  });

  factory FluffyBoundingPoly.fromJson(Map<String, dynamic> json) =>
      FluffyBoundingPoly(
        vertices: json["vertices"] == null
            ? null
            : List<Vertex>.from(
                json["vertices"].map((x) => Vertex.fromJson(x))),
        normalizedVertices: json["normalizedVertices"] == null
            ? null
            : List<Vertex>.from(
                json["normalizedVertices"].map((x) => Vertex.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vertices": vertices == null
            ? null
            : List<dynamic>.from(vertices!.map((x) => x.toJson())),
        "normalizedVertices": normalizedVertices == null
            ? null
            : List<dynamic>.from(normalizedVertices!.map((x) => x.toJson())),
      };
}

class FluffyTextAnchor {
  List<FluffyTextSegment>? textSegments;

  FluffyTextAnchor({
    this.textSegments,
  });

  factory FluffyTextAnchor.fromJson(Map<String, dynamic> json) =>
      FluffyTextAnchor(
        textSegments: json["textSegments"] == null
            ? null
            : List<FluffyTextSegment>.from(
                json["textSegments"].map((x) => FluffyTextSegment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "textSegments": textSegments == null
            ? null
            : List<dynamic>.from(textSegments!.map((x) => x.toJson())),
      };
}

class FluffyTextSegment {
  String? endIndex;

  FluffyTextSegment({
    this.endIndex,
  });

  factory FluffyTextSegment.fromJson(Map<String, dynamic> json) =>
      FluffyTextSegment(
        endIndex: json["endIndex"],
      );

  Map<String, dynamic> toJson() => {
        "endIndex": endIndex,
      };
}

class Line {
  BlockLayout? layout;
  List<DetectedLanguage>? detectedLanguages;

  Line({
    this.layout,
    this.detectedLanguages,
  });

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        layout: json["layout"] == null
            ? null
            : BlockLayout.fromJson(json["layout"]),
        detectedLanguages: json["detectedLanguages"] == null
            ? null
            : List<DetectedLanguage>.from(json["detectedLanguages"]
                .map((x) => DetectedLanguage.fromJson(x))),
      );
}

class Token {
  BlockLayout? layout;
  DetectedBreak? detectedBreak;
  List<DetectedLanguage>? detectedLanguages;

  Token({
    this.layout,
    this.detectedBreak,
    this.detectedLanguages,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        layout: json["layout"] == null
            ? null
            : BlockLayout.fromJson(json["layout"]),
        detectedBreak: json["detectedBreak"] == null
            ? null
            : DetectedBreak.fromJson(json["detectedBreak"]),
        detectedLanguages: json["detectedLanguages"] == null
            ? null
            : List<DetectedLanguage>.from(json["detectedLanguages"]
                .map((x) => DetectedLanguage.fromJson(x))),
      );
}

class DetectedBreak {
  Type? type;

  DetectedBreak({
    this.type,
  });

  factory DetectedBreak.fromJson(Map<String, dynamic> json) => DetectedBreak(
        type: json["type"] == null
            ? null
            : typeValues
                .map((key, value) => MapEntry(key, value))[json["type"]],
      );
}

enum Type {
  HYPHEN,
  SPACE,
  WIDE_SPACE;
}

final typeValues = Map.from({
  "HYPHEN": Type.HYPHEN,
  "SPACE": Type.SPACE,
  "WIDE_SPACE": Type.WIDE_SPACE,
});

class HumanReviewStatus {
  String? state;
  String? stateMessage;

  HumanReviewStatus({
    this.state,
    this.stateMessage,
  });

  factory HumanReviewStatus.fromJson(Map<String, dynamic> json) =>
      HumanReviewStatus(
        state: json["state"],
        stateMessage: json["stateMessage"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "stateMessage": stateMessage,
      };
}
