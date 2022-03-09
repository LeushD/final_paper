import 'package:flutter/material.dart';

import 'main.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список пользователей'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Назад',
            onPressed: () {
              Navigator.pop(context);
              //Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      drawer: AppDrawer(context),
      body: FutureBuilder<List<User>>(
          future: fetchUserList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  //shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        tileColor: Theme.of(context).secondaryHeaderColor,
                        leading: SizedBox(
                            width: 60,
                            child: Row(
                              children: [
                                const Icon(Icons.badge),
                                Text('№:${snapshot.data!.elementAt(index).id.toString()}')
                              ],
                            )
                        ),
                        title: Text(snapshot.data!.elementAt(index).name),
                        subtitle: Text('email: ${snapshot.data!.elementAt(index).email}'),
                        trailing: const Icon(Icons.checklist_outlined),
                        shape: myListTileShape,
                        selected: index == currentIndex,
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                            currentUser = snapshot.data!.elementAt(index);
                            Navigator.pushNamed(context, '/user');
                          });
                        },
                      ),
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return Text('Ошибка загрузки ${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}