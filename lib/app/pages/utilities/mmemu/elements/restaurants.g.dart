// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'image': instance.image,
    };

Restaurants _$RestaurantsFromJson(Map<String, dynamic> json) => Restaurants(
      (json['results'] as List<dynamic>?)
              ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RestaurantsToJson(Restaurants instance) =>
    <String, dynamic>{
      'results': instance.restaurants,
    };
