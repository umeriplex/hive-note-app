import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/boxes/boxes.dart';
import 'package:hive_database/modals/note_modal.dart';
import 'package:hive_flutter/adapters.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final titleTextCont = TextEditingController();
  final descTextCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<NotaModal>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context,box,_){
          var data = box.values.toList().cast<NotaModal>();
          return ListView.builder(
            itemCount: box.length,
              itemBuilder: (context,index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(data[index].title,style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontFamily: 'Sans',fontSize: 24),),
                            const Spacer(),
                            InkWell(onTap: (){
                              _updateDialoge(data[index], data[index].title.toString(), data[index].description.toString());
                            },child: const Icon(Icons.edit,size: 40,)),
                            const SizedBox(width: 20,),
                            InkWell(onTap: (){
                              delete(data[index]);
                            },
                                child: const Icon(Icons.delete,color: Colors.red,size: 40,)),
                          ],
                        ),
                        Text(data[index].description,style: const TextStyle(color: Colors.black,fontFamily: 'Sans',fontSize: 18),),
                      ],
                    ),
                  ),
                );
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialoge();
        },
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }

  Future<void> _showMyDialoge() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add notes'),
            actions: [
              TextButton(
                onPressed: () {
                  final data = NotaModal(
                      title: titleTextCont.text.toString(),
                      description: descTextCont.text.toString());
                  final box = Boxes.getData();
                  box.add(data);

                  data.save();
                  titleTextCont.clear();
                  descTextCont.clear();
                  print(box);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
            ],
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleTextCont,
                    decoration: const InputDecoration(
                      hintText: 'put title here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descTextCont,
                    decoration: const InputDecoration(
                      hintText: 'put description here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void delete(NotaModal notaModal) async{
    await notaModal.delete();
  }

  Future<void> _updateDialoge(NotaModal notaModal, String t, String d) async {

    titleTextCont.text = t;
    descTextCont.text = d;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Note'),
            actions: [
              TextButton(
                onPressed: () async {
                notaModal.title = titleTextCont.text.toString();
                notaModal.description = descTextCont.text.toString();
                notaModal.save();
                titleTextCont.clear();
                descTextCont.clear();
                Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
            ],
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleTextCont,
                    decoration: const InputDecoration(
                      hintText: 'put title here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descTextCont,
                    decoration: const InputDecoration(
                      hintText: 'put description here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

}
