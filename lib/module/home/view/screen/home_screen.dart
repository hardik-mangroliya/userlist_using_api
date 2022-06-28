
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/homeScreenController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
    homeScreenController.getUserFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        appBar: 
        AppBar(
          title: const Text("Home Screen"),
              ),
              drawer: Drawer(),
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
                      itemCount: homeScreenController.usersList.length,
                      itemBuilder: (context, index) {
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
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                        });
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