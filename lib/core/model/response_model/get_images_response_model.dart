// To parse this JSON data, do
//
//     final getImagesResponseModel = getImagesResponseModelFromJson(jsonString);

import 'dart:convert';

GetImagesResponseModel getImagesResponseModelFromJson(String str) => GetImagesResponseModel.fromJson(json.decode(str));

String getImagesResponseModelToJson(GetImagesResponseModel data) => json.encode(data.toJson());

class GetImagesResponseModel {
  final List<Resource>? resources;
  final String? nextCursor;

  GetImagesResponseModel({
    this.resources,
    this.nextCursor,
  });

  factory GetImagesResponseModel.fromJson(Map<String, dynamic> json) => GetImagesResponseModel(
    resources: json["resources"] == null ? [] : List<Resource>.from(json["resources"]!.map((x) => Resource.fromJson(x))),
    nextCursor: json["next_cursor"],
  );

  Map<String, dynamic> toJson() => {
    "resources": resources == null ? [] : List<dynamic>.from(resources!.map((x) => x.toJson())),
    "next_cursor": nextCursor,
  };
}

class Resource {
  final String? assetId;
  final String? publicId;
  final String? format;
  final int? version;
  final String? resourceType;
  final String? type;
  final DateTime? createdAt;
  final int? bytes;
  final int? width;
  final int? height;
  final String? folder;
  final String? accessMode;
  final String? url;
  final String? secureUrl;

  Resource({
    this.assetId,
    this.publicId,
    this.format,
    this.version,
    this.resourceType,
    this.type,
    this.createdAt,
    this.bytes,
    this.width,
    this.height,
    this.folder,
    this.accessMode,
    this.url,
    this.secureUrl,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
    assetId: json["asset_id"],
    publicId: json["public_id"],
    format: json["format"],
    version: json["version"],
    resourceType: json["resource_type"],
    type: json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    bytes: json["bytes"],
    width: json["width"],
    height: json["height"],
    folder: json["folder"],
    accessMode: json["access_mode"],
    url: json["url"],
    secureUrl: json["secure_url"],
  );

  Map<String, dynamic> toJson() => {
    "asset_id": assetId,
    "public_id": publicId,
    "format": format,
    "version": version,
    "resource_type": resourceType,
    "type": type,
    "created_at": createdAt?.toIso8601String(),
    "bytes": bytes,
    "width": width,
    "height": height,
    "folder": folder,
    "access_mode": accessMode,
    "url": url,
    "secure_url": secureUrl,
  };
}
