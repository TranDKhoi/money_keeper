import 'package:get/get.dart';

import '../../../data/models/category.dart';

class CategoryController extends GetxController{

  var selectedCategoryPic = Rxn<int>();

  var selectedEditCategory = Rxn<Category>();

}