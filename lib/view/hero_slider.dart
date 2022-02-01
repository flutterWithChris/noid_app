import 'package:flutter/material.dart';

class HeroSlider extends StatelessWidget {
  const HeroSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 350,
        child: Column(children: <Widget>[
          Image.network(
              'https://noidbotanicals.com/wp-content/uploads/2021/10/20211005143841_IMG_3843-1-855x500.jpg'),
          // ignore: prefer_const_constructors
          ListTile(
            title: const Text('Does CBD Have Calories?',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Text('Counting the calories in each different CBD product.'),
          const ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: null, child: Text('Read More'))
            ],
          ),
        ]),
      ),
    );
  }
}
