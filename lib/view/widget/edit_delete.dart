import 'package:b/controller/data_provider.dart';
import 'package:b/controller/home_provider.dart';
import 'package:b/model/data_model.dart';
import 'package:b/view/widget/edit_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDelete extends StatelessWidget {
  DataModel donators;
  String id;
  EditDelete({super.key, required this.donators, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditDialogue(
                    donators: donators,
                    id: id,
                  );
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
            onTap: () {
              Provider.of<DataProvider>(context, listen: false).deleteDonor(id);
              Provider.of<DataProvider>(context, listen: false)
                  .deleteImage(donators.image!);

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
