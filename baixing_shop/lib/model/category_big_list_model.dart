import './category_big_model.dart';

class CategoryBigListModel {
  List<CategoryBigModel> data;
  CategoryBigListModel({this.data});

  factory CategoryBigListModel.fromJson(List json) {
    return CategoryBigListModel(
      data: json.map((i) => CategoryBigModel.fromJson(i)).toList(),
    );
  }
}