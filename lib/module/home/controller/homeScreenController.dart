import 'package:get/get.dart';
import '../../../core/api_services.dart';
import '../model/user_model.dart';

class HomeScreenController extends GetxController {

  RxList<User> usersList = <User>[].obs;
  RxBool isLoading = true.obs;

  void getUserFromAPI() async {
        isLoading.value = true;

        ApiService.getUser();

        isLoading.value = false;
  }
}