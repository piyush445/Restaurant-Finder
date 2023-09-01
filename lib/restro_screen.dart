import 'dart:convert';
import 'dart:ffi' as fi;

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'models/restros.dart';

class RestroScreen extends StatefulWidget {
  final Restro restro;
  const RestroScreen({super.key, required this.restro});

  @override
  State<RestroScreen> createState() => _RestroScreenState();
}

class _RestroScreenState extends State<RestroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // title: Text("Event Details", style: TextStyle(color: Colors.white, fontSize: 18.sp)),
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220.sp,
                width: double.infinity,
                // color: Colors.red,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.restro.imageUrl,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                child: Text(
                  widget.restro.name,
                  style: TextStyle(fontSize: 30.sp, color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        height: 40.sp,
                        width: 40.sp,
                        decoration: BoxDecoration(
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(4.sp)),
                        child: Center(
                          child: Icon(Icons.phone,
                            color: Color(0xFF5669FF),
                            size: 25.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.restro.phone,
                            style: TextStyle(fontSize: 11.sp),
                          ),
                          SizedBox(
                            height: 3.sp,
                          ),
                          Text(
                            "Contact",
                            style: TextStyle(fontSize: 8.sp, color: Colors.black38),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 40.sp,
                          width: 40.sp,
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              color: Color(0xFFEFF0FF),
                              borderRadius: BorderRadius.circular(4.sp)),
                          child: Center(
                              child: Icon(
                            Icons.calendar_month,
                            color: Color(0xFF5669FF),
                            size: 25.sp,
                          ))),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.restro.hours,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 3.sp,
                            ),
                            Text(
                              "Timing",
                              style: TextStyle(fontSize: 8.sp, color: Colors.black38),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 40.sp,
                          width: 40.sp,
                          decoration: BoxDecoration(
                              color: Color(0xFFEFF0FF), borderRadius: BorderRadius.circular(4.sp)),
                          // child: Center(
                          //   child: Image.asset(Assets.navigate,height: 25.sp,width: 25.sp,),
                          // ),
                          child: Center(
                              child: Icon(
                            Icons.pin_drop_rounded,
                            size: 25.sp,
                            color: Color(0xFF5669FF),
                          ))),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.restro.address,maxLines: 2,overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 3.sp,
                            ),
                            Text(
                             "Location",
                              style: TextStyle(fontSize: 8.sp, color: Colors.black38),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ]),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About Event",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.sp,
              ),
            ],
          ),
          _bookNowButton(),
        ],
      ),
    );
  }



  Widget _bookNowButton() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        height: 60.sp,
        color: Colors.white54,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 70.sp, right: 70.sp, bottom: 17.sp, top: 12.sp),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.sp)),
                minimumSize: Size(100.sp, 35.sp),
                primary: Color(0xFF5669FF)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("BOOK NOW",
                      style: TextStyle(
                          color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w500)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 23.sp,
                    width: 23.sp,
                    // padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.shade800),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
