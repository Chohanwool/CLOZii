// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostModel {

 String get id; String get title; String get content; List<String> get originImageUrls;// Firebase Storage URLs
 List<String> get thumbnailImageUrls;// Firebase Storage URLs
 int get price; String get tradeType;// enum을 string으로 저장
 String get postStatus;// enum을 string으로 저장
 String get category;// enum을 string으로 저장
 String? get detailAddress; double? get meetingPointLong; double? get meetingPointLat; DateTime get createdAt; DateTime? get updatedAt; int get favorites; int get views; String get authorUid; String get authorNickname; String? get authorProfileImageUrl;
/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostModelCopyWith<PostModel> get copyWith => _$PostModelCopyWithImpl<PostModel>(this as PostModel, _$identity);

  /// Serializes this PostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.originImageUrls, originImageUrls)&&const DeepCollectionEquality().equals(other.thumbnailImageUrls, thumbnailImageUrls)&&(identical(other.price, price) || other.price == price)&&(identical(other.tradeType, tradeType) || other.tradeType == tradeType)&&(identical(other.postStatus, postStatus) || other.postStatus == postStatus)&&(identical(other.category, category) || other.category == category)&&(identical(other.detailAddress, detailAddress) || other.detailAddress == detailAddress)&&(identical(other.meetingPointLong, meetingPointLong) || other.meetingPointLong == meetingPointLong)&&(identical(other.meetingPointLat, meetingPointLat) || other.meetingPointLat == meetingPointLat)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.favorites, favorites) || other.favorites == favorites)&&(identical(other.views, views) || other.views == views)&&(identical(other.authorUid, authorUid) || other.authorUid == authorUid)&&(identical(other.authorNickname, authorNickname) || other.authorNickname == authorNickname)&&(identical(other.authorProfileImageUrl, authorProfileImageUrl) || other.authorProfileImageUrl == authorProfileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,content,const DeepCollectionEquality().hash(originImageUrls),const DeepCollectionEquality().hash(thumbnailImageUrls),price,tradeType,postStatus,category,detailAddress,meetingPointLong,meetingPointLat,createdAt,updatedAt,favorites,views,authorUid,authorNickname,authorProfileImageUrl]);

@override
String toString() {
  return 'PostModel(id: $id, title: $title, content: $content, originImageUrls: $originImageUrls, thumbnailImageUrls: $thumbnailImageUrls, price: $price, tradeType: $tradeType, postStatus: $postStatus, category: $category, detailAddress: $detailAddress, meetingPointLong: $meetingPointLong, meetingPointLat: $meetingPointLat, createdAt: $createdAt, updatedAt: $updatedAt, favorites: $favorites, views: $views, authorUid: $authorUid, authorNickname: $authorNickname, authorProfileImageUrl: $authorProfileImageUrl)';
}


}

/// @nodoc
abstract mixin class $PostModelCopyWith<$Res>  {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) _then) = _$PostModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String content, List<String> originImageUrls, List<String> thumbnailImageUrls, int price, String tradeType, String postStatus, String category, String? detailAddress, double? meetingPointLong, double? meetingPointLat, DateTime createdAt, DateTime? updatedAt, int favorites, int views, String authorUid, String authorNickname, String? authorProfileImageUrl
});




}
/// @nodoc
class _$PostModelCopyWithImpl<$Res>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._self, this._then);

  final PostModel _self;
  final $Res Function(PostModel) _then;

