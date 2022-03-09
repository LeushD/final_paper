import 'package:flutter/material.dart';
import 'main.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Инфо'),
          actions: [
            ElevatedButton(
              child: const Text("Скрыть"),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.blueAccent,
              ),
              onPressed: () {
                _show = false;
                setState(() {

                });
              },),
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
        body: Column(
          children: [
            Center(
                child: Text(currentUser!.name, style: Theme
                    .of(context)
                    .textTheme
                    .headline4,)
            ),
            Center(
                child: Text(currentUser!.username, style: Theme
                    .of(context)
                    .textTheme
                    .headline5,)
            ),
            const Center(
                child: Divider(thickness: 2, indent: 22, endIndent: 22,)
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                tileColor: Theme
                    .of(context)
                    .secondaryHeaderColor,
                shape: myListTileShape,
                leading: const Icon(Icons.phone),
                title: Text(currentUser!.phone, style: Theme
                    .of(context)
                    .textTheme
                    .headline6,),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                tileColor: Theme
                    .of(context)
                    .secondaryHeaderColor,
                shape: myListTileShape,
                leading: const Icon(Icons.alternate_email),
                title: Text(currentUser!.email, style: Theme
                    .of(context)
                    .textTheme
                    .headline6,),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                tileColor: Theme
                    .of(context)
                    .secondaryHeaderColor,
                shape: myListTileShape,
                leading: const Icon(Icons.home),
                title: Text('city: ${currentUser!.address.city}\n'
                    'street: ${currentUser!.address.street}\n'
                    'suite: ${currentUser!.address.suite}\n'
                    'zipcode: ${currentUser!.address.zipcode}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,),
                trailing: Text('lng: ${currentUser!.address.geo.lng}\n'
                    'lat: ${currentUser!.address.geo.lat}\n',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2, bottom: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                tileColor: Theme
                    .of(context)
                    .secondaryHeaderColor,
                shape: myListTileShape,
                leading: const Icon(Icons.business_center),
                title: Text.rich(
                    TextSpan(
                        text: '${currentUser!.company.name}\n',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'catchPhrase: ${currentUser!.company
                                .catchPhrase}\n',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                          ),
                          TextSpan(
                            text: 'bs: ${currentUser!.company.bs}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                          )
                        ]
                    )
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _show = true;
                setState(() {

                });
              },
              child: const Text("Подробно"),
            )
          ],
        ),
        bottomSheet: _showBottomSheet()
    );
  }

  Widget? _showBottomSheet() {
    if (_show) {
      return BottomSheet(
        constraints: const BoxConstraints.tightFor(
            width: double.infinity, height: 250),
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        onClosing: () {},
        builder: (BuildContext context) {
          return FutureBuilder<List<UserTask>>(
              future: fetchUserTaskList(currentUser!.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          dense: true,
                          selectedTileColor: Theme
                              .of(context)
                              .secondaryHeaderColor,
                          selected: snapshot.data!.elementAt(index).completed
                              ? true
                              : false,
                          title: Text('task #${snapshot.data!
                              .elementAt(index)
                              .id}'),
                          subtitle: Text(snapshot.data!.elementAt(index).title),
                          value: snapshot.data!.elementAt(index).completed,
                          onChanged: (val) {},
                        );
                      }
                  );
                } else if (snapshot.hasError) {
                  return Text('Ошибка загрузки ${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              }
          );
        },

      );
    }
    else {
      return null;
    }
  }
}