import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../core/api_services.dart';
import '../model/user_model.dart';

class HomeScreenController extends GetxController {

  ScrollController scrollController = ScrollController();
  RxList<User> usersList = <User>[].obs;
  RxBool isLoading = true.obs;
  RxBool maxdetails = true.obs;

  void getUserFromAPI(bool ispagination) async {

        isLoading.value = !(ispagination);
        List<User> templist = await ApiService.getUser(usersList.length);
        usersList.addAll(templist);
        isLoading.value = false;
  }
}