import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_realm_firebase/widgets/details_screen.dart';
import 'package:recipe_realm_firebase/widgets/food_item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getGridView() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection("Fast Food").get();
    return snapshot.docs;
  }

  Future<Null> getRefresh() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      getGridView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: FutureBuilder(
          future: getGridView(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              return RefreshIndicator(
                onRefresh: getRefresh,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var ourData =
                        snapshot.data![index].data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              itemName: ourData['itemName'] ?? '',
                              itemImage: ourData['itemImage'] ?? '',
                              ingredients: ourData['ingredients'] ?? '',
                              itemDescription: ourData['itemDescription'] ?? '',
                            ),
                          ),
                        );
                      },
                      child: FoodItemCard(
                        itemImage: ourData['itemImage'] ?? '',
                        itemName: ourData['itemName'] ?? '',
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text("No data found"),
              );
            }
          },
        ),
      ),
    );
  }
}
