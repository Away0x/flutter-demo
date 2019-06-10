import './category_model.dart';

class CategoryBigModel {
  String mallCategoryID; // 类别编号
  String mallCategoryName; // 类别名称
  List<BxMallSubDto> bxMallSubDto; // 小类列表
  String image; // 类别图片
  Null comments; // 列表描述

  CategoryBigModel({
    this.mallCategoryID,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.image,
    this.comments,
  });

  factory CategoryBigModel.fromJson(Map<String, dynamic> json) {
    return CategoryBigModel(
      mallCategoryID: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: (json['bxMallSubDto'] as List).map((i) => BxMallSubDto.fromJson(i)).toList(),
      image: json['image'],
      comments: json['comments'],
    );
  }
}