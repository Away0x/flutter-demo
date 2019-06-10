class CategoryListData {
  double oriPrice;
  String image;
  String goodsId;
  double presentPrice;
  String goodsName;

  CategoryListData(
      {this.oriPrice,
      this.image,
      this.goodsId,
      this.presentPrice,
      this.goodsName});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    oriPrice = json['oriPrice'];
    image = json['image'];
    goodsId = json['goodsId'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oriPrice'] = this.oriPrice;
    data['image'] = this.image;
    data['goodsId'] = this.goodsId;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    return data;
  }
}