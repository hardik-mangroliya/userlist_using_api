
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/homeScreenController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  void pagination(){
    homeScreenController.scrollController.addListener(() {
      if(homeScreenController.scrollController.position.pixels==homeScreenController.scrollController.position.maxScrollExtent){
      homeScreenController.getUserFromAPI(true);
    }
    });
  }

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
    pagination();
    homeScreenController.getUserFromAPI(false);
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        appBar: 
        AppBar(
          title: const Text("Home Screen"),
              ),
        body: Obx(
          () => homeScreenController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : homeScreenController.usersList.isEmpty
                  ? const Center(
                      child: Text("No Data Found"),
                    )
                  : ListView.separated(
                      controller: homeScreenController.scrollController,
                      itemCount: homeScreenController.usersList.length+1,
                      itemBuilder: (context, index) {
                      if(index == homeScreenController.usersList.length && homeScreenController.maxdetails.value){
                        return const Padding(
                          padding: EdgeInsets.only(right: 150,left: 150,bottom: 10,top: 10),
                          child: CircularProgressIndicator(),
                        );
                      }
                        String firstName=homeScreenController
                                                .usersList[index].firstName ??
                                            '';
                        String lastName=homeScreenController.usersList[index].lastName ?? '';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 90,
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: ListTile(
                                     title: Text(
                                      (firstName) +
                                          ' ' +
                                          (lastName),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(homeScreenController
                                            .usersList[index].email ??
                                        "",
                                        maxLines: 1,),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Builder(builder: (context) {
                                          return const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                      }),
                                    ),
                                    leading: CircleAvatar(
                                      radius: 25,
                                      child: Text('${firstName[0]} ${lastName[0]}'),
                                    ),
                                ),
                              )
                            ),
                            )],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
        ));
  }
}