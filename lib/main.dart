
import 'package:flutter/material.dart';
import 'package:restro_finder/providers/restros.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'restro_list.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider.value(value:RestroProvider()),
      ],
      child: Sizer(
          builder: (context,orientation, deviceType) {
            return const MaterialApp(
              title: 'Flutter Restro Appp',
              debugShowCheckedModeBanner: false,
              home: RestroList(),
            );
          }

      ),
    );
  }
}
