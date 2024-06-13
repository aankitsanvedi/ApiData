import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_01/Controller/Service/api_service.dart';
import 'package:project_01/Model/categories_model.dart';
import 'package:project_01/Model/product_model.dart';
import 'package:project_01/View/Pages/Home/categorie_home.dart';
import 'package:project_01/View/Pages/Home/product_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  List imageList = [
    {"id": 1, "image_path": 'assets/images/banner.png'},
    {"id": 2, "image_path": 'assets/images/bestsellersbanner.png'},
    {"id": 3, "image_path": 'assets/images/banner.png'},
    {"id": 4, "image_path": 'assets/images/bestsellersbanner.png'},
    {"id": 5, "image_path": 'assets/images/banner.png'},
    {"id": 6, "image_path": 'assets/images/bestsellersbanner.png'},
    {"id": 7, "image_path": 'assets/images/banner.png'}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 0.0)),
                          hintText: 'Search',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                          prefixIcon: Container(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.search),
                            width: 18,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      print(currentIndex);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselSlider(
                        items: imageList
                            .map(
                              (item) => Image.asset(
                                item['image_path'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                            .toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currentIndex == entry.key ? 17 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentIndex == entry.key
                                    ? Colors.red
                                    : Colors.teal),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.transparent,
              child: ListView.builder(
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
                                      categoriesmodel[index].image.toString() !=
                                              null
                                          ? Image.network(
                                              height: 50,
                                              width: 50,
                                              categoriesmodel[index]
                                                  .image
                                                  .toString(),
                                            )
                                          : Image.network(
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
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 500,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                ),
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8.0), // padding around the grid
                itemCount: productmodel.length, // total number of items
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductHome(productModel: productmodel[index]),
                        ),
                      );
                    },
                    child: Container(
                      height: 600,
                      width: 100,
                      color: const Color.fromARGB(
                          255, 225, 225, 225), // color of grid items
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          productmodel[index].images.toString() == null
                              ? Image.asset('assets/images/user_img.png')
                              : Image.network(
                                  height: 100,
                                  width: double.infinity,
                                  productmodel[index].images!.first.toString(),
                                  scale: 1,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            productmodel[index].title.toString(),
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '\$ ${productmodel[index].price}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         height: 200,
            //         width: 150,
            //         color: const Color.fromARGB(
            //             255, 225, 225, 225), // color of grid items
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             productmodel[0].images.toString() != null
            //                 ? Image.network(
            //                     height: 50,
            //                     width: 50,
            //                     categoriesmodel[0].image.toString())
            //                 : Image.network(
            //                     height: 100,
            //                     width: double.infinity,
            //                     productmodel[0].images!.first.toString(),
            //                     scale: 1,
            //                   ),
            //             // Image.asset(
            //             //     height: 100,
            //             //     width: 100,
            //             //     'assets/images/app_icon.jpg'),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Text(
            //               productmodel[0].title.toString(),
            //               style: const TextStyle(fontSize: 14),
            //               textAlign: TextAlign.center,
            //               maxLines: 2,
            //             ),
            //             const SizedBox(
            //               height: 5,
            //             ),
            //             Text(
            //               '\$ ${productmodel[0].price}',
            //               style: const TextStyle(
            //                   fontSize: 14, fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       Container(
            //         height: 200,
            //         width: 150,
            //         color: const Color.fromARGB(
            //             255, 225, 225, 225), // color of grid items
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             productmodel[1].images.toString() != null
            //                 ? Image.network(
            //                     height: 50,
            //                     width: 50,
            //                     categoriesmodel[1].image.toString())
            //                 : Image.network(
            //                     height: 100,
            //                     width: double.infinity,
            //                     productmodel[1].images!.first.toString(),
            //                     scale: 1,
            //                   ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Text(
            //               productmodel[1].title.toString(),
            //               style: const TextStyle(fontSize: 14),
            //               textAlign: TextAlign.center,
            //               maxLines: 2,
            //             ),
            //             const SizedBox(
            //               height: 5,
            //             ),
            //             Text(
            //               '\$ ${productmodel[1].price}',
            //               style: const TextStyle(
            //                   fontSize: 14, fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
