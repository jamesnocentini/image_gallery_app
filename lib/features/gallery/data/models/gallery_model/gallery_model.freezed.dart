// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'gallery_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GalleryModel _$GalleryModelFromJson(Map<String, dynamic> json) {
  return _GalleryModel.fromJson(json);
}

/// @nodoc
mixin _$GalleryModel {
  List<ImageModel> get imageModels => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GalleryModelCopyWith<GalleryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GalleryModelCopyWith<$Res> {
  factory $GalleryModelCopyWith(
          GalleryModel value, $Res Function(GalleryModel) then) =
      _$GalleryModelCopyWithImpl<$Res>;
  $Res call({List<ImageModel> imageModels});
}

/// @nodoc
class _$GalleryModelCopyWithImpl<$Res> implements $GalleryModelCopyWith<$Res> {
  _$GalleryModelCopyWithImpl(this._value, this._then);

  final GalleryModel _value;
  // ignore: unused_field
  final $Res Function(GalleryModel) _then;

  @override
  $Res call({
    Object? imageModels = freezed,
  }) {
    return _then(_value.copyWith(
      imageModels: imageModels == freezed
          ? _value.imageModels
          : imageModels // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
    ));
  }
}

/// @nodoc
abstract class _$$_GalleryModelCopyWith<$Res>
    implements $GalleryModelCopyWith<$Res> {
  factory _$$_GalleryModelCopyWith(
          _$_GalleryModel value, $Res Function(_$_GalleryModel) then) =
      __$$_GalleryModelCopyWithImpl<$Res>;
  @override
  $Res call({List<ImageModel> imageModels});
}

/// @nodoc
class __$$_GalleryModelCopyWithImpl<$Res>
    extends _$GalleryModelCopyWithImpl<$Res>
    implements _$$_GalleryModelCopyWith<$Res> {
  __$$_GalleryModelCopyWithImpl(
      _$_GalleryModel _value, $Res Function(_$_GalleryModel) _then)
      : super(_value, (v) => _then(v as _$_GalleryModel));

  @override
  _$_GalleryModel get _value => super._value as _$_GalleryModel;

  @override
  $Res call({
    Object? imageModels = freezed,
  }) {
    return _then(_$_GalleryModel(
      imageModels: imageModels == freezed
          ? _value._imageModels
          : imageModels // ignore: cast_nullable_to_non_nullable
              as List<ImageModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GalleryModel implements _GalleryModel {
  _$_GalleryModel({required final List<ImageModel> imageModels})
      : _imageModels = imageModels;

  factory _$_GalleryModel.fromJson(Map<String, dynamic> json) =>
      _$$_GalleryModelFromJson(json);

  final List<ImageModel> _imageModels;
  @override
  List<ImageModel> get imageModels {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageModels);
  }

  @override
  String toString() {
    return 'GalleryModel(imageModels: $imageModels)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GalleryModel &&
            const DeepCollectionEquality()
                .equals(other._imageModels, _imageModels));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_imageModels));

  @JsonKey(ignore: true)
  @override
  _$$_GalleryModelCopyWith<_$_GalleryModel> get copyWith =>
      __$$_GalleryModelCopyWithImpl<_$_GalleryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GalleryModelToJson(
      this,
    );
  }
}

abstract class _GalleryModel implements GalleryModel {
  factory _GalleryModel({required final List<ImageModel> imageModels}) =
      _$_GalleryModel;

  factory _GalleryModel.fromJson(Map<String, dynamic> json) =
      _$_GalleryModel.fromJson;

  @override
  List<ImageModel> get imageModels;
  @override
  @JsonKey(ignore: true)
  _$$_GalleryModelCopyWith<_$_GalleryModel> get copyWith =>
      throw _privateConstructorUsedError;
}
