import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http_with_flutter/models/all_products_model.dart';
import 'package:http_with_flutter/models/procut_model.dart';

import 'item_detail.dart';

class FoundData extends StatelessWidget {
  final AllProductsModel allProductsModel;
  const FoundData({required this.allProductsModel, super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      itemCount: allProductsModel.products.length,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        ProductModel productModel = allProductsModel.products[index];
        return InkWell(
          onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => TaxiDetails(productModel: productModel))),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            height: 280,
            decoration: BoxDecoration(
              color: const Color(0xffF0EFF4),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  height: 160,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productModel.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(productModel.brand,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text("\$${productModel.price}",
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
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 5),
                            Text(productModel.rating.toString()),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Ushbu funksiya vaqtinchalik ish vaoliyatida emas"),
                                        const SizedBox(height: 10),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("OK", style: TextStyle(color: Colors.blue)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: SvgPicture.asset('assets/icons/bookmark_border.svg', width: 18, height: 18)
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
