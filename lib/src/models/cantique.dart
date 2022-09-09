// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CantiqueModel {
  final String title;
  final int number;
  final Lang language;
  final bool refrain;
  final List<Strophe> strophes;
  final bool bookmarked;
  final CrossReference equivalence;
  CantiqueModel({
    required this.title,
    required this.number,
    required this.language,
    required this.refrain,
    required this.strophes,
    required this.bookmarked,
    required this.equivalence,
  });

  CantiqueModel copyWith({
    String? title,
    int? number,
    Lang? language,
    bool? refrain,
    List<Strophe>? strophes,
    CrossReference? equivalence,
    bool? bookmarked,
  }) {
    return CantiqueModel(
        title: title ?? this.title,
        number: number ?? this.number,
        language: language ?? this.language,
        refrain: refrain ?? this.refrain,
        strophes: strophes ?? this.strophes,
        bookmarked: bookmarked ?? this.bookmarked,
        equivalence: equivalence ?? this.equivalence);
  }

  factory CantiqueModel.fromMap(Map<String, dynamic> map, String? lang) {
    return CantiqueModel(
        title: (map['title'] ?? '') as String,
        number: (map['number'] ?? 0) as int,
        language: Lang(desc: lang ?? 'fr', lang: lang ?? 'fr'),
        bookmarked: false,
        equivalence: CrossReference(
          francais: (map['references']['fr'] ?? 0) as int,
          fulfulde: (map['references']['ful'] ?? 0) as int,
          english: (map['references']['en'] ?? 0) as int,
        ),
        refrain: (map['parts'] as List<dynamic>).contains('refrain'),
        strophes: (map['parts'] as List<dynamic>).map((part) {
          return Strophe.fromMap({
            'number': part as String,
            'vers': map[part] as List<dynamic>,
          });
        }).toList());
  }

  @override
  String toString() {
    return 'CantiqueModel(title: $title, number: $number, refrain: $refrain, strophes: $strophes)';
  }
}

class CrossReference {
  final int fulfulde;
  final int francais;
  final int english;
  CrossReference({
    required this.fulfulde,
    required this.francais,
    required this.english,
  });
}

var model = {
  "1": [
    "Miséricorde insondable!",
    "Dieu peut-il tout pardonné?",
    "Absoudre un si grand coupable,",
    "Et mes péchés oublier?"
  ],
  "2": [
    "Longtemps j'ai loin de sa face,",
    "Provoqué son saint courroux,",
    "Fermé mon coeur à sa grâce,",
    "Blessé le sien devant tous."
  ],
  "3": [
    "Ô Jésus, à toi je cède,",
    "Je veux être libéré;",
    "De tout péché qui m'obsède",
    "Être à jamais délivré."
  ],
  "4": [
    "Alléluia!  Plus de doute,",
    "Mon fardeau m'est enlevé;",
    "Pour le ciel je suis en route,",
    "Heureux pour l'éternité."
  ],
  "title": "Miséricorde insondable",
  "number": 271,
  "refrain": [
    "Jésus, je viens, je viens à toi.",
    "Tel que je suis, je viens à toi.",
    "Jésus, je viens, je viens à toi.",
    "Tel que je suis, prends-moi."
  ],
  "slides": ["1", "refrain", "2", "refrain", "3", "refrain", "4", "refrain"],
  "parts": ["1", "refrain", "2", "3", "4"]
};

class Lang {
  final String lang;
  final String desc;
  Lang({
    required this.lang,
    required this.desc,
  });
}

class Strophe {
  final String number;
  final List<Vers> vers;
  Strophe({
    required this.number,
    required this.vers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'vers': vers.map((x) => x.toMap()).toList(),
    };
  }

  factory Strophe.fromMap(Map<String, dynamic> map) {
    return Strophe(
      number: (map['number'] ?? '') as String,
      vers: List<Vers>.from(
        (map['vers'] as List<dynamic>).map<Vers>(
          (line) => Vers.fromMap(
              {'content': line as String, 'bis': line.contains('2x')}),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Strophe.fromJson(String source) =>
      Strophe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Strophe(number: $number, vers: $vers)';
}

class Vers {
  final String content;
  final bool bis;
  Vers({
    required this.content,
    required this.bis,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'bis': bis,
    };
  }

  factory Vers.fromMap(Map<String, dynamic> map) {
    return Vers(
      content: ((map['content'] ?? '') as String).replaceAll('(2x)', ''),
      bis: (map['content'] as String).contains('(2x)'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Vers.fromJson(String source) =>
      Vers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Vers(content: $content, bis: $bis)';
}
