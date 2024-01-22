import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  final String itemName;
  final String itemImage;
  final String ingredients;
  final String itemDescription;

  const DetailsScreen({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.ingredients,
    required this.itemDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text(itemName,
            style: GoogleFonts.notoSerifMalayalam(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200, // Adjust the height as needed
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Clip the image
                  child: Image.network(
                    itemImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              Align(
                alignment: Alignment.center,
                child: Text(
                  itemName,
                  style: GoogleFonts.notoSerifMalayalam(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
              const Divider(height: 1),
              Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.green, blurRadius: 2, spreadRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text("Ingredients:",
                        style: GoogleFonts.notoSerifMalayalam(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    Text(ingredients,
                        style: GoogleFonts.notoSerifMalayalam(fontSize: 15)),
                    Text("\nInstructions:",
                        style: GoogleFonts.notoSerifMalayalam(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    Text(itemDescription,
                        style: GoogleFonts.notoSerifMalayalam(fontSize: 15)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
