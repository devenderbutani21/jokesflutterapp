class JokeModelOnePart {
  final bool error;
  final String category;
  final String type;
  final String joke;
  // final Map<String,bool> flags;
  final num id;
  final String lang;

  JokeModelOnePart({
    this.error,
    this.category,
    this.type,
    this.joke,
    // this.flags,
    this.id,
    this.lang,
  });

  factory JokeModelOnePart.fromJson(Map<String, dynamic> json) {
    return JokeModelOnePart(
      error : json['error'],
      category : json['category'],
      type : json['type'],
      joke: json['joke'],
      // flags : json['flags'],
      id : json['id'],
      lang : json['lang'],
    );
  }
}
