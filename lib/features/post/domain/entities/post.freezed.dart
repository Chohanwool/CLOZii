// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Post {

 String get id; String get title; String get content; List<String> get originImageUrls; List<String> get thumbnailImageUrls; int get price; DateTime get createdAt; DateTime get updatedAt; TradeType get tradeType; String? get detailAddress; double? get meetingPointLat; double? get meetingPointLong; int get favorites; int get views;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.originImageUrls, originImageUrls)&&const DeepCollectionEquality().equals(other.thumbnailImageUrls, thumbnailImageUrls)&&(identical(other.price, price) || other.price == price)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.tradeType, tradeType) || other.tradeType == tradeType)&&(identical(other.detailAddress, detailAddress) || other.detailAddress == detailAddress)&&(identical(other.meetingPointLat, meetingPointLat) || other.meetingPointLat == meetingPointLat)&&(identical(other.meetingPointLong, meetingPointLong) || other.meetingPointLong == meetingPointLong)&&(identical(other.favorites, favorites) || other.favorites == favorites)&&(identical(other.views, views) || other.views == views));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,const DeepCollectionEquality().hash(originImageUrls),const DeepCollectionEquality().hash(thumbnailImageUrls),price,createdAt,updatedAt,tradeType,detailAddress,meetingPointLat,meetingPointLong,favorites,views);

@override
String toString() {
  return 'Post(id: $id, title: $title, content: $content, originImageUrls: $originImageUrls, thumbnailImageUrls: $thumbnailImageUrls, price: $price, createdAt: $createdAt, updatedAt: $updatedAt, tradeType: $tradeType, detailAddress: $detailAddress, meetingPointLat: $meetingPointLat, meetingPointLong: $meetingPointLong, favorites: $favorites, views: $views)';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 String id, String title, String content, List<String> originImageUrls, List<String> thumbnailImageUrls, int price, DateTime createdAt, DateTime updatedAt, TradeType tradeType, String? detailAddress, double? meetingPointLat, double? meetingPointLong, int favorites, int views
});




}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? content = null,Object? originImageUrls = null,Object? thumbnailImageUrls = null,Object? price = null,Object? createdAt = null,Object? updatedAt = null,Object? tradeType = null,Object? detailAddress = freezed,Object? meetingPointLat = freezed,Object? meetingPointLong = freezed,Object? favorites = null,Object? views = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,originImageUrls: null == originImageUrls ? _self.originImageUrls : originImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnailImageUrls: null == thumbnailImageUrls ? _self.thumbnailImageUrls : thumbnailImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,tradeType: null == tradeType ? _self.tradeType : tradeType // ignore: cast_nullable_to_non_nullable
as TradeType,detailAddress: freezed == detailAddress ? _self.detailAddress : detailAddress // ignore: cast_nullable_to_non_nullable
as String?,meetingPointLat: freezed == meetingPointLat ? _self.meetingPointLat : meetingPointLat // ignore: cast_nullable_to_non_nullable
as double?,meetingPointLong: freezed == meetingPointLong ? _self.meetingPointLong : meetingPointLong // ignore: cast_nullable_to_non_nullable
as double?,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Post value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Post value)  $default,){
final _that = this;
switch (_that) {
case _Post():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Post value)?  $default,){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String content,  List<String> originImageUrls,  List<String> thumbnailImageUrls,  int price,  DateTime createdAt,  DateTime updatedAt,  TradeType tradeType,  String? detailAddress,  double? meetingPointLat,  double? meetingPointLong,  int favorites,  int views)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.originImageUrls,_that.thumbnailImageUrls,_that.price,_that.createdAt,_that.updatedAt,_that.tradeType,_that.detailAddress,_that.meetingPointLat,_that.meetingPointLong,_that.favorites,_that.views);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String content,  List<String> originImageUrls,  List<String> thumbnailImageUrls,  int price,  DateTime createdAt,  DateTime updatedAt,  TradeType tradeType,  String? detailAddress,  double? meetingPointLat,  double? meetingPointLong,  int favorites,  int views)  $default,) {final _that = this;
switch (_that) {
case _Post():
return $default(_that.id,_that.title,_that.content,_that.originImageUrls,_that.thumbnailImageUrls,_that.price,_that.createdAt,_that.updatedAt,_that.tradeType,_that.detailAddress,_that.meetingPointLat,_that.meetingPointLong,_that.favorites,_that.views);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String content,  List<String> originImageUrls,  List<String> thumbnailImageUrls,  int price,  DateTime createdAt,  DateTime updatedAt,  TradeType tradeType,  String? detailAddress,  double? meetingPointLat,  double? meetingPointLong,  int favorites,  int views)?  $default,) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.originImageUrls,_that.thumbnailImageUrls,_that.price,_that.createdAt,_that.updatedAt,_that.tradeType,_that.detailAddress,_that.meetingPointLat,_that.meetingPointLong,_that.favorites,_that.views);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Post extends Post {
  const _Post({required this.id, required this.title, required this.content, required final  List<String> originImageUrls, required final  List<String> thumbnailImageUrls, required this.price, required this.createdAt, required this.updatedAt, required this.tradeType, this.detailAddress, this.meetingPointLat, this.meetingPointLong, this.favorites = 0, this.views = 0}): _originImageUrls = originImageUrls,_thumbnailImageUrls = thumbnailImageUrls,super._();
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

@override final  String id;
@override final  String title;
@override final  String content;
 final  List<String> _originImageUrls;
@override List<String> get originImageUrls {
  if (_originImageUrls is EqualUnmodifiableListView) return _originImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_originImageUrls);
}

 final  List<String> _thumbnailImageUrls;
