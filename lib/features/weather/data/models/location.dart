class Location {
  final int? id;
  final String? name;
  final double? latitude;
  final double? longtitude;
  final double? elevation;
  final String? featureCode;
  final String? countryCode;
  final int? admin1Id;
  final String? timezone;
  final int? population;
  final int? countryId;
  final String? country;
  final String? admin1;
  const Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longtitude,
    required this.elevation,
    required this.featureCode,
    required this.countryCode,
    required this.admin1Id,
    required this.timezone,
    required this.population,
    required this.countryId,
    required this.country,
    required this.admin1,
  });

  Location copyWith({
    int? id,
    String? name,
    double? longtitude,
    double? latitude,
    double? elevation,
    String? featureCode,
    String? countryCode,
    int? admin1Id,
    String? timezone,
    int? population,
    int? countryId,
    String? country,
    String? admin1,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      longtitude: longtitude ?? this.longtitude,
      latitude: latitude ?? this.latitude,
      elevation: elevation ?? this.elevation,
      featureCode: featureCode ?? this.featureCode,
      countryCode: countryCode ?? this.countryCode,
      admin1Id: admin1Id ?? this.admin1Id,
      timezone: timezone ?? this.timezone,
      population: population ?? this.population,
      countryId: countryId ?? this.countryId,
      country: country ?? this.country,
      admin1: admin1 ?? this.admin1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'longtitude': longtitude,
      'latitdude': latitude,
      'elevation': elevation,
      'feature_code': featureCode,
      'country_code': countryCode,
      'admin1_id': admin1Id,
      'timezone': timezone,
      'population': population,
      'country_id': countryId,
      'country': country,
      'admin1': admin1,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] as int?,
      name: map['name'] as String?,
      longtitude: map['longtitude'] as double?,
      latitude: map['latitude'] as double?,
      elevation: map['elevation'] as double?,
      featureCode: map['feature_code'] as String?,
      countryCode: map['country_code'] as String?,
      admin1Id: map['admin1_id'] as int?,
      timezone: map['timezone'] as String?,
      population: map['population'] as int?,
      countryId: map['country_id'] as int?,
      country: map['country'] as String?,
      admin1: map['admin1'] as String?,
    );
  }
}
