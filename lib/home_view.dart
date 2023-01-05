import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: Hive.openBox('umer_db'),
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(snapshot.data!.get('name').toString()),
                      trailing: IconButton(
                        onPressed: () {
                          snapshot.data!.delete('name');
                          setState(() {

                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                    ListTile(
                      title: Text(snapshot.data!.get('age').toString()),
                      trailing: IconButton(
                        onPressed: () {
                          snapshot.data!.put('age', 15);
                          setState(() {

                          });
                        },
                        icon: const Icon(Icons.update),
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('umer_db');
          box.put('name', 'umer');
          box.put('age', 22);
          box.put('info', {'salary': 2500, 'company': 'iplex soft'});
        },
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}
