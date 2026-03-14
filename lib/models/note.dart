class Note {
  final String title;
  final String desc;

  Note({required this.title, required this.desc});

  Map<String, dynamic> toJson() => {
    'title': title,
    'desc': desc,
  };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    title: json['title'],
    desc: json['desc'],
  );
}
