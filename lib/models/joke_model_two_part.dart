class JokeModelTwoPart {
  final bool error;
  final String category;
  final String type;
  final String setup;
  final String delivery;
  // final Map<String,bool> flags;
  final num id;
  final String lang;

  JokeModelTwoPart({
    this.error,
    this.category,
    this.type,
    this.setup,
    this.delivery,
    // this.flags,
    this.id,
    this.lang,
  });

  factory JokeModelTwoPart.fromJson(Map<String, dynamic> json) {
    return JokeModelTwoPart(
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
