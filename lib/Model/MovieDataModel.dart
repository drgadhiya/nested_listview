class MovieDataModel {
  int? num;
  String? name;
  String? title;
  String? year;
  String? streamType;
  int? streamId;
  String? streamIcon;
  String? added;
  String? categoryId;
  List<int>? categoryIds;
  String? containerExtension;
  String? customSid;
  String? directSource;

  MovieDataModel(
      {this.num,
        this.name,
        this.title,
        this.year,
        this.streamType,
        this.streamId,
        this.streamIcon,
        this.added,
        this.categoryId,
        this.categoryIds,
        this.containerExtension,
        this.customSid,
        this.directSource});

  MovieDataModel.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
    title = json['title'];
    year = json['year'];
    streamType = json['stream_type'];
    streamId = json['stream_id'];
    streamIcon = json['stream_icon'];
    added = json['added'];
    categoryId = json['category_id'];
    categoryIds = json['category_ids'].cast<int>();
    containerExtension = json['container_extension'];
    customSid = json['custom_sid'];
    directSource = json['direct_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['name'] = this.name;
    data['title'] = this.title;
    data['year'] = this.year;
    data['stream_type'] = this.streamType;
    data['stream_id'] = this.streamId;
    data['stream_icon'] = this.streamIcon;
    data['added'] = this.added;
    data['category_id'] = this.categoryId;
    data['category_ids'] = this.categoryIds;
    data['container_extension'] = this.containerExtension;
    data['custom_sid'] = this.customSid;
    data['direct_source'] = this.directSource;
    return data;
  }
}