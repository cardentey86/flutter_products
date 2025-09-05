import 'package:flutter/material.dart';
import 'package:productos/modules/product/screens/product_review_screen.dart';

import 'modules/product/screens/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Products',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Flutter Demo Products'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.production_quantity_limits, color: Colors.white,)),
              Tab(icon: Icon(Icons.rate_review, color: Colors.white,)),
            ],
            indicatorColor: Colors.white,),
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(widget.title, style: TextStyle(color: Colors.white),),
          ),
          body: TabBarView(
              children: [
                const ProductScreen(),
                const ProductReviewScreen(),
              ]
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            tooltip: 'Add product',
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
