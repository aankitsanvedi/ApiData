import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_01/Model/categories_model.dart';
import 'package:project_01/Model/product_model.dart';
import 'package:project_01/View/Pages/Home/categorie_home.dart';
import 'package:project_01/View/Pages/Home/product_home.dart';

import '../../../Controller/Service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<CategoriesModel> categoriesmodel = [];
  List<ProductModel> productmodel = [];

  _getCategories() {
    isLoading = true;
    ApiService().getCategoriesList().then((value) {
      setState(() {
        categoriesmodel = value!;
        isLoading = false;
      });
    });
  }

  _getProducts() {
    isLoading = true;
    ApiService().getProductList().then((value) {
      setState(() {
        productmodel = value!;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _getCategories();
    _getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column( 
            children: [
              Text('Categrgry'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesmodel.length,
                  itemBuilder: (BuildContext context, index) {
                    // final categories = categoriesmodel[index];
        
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategorieHome(
                                  categoriesModels: categoriesmodel[index],
                                )));
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child:
                                        // categoriesmodel[index].image.toString() !=
                                        //         null
                                        //     ? Image.network(
                                        //         height: 50,
                                        //         width: 50,
                                        //         categoriesmodel[index]
                                        //             .image
                                        //             .toString(),
                                        //       )
                                        //     : 
                                            Image.network(
                                                height: 50,
                                                width: 50,
                                                categoriesmodel[index]
                                                    .image
                                                    .toString()),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    categoriesmodel[index].name.toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     Text('Product Type'),
              //     Text('See All')
              //   ],
              // ),
              // SingleChildScrollView(
              //   child: Column(children: [
              //     GridView.builder(
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2, // number of items in each row
              //       mainAxisSpacing: 8.0, // spacing between rows
              //       crossAxisSpacing: 8.0, // spacing between columns
              //     ),
              //     physics: const BouncingScrollPhysics(),
              //     padding: const EdgeInsets.all(8.0), // padding around the grid
              //     itemCount: productmodel.length, // total number of items
              //     itemBuilder: (context, index) {
              //       return InkWell(
              //         onTap: () {
              //           Navigator.of(context).push(
              //             MaterialPageRoute(
              //               builder: (context) =>
              //                   ProductHome(productModel: productmodel[index]),
              //             ),
              //           );
              //         },
              //         child: Container(
              //           height: 600,
              //           width: 100,
              //           color: const Color.fromARGB(
              //               255, 225, 225, 225), // color of grid items
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               productmodel[index].images.toString() == null
              //                   ? Image.asset('assets/images/user_img.png')
              //                   : Image.network(
              //                       height: 100,
              //                       width: double.infinity,
              //                       productmodel[index].images!.first.toString(),
              //                       scale: 1,
              //                     ),
              //               const SizedBox(
              //                 height: 10,
              //               ),
              //               Text(
              //                 productmodel[index].title.toString(),
              //                 style: const TextStyle(fontSize: 14),
              //                 textAlign: TextAlign.center,
              //                 maxLines: 2,
              //               ),
              //               const SizedBox(
              //                 height: 5,
              //               ),
              //               Text(
              //                 '\$ ${productmodel[index].price}',
              //                 style: const TextStyle(
              //                     fontSize: 14, fontWeight: FontWeight.bold),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
        
        
              //   ],),
              // )
            ],
          ),
        ),
      )
    );
  }
}
