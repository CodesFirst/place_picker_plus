class LocationPlace {
  double northEastLat;
  double northEastLng;
  double southWestLat;
  double southWestLng;

  LocationPlace({
    this.northEastLat = 90.0,
    this.northEastLng = 180.0,
    this.southWestLat = 0.0,
    this.southWestLng = 0.0,
  });

  Map<String, dynamic> toJson() => {
    "southWestLat": southWestLat,
    "southWestLng": southWestLng,
    "northEastLat": northEastLat,
    "northEastLng": northEastLng,
  };
}
