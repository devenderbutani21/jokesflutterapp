class JokeModel {
  final bool error;
  final String category;
  final String type;
  final String setup;
  final String delivery;
  // final List<bool> flags;
  final num id;
  final String lang;

  JokeModel({
    this.error,
    this.category,
    this.type,
    this.setup,
    this.delivery,
    // this.flags,
    this.id,
    this.lang,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(
    error : json['error'],
    category : json['category'],
    type : json['type'],
    setup : json['setup'],
    delivery : json['delivery'],
    // flags : json['flags'],
    id : json['id'],
    lang : json['lang'],
    );
  }
}
