import 'package:json_annotation/json_annotation.dart';

part 'restaurants.g.dart';

@JsonSerializable()
class Restaurant {
  @JsonKey(defaultValue: '')
  final String name, id, image;

  Restaurant({
    required this.name,
    required this.id,
    required this.image,
  });


  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}

@JsonSerializable()
class Restaurants {
  @JsonKey(
    defaultValue: [],
    name: 'results',
  )
  final List<Restaurant> restaurants;

  Restaurants(this.restaurants);

  factory Restaurants.fromJson(Map<String, dynamic> json) =>
      _$RestaurantsFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantsToJson(this);
}
