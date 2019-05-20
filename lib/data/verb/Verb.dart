

import 'dart:math';

enum VerbForm {
  PRESENT, PAST, PERFECT
}

class Verb {
  final int id;
  final String present;
  final String past;
  final String perfect;
  final String translate;

  Verb({
    this.id,
    this.present,
    this.past,
    this.perfect,
    this.translate,
  });

  factory Verb.fromMap(Map<String, dynamic> params) => Verb(
    id: params["id"],
    present: params["present"],
    past: params["past"] ?? "",
    perfect: params["perfect"] ?? "",
    translate: params["translate"] ?? "",
  );

  String getVerb(VerbForm form) {
    switch(form) {
      case VerbForm.PRESENT:
        return present;
      case VerbForm.PAST:
        return past;
      case VerbForm.PERFECT:
        return perfect;
    }
  }

  VerbForm getFrom() {
    int next = Random().nextInt(3);

    switch (next) {
      case 0:
        return VerbForm.PRESENT;
      case 1:
        return VerbForm.PAST;
      case 2:
        return VerbForm.PERFECT;
    }
  }

  @override
  String toString() {
    return 'Verb{id: $id, present: $present, past: $past, perfect: $perfect, translate: $translate}';
  }

}