@override List<String> get thumbnailImageUrls {
  if (_thumbnailImageUrls is EqualUnmodifiableListView) return _thumbnailImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_thumbnailImageUrls);
}

@override final  int price;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  TradeType tradeType;
@override final  String? detailAddress;
@override final  double? meetingPointLat;
@override final  double? meetingPointLong;
@override@JsonKey() final  int favorites;
@override@JsonKey() final  int views;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._originImageUrls, _originImageUrls)&&const DeepCollectionEquality().equals(other._thumbnailImageUrls, _thumbnailImageUrls)&&(identical(other.price, price) || other.price == price)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.tradeType, tradeType) || other.tradeType == tradeType)&&(identical(other.detailAddress, detailAddress) || other.detailAddress == detailAddress)&&(identical(other.meetingPointLat, meetingPointLat) || other.meetingPointLat == meetingPointLat)&&(identical(other.meetingPointLong, meetingPointLong) || other.meetingPointLong == meetingPointLong)&&(identical(other.favorites, favorites) || other.favorites == favorites)&&(identical(other.views, views) || other.views == views));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,const DeepCollectionEquality().hash(_originImageUrls),const DeepCollectionEquality().hash(_thumbnailImageUrls),price,createdAt,updatedAt,tradeType,detailAddress,meetingPointLat,meetingPointLong,favorites,views);

@override
String toString() {
  return 'Post(id: $id, title: $title, content: $content, originImageUrls: $originImageUrls, thumbnailImageUrls: $thumbnailImageUrls, price: $price, createdAt: $createdAt, updatedAt: $updatedAt, tradeType: $tradeType, detailAddress: $detailAddress, meetingPointLat: $meetingPointLat, meetingPointLong: $meetingPointLong, favorites: $favorites, views: $views)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String content, List<String> originImageUrls, List<String> thumbnailImageUrls, int price, DateTime createdAt, DateTime updatedAt, TradeType tradeType, String? detailAddress, double? meetingPointLat, double? meetingPointLong, int favorites, int views
});




}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? content = null,Object? originImageUrls = null,Object? thumbnailImageUrls = null,Object? price = null,Object? createdAt = null,Object? updatedAt = null,Object? tradeType = null,Object? detailAddress = freezed,Object? meetingPointLat = freezed,Object? meetingPointLong = freezed,Object? favorites = null,Object? views = null,}) {
  return _then(_Post(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,originImageUrls: null == originImageUrls ? _self._originImageUrls : originImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnailImageUrls: null == thumbnailImageUrls ? _self._thumbnailImageUrls : thumbnailImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,tradeType: null == tradeType ? _self.tradeType : tradeType // ignore: cast_nullable_to_non_nullable
as TradeType,detailAddress: freezed == detailAddress ? _self.detailAddress : detailAddress // ignore: cast_nullable_to_non_nullable
as String?,meetingPointLat: freezed == meetingPointLat ? _self.meetingPointLat : meetingPointLat // ignore: cast_nullable_to_non_nullable
as double?,meetingPointLong: freezed == meetingPointLong ? _self.meetingPointLong : meetingPointLong // ignore: cast_nullable_to_non_nullable
as double?,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
