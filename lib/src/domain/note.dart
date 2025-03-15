class NoteBasic {
  String id;
  int categoryId;
  String title;
  int classification;
  DateTime createTime;
  DateTime lastUpdateTime;

  NoteBasic({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.classification,
    required this.createTime,
    required this.lastUpdateTime,
  });
}