/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? content = null,Object? originImageUrls = null,Object? thumbnailImageUrls = null,Object? price = null,Object? tradeType = null,Object? postStatus = null,Object? category = null,Object? detailAddress = freezed,Object? meetingPointLong = freezed,Object? meetingPointLat = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? favorites = null,Object? views = null,Object? authorUid = null,Object? authorNickname = null,Object? authorProfileImageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,originImageUrls: null == originImageUrls ? _self.originImageUrls : originImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnailImageUrls: null == thumbnailImageUrls ? _self.thumbnailImageUrls : thumbnailImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,tradeType: null == tradeType ? _self.tradeType : tradeType // ignore: cast_nullable_to_non_nullable
as String,postStatus: null == postStatus ? _self.postStatus : postStatus // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,detailAddress: freezed == detailAddress ? _self.detailAddress : detailAddress // ignore: cast_nullable_to_non_nullable
as String?,meetingPointLong: freezed == meetingPointLong ? _self.meetingPointLong : meetingPointLong // ignore: cast_nullable_to_non_nullable
as double?,meetingPointLat: freezed == meetingPointLat ? _self.meetingPointLat : meetingPointLat // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,authorUid: null == authorUid ? _self.authorUid : authorUid // ignore: cast_nullable_to_non_nullable
as String,authorNickname: null == authorNickname ? _self.authorNickname : authorNickname // ignore: cast_nullable_to_non_nullable
as String,authorProfileImageUrl: freezed == authorProfileImageUrl ? _self.authorProfileImageUrl : authorProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostModel].
extension PostModelPatterns on PostModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostModel value)  $default,){
final _that = this;
switch (_that) {
case _PostModel():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String content,  List<String> originImageUrls,  List<String> thumbnailImageUrls,  int price,  String tradeType,  String postStatus,  String category,  String? detailAddress,  double? meetingPointLong,  double? meetingPointLat,  DateTime createdAt,  DateTime? updatedAt,  int favorites,  int views,  String authorUid,  String authorNickname,  String? authorProfileImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostModel() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.originImageUrls,_that.thumbnailImageUrls,_that.price,_that.tradeType,_that.postStatus,_that.category,_that.detailAddress,_that.meetingPointLong,_that.meetingPointLat,_that.createdAt,_that.updatedAt,_that.favorites,_that.views,_that.authorUid,_that.authorNickname,_that.authorProfileImageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String content,  List<String> originImageUrls,  List<String> thumbnailImageUrls,  int price,  String tradeType,  String postStatus,  String category,  String? detailAddress,  double? meetingPointLong,  double? meetingPointLat,  DateTime createdAt,  DateTime? updatedAt,  int favorites,  int views,  String authorUid,  String authorNickname,  String? authorProfileImageUrl)  $default,) {final _that = this;
switch (_that) {
case _PostModel():
return $default(_that.id,_that.title,_that.content,_that.originImageUrls,_that.thumbnailImageUrls,_that.price,_that.tradeType,_that.postStatus,_that.category,_that.detailAddress,_that.meetingPointLong,_that.meetingPointLat,_that.createdAt,_that.updatedAt,_that.favorites,_that.views,_that.authorUid,_that.authorNickname,_that.authorProfileImageUrl);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String content,  List<String> originImageUrls,  List<String> thumbnailImageUrls,  int price,  String tradeType,  String postStatus,  String category,  String? detailAddress,  double? meetingPointLong,  double? meetingPointLat,  DateTime createdAt,  DateTime? updatedAt,  int favorites,  int views,  String authorUid,  String authorNickname,  String? authorProfileImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _PostModel() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.originImageUrls,_that.thumbnailImageUrls,_that.price,_that.tradeType,_that.postStatus,_that.category,_that.detailAddress,_that.meetingPointLong,_that.meetingPointLat,_that.createdAt,_that.updatedAt,_that.favorites,_that.views,_that.authorUid,_that.authorNickname,_that.authorProfileImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostModel extends PostModel {
   _PostModel({required this.id, required this.title, required this.content, required final  List<String> originImageUrls, required final  List<String> thumbnailImageUrls, required this.price, required this.tradeType, required this.postStatus, required this.category, this.detailAddress, this.meetingPointLong, this.meetingPointLat, required this.createdAt, this.updatedAt, this.favorites = 0, this.views = 0, required this.authorUid, required this.authorNickname, this.authorProfileImageUrl}): _originImageUrls = originImageUrls,_thumbnailImageUrls = thumbnailImageUrls,super._();
  factory _PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String content;
 final  List<String> _originImageUrls;
@override List<String> get originImageUrls {
  if (_originImageUrls is EqualUnmodifiableListView) return _originImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_originImageUrls);
}

// Firebase Storage URLs
 final  List<String> _thumbnailImageUrls;
// Firebase Storage URLs
@override List<String> get thumbnailImageUrls {
  if (_thumbnailImageUrls is EqualUnmodifiableListView) return _thumbnailImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_thumbnailImageUrls);
}

// Firebase Storage URLs
@override final  int price;
@override final  String tradeType;
// enum을 string으로 저장
@override final  String postStatus;
// enum을 string으로 저장
@override final  String category;
// enum을 string으로 저장
@override final  String? detailAddress;
@override final  double? meetingPointLong;
@override final  double? meetingPointLat;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override@JsonKey() final  int favorites;
@override@JsonKey() final  int views;
@override final  String authorUid;
@override final  String authorNickname;
@override final  String? authorProfileImageUrl;

/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostModelCopyWith<_PostModel> get copyWith => __$PostModelCopyWithImpl<_PostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._originImageUrls, _originImageUrls)&&const DeepCollectionEquality().equals(other._thumbnailImageUrls, _thumbnailImageUrls)&&(identical(other.price, price) || other.price == price)&&(identical(other.tradeType, tradeType) || other.tradeType == tradeType)&&(identical(other.postStatus, postStatus) || other.postStatus == postStatus)&&(identical(other.category, category) || other.category == category)&&(identical(other.detailAddress, detailAddress) || other.detailAddress == detailAddress)&&(identical(other.meetingPointLong, meetingPointLong) || other.meetingPointLong == meetingPointLong)&&(identical(other.meetingPointLat, meetingPointLat) || other.meetingPointLat == meetingPointLat)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.favorites, favorites) || other.favorites == favorites)&&(identical(other.views, views) || other.views == views)&&(identical(other.authorUid, authorUid) || other.authorUid == authorUid)&&(identical(other.authorNickname, authorNickname) || other.authorNickname == authorNickname)&&(identical(other.authorProfileImageUrl, authorProfileImageUrl) || other.authorProfileImageUrl == authorProfileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,content,const DeepCollectionEquality().hash(_originImageUrls),const DeepCollectionEquality().hash(_thumbnailImageUrls),price,tradeType,postStatus,category,detailAddress,meetingPointLong,meetingPointLat,createdAt,updatedAt,favorites,views,authorUid,authorNickname,authorProfileImageUrl]);

