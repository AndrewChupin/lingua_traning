

class Word {
  int id;
  String word;
  String translate;
  String transcription;
  String soundUrl;
  String imageUrl;
  bool isCompleted;

  Word({
    this.id,
    this.word,
    this.translate,
    this.transcription,
    this.soundUrl,
    this.imageUrl,
    this.isCompleted
  });

  factory Word.fromMap(Map<String, dynamic> params) => Word(
      id: params["_id"],
      word: params["word_value"],
      translate: params["translate_value"] ?? "",
      transcription: params["transcription"] ?? "",
      soundUrl: params["sound_url"] ?? "",
      imageUrl: params["pic_url"] ?? "",
      isCompleted: params["ic_completed"] == 1 ? true : false
  );

  @override
  String toString() {
    return 'Word{id: $id, word: $word, translate: $translate, transcription: $transcription, soundUrl: $soundUrl, imageUrl: $imageUrl, isCompleted: $isCompleted}';
  }
}



