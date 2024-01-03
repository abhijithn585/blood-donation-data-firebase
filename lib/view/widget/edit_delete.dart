import 'package:b/controller/data_provider.dart';
import 'package:b/model/data_model.dart';
import 'package:b/view/widget/edit_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditDelete extends StatelessWidget {
  DataModel donators;
  String id;
  EditDelete({super.key, required this.donators, required this.id});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
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
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
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
