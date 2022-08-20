// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GalleryModel _$$_GalleryModelFromJson(Map<String, dynamic> json) =>
    _$_GalleryModel(
      imageModels: (json['imageModels'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GalleryModelToJson(_$_GalleryModel instance) =>
    <String, dynamic>{
      'imageModels': instance.imageModels,
    };
