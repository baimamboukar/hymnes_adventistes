import 'dart:convert';

import 'package:flutter/foundation.dart';

class Cantique {
  final List<String> n1;
  final List<String> n2;
  final List<String> n3;
  final List<String> n4;
  final String title;
  final int number;
  final List<String> refrain;
  final List<String> slides;
  final List<String> parts;
  Cantique({
    required this.n1,
    required this.n2,
    required this.n3,
    required this.n4,
    required this.title,
    required this.number,
    required this.refrain,
    required this.slides,
    required this.parts,
  });

  Cantique copyWith({
    List<String>? n1,
    List<String>? n2,
    List<String>? n3,
    List<String>? n4,
    String? title,
    int? number,
    List<String>? refrain,
    List<String>? slides,
    List<String>? parts,
  }) {
    return Cantique(
      n1: n1 ?? this.n1,
      n2: n2 ?? this.n2,
      n3: n3 ?? this.n3,
      n4: n4 ?? this.n4,
      title: title ?? this.title,
      number: number ?? this.number,
      refrain: refrain ?? this.refrain,
      slides: slides ?? this.slides,
      parts: parts ?? this.parts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '1': n1,
      '2': n2,
      '3': n3,
      '4': n4,
      'title': title,
      'number': number,
      'refrain': refrain,
      'slides': slides,
      'parts': parts,
    };
  }

  factory Cantique.fromMap(Map<String, dynamic> map) {
    return Cantique(
      n1: List<String>.from((map['1'] ?? const <String>[]) as List<String>),
      n2: List<String>.from((map['2'] ?? const <String>[]) as List<String>),
      n3: List<String>.from((map['3'] ?? const <String>[]) as List<String>),
      n4: List<String>.from((map['4'] ?? const <String>[]) as List<String>),
      title: (map['title'] ?? '') as String,
      number: (map['number'].toInt() ?? 0) as int,
      refrain: List<String>.from((map['refrain'] ?? const <String>[]) as List<String>),
      slides: List<String>.from((map['slides'] ?? const <String>[]) as List<String>),
      parts: List<String>.from((map['parts'] ?? const <String>[]) as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cantique.fromJson(String source) => Cantique.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cantique(n1: $n1, n2: $n2, n3: $n3, n4: $n4, title: $title, number: $number, refrain: $refrain, slides: $slides, parts: $parts)';
  }

  @override
  bool operator ==(covariant Cantique other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.n1, n1) &&
      listEquals(other.n2, n2) &&
      listEquals(other.n3, n3) &&
      listEquals(other.n4, n4) &&
      other.title == title &&
      other.number == number &&
      listEquals(other.refrain, refrain) &&
      listEquals(other.slides, slides) &&
      listEquals(other.parts, parts);
  }

  @override
  int get hashCode {
    return n1.hashCode ^
      n2.hashCode ^
      n3.hashCode ^
      n4.hashCode ^
      title.hashCode ^
      number.hashCode ^
      refrain.hashCode ^
      slides.hashCode ^
      parts.hashCode;
  }
}