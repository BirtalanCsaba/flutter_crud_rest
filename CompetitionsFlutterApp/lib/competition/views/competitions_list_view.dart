import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/competition_model.dart';

class CompetitionsList extends StatelessWidget {
  CompetitionsList(this.competitions, this.onEdit, this.onDelete);

  List<Competition> competitions;
  final void Function(int?) onEdit;
  final void Function(int?) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: competitions.length,
        itemBuilder: (context, index) {
          Competition item = competitions.elementAt(index);
          return ListTile(
              minVerticalPadding: 15,
              title: Text(item.title),
              tileColor: Colors.grey[300],
              leading: IconButton(onPressed: () {
                onEdit(item.id);
              }, icon: const Icon(Icons.edit)),
              trailing:
                IconButton(onPressed: () {
                  onDelete(item.id);
                }, icon: const Icon(Icons.remove_circle)),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(item.category),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.star),
                          Text(item.firstPlacePrize)
                        ])
                  ]));
        });
  }
}
