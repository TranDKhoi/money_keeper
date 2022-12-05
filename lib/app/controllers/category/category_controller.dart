import 'package:get/get.dart';

import '../../../data/models/category.dart';

class CategoryController extends GetxController{
  var selectedCategoryPic = Rxn<int>();
  var selectedEditCategory = Rxn<Category>();
  var selectedType = Rxn<String>();
  var listType = ["Income".tr,"Expense".tr];


  void changeType (String val){
    selectedType.value = val;
  }
}