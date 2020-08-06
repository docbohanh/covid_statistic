class Prevention {
  String prevention, description, imagePath;

  Prevention({this.prevention, this.description, this.imagePath});

  Prevention.fromJson(Map<String, dynamic> json)
      : prevention = json['prevention'],
        description = json['desc'],
        imagePath = json['imgPath'];
}
