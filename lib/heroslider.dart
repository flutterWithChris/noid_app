import 'package:flutter/material.dart';

class HeroSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      clipBehavior: Clip.antiAlias,

        child: Container(
          height: 400,

          child: Column(
      children: <Widget> [
      Image.network('https://noidbotanicals.com/wp-content/uploads/2021/10/20211005143841_IMG_3843-1-855x500.jpg'),

        ListTile(
          title: const Text('Does CBD Have Calories?', style: TextStyle(fontWeight: FontWeight.bold)),
        ),

        Text('Counting the calories in each different CBD product.'),
        
        Padding(padding: EdgeInsets.fromLTRB(10, 30, 10, 10)),

        ButtonBar(
         alignment: MainAxisAlignment.center,
         children: [
           ElevatedButton(onPressed: null, child: const Text('Read More'))
         ],
        ),

    ]),

        )

    );

  }

}
