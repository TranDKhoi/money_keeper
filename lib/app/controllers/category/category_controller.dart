import 'package:get/get.dart';

import '../../../data/models/category.dart';
import '../../core/values/r.dart';

class CategoryController extends GetxController {
  //manage screen prop
  final List<Category> listCate = List.generate(
      13,
      (index) => Category(
          name: "name $index",
          image: index,
          type: index % 2 == 0 ? R.Income.tr : R.Expense.tr));
  var listCategoryUI = <Category>[].obs;

  void changeListCategory(int index) {
    switch (index) {
      case 0:
        var tempCate1 =
            Category(name: R.Loan.tr, type: R.Expense.tr, image: 21);
        var tempCate2 =
            Category(name: R.Debtcollection.tr, type: R.Income.tr, image: 22);
        var tempCate3 = Category(name: R.Debt.tr, type: R.Income.tr, image: 23);
        var tempCate4 =
            Category(name: R.Repayment.tr, type: R.Expense.tr, image: 20);
        listCategoryUI.value =
            List.from([tempCate1, tempCate2, tempCate3, tempCate4]);
        break;
      case 1:
        listCategoryUI.value = List.generate(
            13,
            (index) =>
                Category(name: "name $index", image: index, type: R.Income.tr));
        break;
      case 2:
        listCategoryUI.value = List.generate(
            5,
            (index) => Category(
                name: "name $index", image: index, type: R.Expense.tr));
        break;
    }
  }

  //add or edit prop
  var selectedCategoryPic = Rxn<int>();
  var selectedEditCategory = Rxn<Category>();
  var selectedType = Rxn<String>();
  var listType = [R.Income.tr, R.Expense.tr];

  void changeType(String val) {
    selectedType.value = val;
  }
}
