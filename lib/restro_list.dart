import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restro_finder/models/restros.dart';
import 'package:restro_finder/providers/restros.dart';
import 'package:restro_finder/restro_screen.dart';
import 'package:restro_finder/search_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer/shimmer.dart';



class RestroList extends StatefulWidget {
  const RestroList({super.key});

  @override
  State<RestroList> createState() => _RestroListState();
}

class _RestroListState extends State<RestroList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Restaurants", style: TextStyle(color: Colors.black, fontSize: 18.sp)),
        elevation: 0,
        leadingWidth: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => SearchScreen()));
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10.sp,
          ),
          Icon(
            Icons.more_vert_outlined,
            color: Colors.black,
          ),
          SizedBox(
            width: 10.sp,
          ),
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<RestroProvider>(context, listen: false).getRestros(context),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return _loadingShimmer();
            }
            return Consumer<RestroProvider>(
              builder: (ctx, restro, child) => ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  Restro currentRestro = restro.restros[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => RestroScreen(restro: currentRestro)));
                      },
                      child: Card(
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 75.sp,
                                    width: 65.sp,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              currentRestro.imageUrl,
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(6.sp),
                                        color: Colors.grey.shade300),
                                  ),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cost for 2: ${currentRestro.cost}",
                                        style: TextStyle(color: Colors.blue.shade900),
                                      ),
                                      SizedBox(
                                        height: 3.sp,
                                      ),
                                      Text(
                                        currentRestro.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      RatingBar.builder(
                                        initialRating: currentRestro.rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 16.sp,
                                        itemPadding: EdgeInsets.symmetric(horizontal:0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      )
                                      // Text(
                                      //   "rating: ${currentRestro.rating}",
                                      //   style: TextStyle(color: Colors.blue.shade900),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                itemCount: restro.restros.length,
              ),
            );
          }),
    );
  }


  _loadingShimmer() {
    return ListView.builder(
      itemBuilder: (_, i) {
        return Shimmer.fromColors(
          baseColor: Color(0xFFE0E0E0),
          highlightColor: Color(0xFFF5F5F5),
          enabled: true,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      itemCount: 5,
    );
  }
}
