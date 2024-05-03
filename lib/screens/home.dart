import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http_with_flutter/models/procut_model.dart';

import '../models/all_products_model.dart';
import '../services/http_service.dart';
import '../services/storage_service.dart';
import 'item_detail.dart';
import 'search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return StorageService.showHome ? Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: SvgPicture.asset('assets/icons/menu.svg', height: 16, width: 16)
            ),
            const SizedBox(width: 20),
            const Text("Market plays",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => setState(() => StorageService.showHome = false),
              child: Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SvgPicture.asset('assets/icons/search_border.svg', height: 20, width: 20)
              )
            ),
            const SizedBox(width: 10),
            GestureDetector(
              child: Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SvgPicture.asset('assets/icons/bell.svg', height: 20, width: 20),
              )
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: FutureBuilder(
              future: searching(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  // return const Center(child: CircularProgressIndicator(color: Colors.blue));
                  return const SizedBox.shrink();
                } else if(snapshot.hasData){
                  return snapshot.data ?? const Center(child: Text('Nimadir xato ketdi', style: TextStyle(color: Colors.red)));
                } else {
                  return const Center(child: Text('Nimadir xato ketdi', style: TextStyle(color: Colors.red)));
                }
              },
            ),
          ),
          const SizedBox(height: 15),
          FutureBuilder(
            future: searching10(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(color: Colors.blue));
              } else if(snapshot.hasData){
                return snapshot.data ?? const Center(child: Text('Nimadir xato ketdi', style: TextStyle(color: Colors.red)));
              } else {
                return const Center(child: Text('Nimadir xato ketdi', style: TextStyle(color: Colors.red)));
              }
            },
          ),
        ],
      ),
    ) : Search(back: (){
      StorageService.showHome = true;
      StorageService.searchResult = false;
      setState(() {});
    });
  }

  Future<Widget> searching() async {
    String? result = await NetworkService.getDate(
      api: NetworkService.apiAllProducts,
      param: NetworkService.searchParam("")
    );

    if(result != null){
      AllProductsModel allProductsModel = AllProductsModel.fromJson(json.decode(result));
      int length = allProductsModel.products.length;
      List<ProductModel> products = [
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
      ];


      return FlutterCarousel.builder(
        itemCount: products.length,
        itemBuilder: (context, index, realIndex) {
          ProductModel productModel = products[index];
          return InkWell(
            onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => TaxiDetails(productModel: productModel))),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xffDFE1E7)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(productModel.thumbnail)
                )
              ),
            ),
          );
        },
        options: CarouselOptions(
          controller: carouselController,
          enableInfiniteScroll: true,
          autoPlay: true,
          viewportFraction: 0.85,
          showIndicator: false,
        ),
      );
    }
    return const Center(child: Text('Nimadir xato ketdi', style: TextStyle(color: Colors.red)));
  }

  Future<Widget> searching10() async {
    String? result = await NetworkService.getDate(
      api: NetworkService.apiAllProducts,
      param: NetworkService.searchParam("")
    );

    if(result != null){
      AllProductsModel allProductsModel = AllProductsModel.fromJson(json.decode(result));
      int length = allProductsModel.products.length;
      List<ProductModel> products = [
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
        allProductsModel.products[Random().nextInt(length)],
      ];

      return Column(
        children: List.generate(products.length, (index) {
          ProductModel productModel = products[index];
          return InkWell(
            onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => TaxiDetails(productModel: productModel))),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              height: MediaQuery.of(context).size.width + 100,
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: const Color(0xffF0EFF4),
                border: Border.all(color: const Color(0xffDFE1E7)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(productModel.thumbnail)
                        )
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(productModel.title,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(productModel.category,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(productModel.brand,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text("\$${productModel.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                const Icon(Icons.star, color: Colors.amber),
                                const SizedBox(width: 5),
                                Text(productModel.rating.toString()),
                                const SizedBox(width: 5),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      );
    }
    return const Center(child: Text('Nimadir xato ketdi', style: TextStyle(color: Colors.red)));
  }
}
