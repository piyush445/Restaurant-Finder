import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:restro_finder/restro_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'models/restros.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Restro> _restros = [];
  List<String> cities = ["delhi","mumbai","bangalore"];

  Future<void> _searchRestros(query) async {

    try {
      dynamic uri = Uri.parse("https://run.mocky.io/v3/fe7022c0-a398-441c-bf71-6d29d1297dd7");
      final response = await http.get(uri, headers: {});
      print(json.decode(response.body));

      var profileData = json.decode(response.body);
      final List<Restro> loadedRestros = [];
      final Map data = profileData['data'] as Map;
      data.forEach((key, element){
        if(key.contains(query)){
          List values = element as List;
          for(int i=0;i<values.length;i++){
          loadedRestros.add(
            Restro(
              name: values[i]['name']??"",
              address: values[i]['address']??"",
              cost: values[i]['cost_for_two']??800,
              rating: values[i]['rating']??4.0,
              hours: values[i]['hours']??"",
              imageUrl: values[i]['imageUrl']??"",
              phone: values[i]['phone']??""
            )
            );
          }
        }
      });

      setState(() {
        _restros = loadedRestros.toList();
      });
    } catch (e) {
      print(e);
    }
  }

  void _runFilter(String enteredKeyword) {
    print(enteredKeyword);

    if (enteredKeyword.isEmpty) {
      setState(() {
        _restros = [];
      });
    } else {
      for(int i=0;i<cities.length;i++){
        if(cities[i].contains(enteredKeyword)){
          _searchRestros(enteredKeyword);
        }
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text("Search", style: TextStyle(color: Colors.black, fontSize: 18.sp)),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            TextField(
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                hintText: 'Search Bangalore | Delhi | Mumbai',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF5669FF),
                ),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            _showRestros()
          ],
        ));
  }



  _showRestros() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          Restro currentRestro = _restros[index];
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
        itemCount: _restros.length,
      ),
    );
  }
}
