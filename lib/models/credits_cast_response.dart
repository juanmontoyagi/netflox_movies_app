import 'dart:convert';

class CreditCastResponse {
    int id;
    List<Cast> cast;
    List<Cast> crew;

    CreditCastResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory CreditCastResponse.fromJson(String str) => CreditCastResponse.fromMap(json.decode(str));

    factory CreditCastResponse.fromMap(Map<String, dynamic> json) => CreditCastResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
    );
}

class Cast {
    bool adult;
    int gender;
    int id;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String? job;

    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.name,
        required this.originalName,
        required this.popularity,
        required this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.job,
    });

    get fullProfileImg{
      if (this.profilePath != null){
        return 'https://image.tmdb.org/t/p/w500${ this.profilePath }';
      } else {
        return 'https://i.stack.imgur.com/GNhx0.png';
      }
    }

    factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

    factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        job: json["job"],
    );
}
