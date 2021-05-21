class CardInfo {
  CardInfo({
    this.make,
    this.model,
    this.price,
    this.year,
    this.origin,
    this.fuel,
    this.avaliable,
    this.paymentMethod,
    this.urlThumb,
  });

  String make;
  String model;
  int price;
  int year;
  String origin;
  String fuel;
  bool avaliable;
  String paymentMethod;
  String urlThumb;

  factory CardInfo.fromJson(Map<String, dynamic> json) => CardInfo(
        make: json["make"],
        model: json["model"],
        price: json["price"],
        year: json["year"],
        origin: json["origin"],
        fuel: json["fuel"],
        avaliable: json["avaliable"],
        paymentMethod: json["paymentMethod"],
        urlThumb: json["urlThumb"],
      );

  Map<String, dynamic> toJson() => {
        "make": make,
        "model": model,
        "price": price,
        "year": year,
        "origin": origin,
        "fuel": fuel,
        "avaliable": avaliable,
        "paymentMethod": paymentMethod,
        "urlThumb": urlThumb,
      };
}