@override
String toString() {
  return 'PostModel(id: $id, title: $title, content: $content, originImageUrls: $originImageUrls, thumbnailImageUrls: $thumbnailImageUrls, price: $price, tradeType: $tradeType, postStatus: $postStatus, category: $category, detailAddress: $detailAddress, meetingPointLong: $meetingPointLong, meetingPointLat: $meetingPointLat, createdAt: $createdAt, updatedAt: $updatedAt, favorites: $favorites, views: $views, authorUid: $authorUid, authorNickname: $authorNickname, authorProfileImageUrl: $authorProfileImageUrl)';
}


}

/// @nodoc
abstract mixin class _$PostModelCopyWith<$Res> implements $PostModelCopyWith<$Res> {
  factory _$PostModelCopyWith(_PostModel value, $Res Function(_PostModel) _then) = __$PostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String content, List<String> originImageUrls, List<String> thumbnailImageUrls, int price, String tradeType, String postStatus, String category, String? detailAddress, double? meetingPointLong, double? meetingPointLat, DateTime createdAt, DateTime? updatedAt, int favorites, int views, String authorUid, String authorNickname, String? authorProfileImageUrl
});




}
/// @nodoc
class __$PostModelCopyWithImpl<$Res>
    implements _$PostModelCopyWith<$Res> {
  __$PostModelCopyWithImpl(this._self, this._then);

  final _PostModel _self;
  final $Res Function(_PostModel) _then;

/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? content = null,Object? originImageUrls = null,Object? thumbnailImageUrls = null,Object? price = null,Object? tradeType = null,Object? postStatus = null,Object? category = null,Object? detailAddress = freezed,Object? meetingPointLong = freezed,Object? meetingPointLat = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? favorites = null,Object? views = null,Object? authorUid = null,Object? authorNickname = null,Object? authorProfileImageUrl = freezed,}) {
  return _then(_PostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,originImageUrls: null == originImageUrls ? _self._originImageUrls : originImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnailImageUrls: null == thumbnailImageUrls ? _self._thumbnailImageUrls : thumbnailImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,tradeType: null == tradeType ? _self.tradeType : tradeType // ignore: cast_nullable_to_non_nullable
as String,postStatus: null == postStatus ? _self.postStatus : postStatus // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,detailAddress: freezed == detailAddress ? _self.detailAddress : detailAddress // ignore: cast_nullable_to_non_nullable
as String?,meetingPointLong: freezed == meetingPointLong ? _self.meetingPointLong : meetingPointLong // ignore: cast_nullable_to_non_nullable
as double?,meetingPointLat: freezed == meetingPointLat ? _self.meetingPointLat : meetingPointLat // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,authorUid: null == authorUid ? _self.authorUid : authorUid // ignore: cast_nullable_to_non_nullable
as String,authorNickname: null == authorNickname ? _self.authorNickname : authorNickname // ignore: cast_nullable_to_non_nullable
as String,authorProfileImageUrl: freezed == authorProfileImageUrl ? _self.authorProfileImageUrl : authorProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
