class Mylist {
  final String _make;
  final String _model;
  final String _year;
  final String _price;
  final String _date;

  Mylist(this._make, this._model, this._year, this._price, this._date);
  String getMake() {
    return this._make.toLowerCase().trim();
  }

  String getModel() {
    return this._model.toLowerCase().trim();
  }

  double getYear() {
    return double.parse(this._year.trim());
  }

  double getPrice() {
    return double.parse(this._price) / 1000;
  }

  DateTime getDate() {
    List<String> yearList = this._date.split('/');
    return DateTime(int.parse(yearList[2]), int.parse(yearList[1]));
  }
}

List<Mylist> dataFromFile = [];
