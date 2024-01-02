import 'dart:io';
import 'package:b/controller/data_provider.dart';
import 'package:b/controller/home_provider.dart';
import 'package:b/helpers/textfield.dart';
import 'package:b/model/data_model.dart';
import 'package:b/view/widget/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditDialogue extends StatefulWidget {
  DataModel donators;
  String id;
  EditDialogue({super.key, required this.donators, required this.id});

  @override
  State<EditDialogue> createState() => _EditDialogueState();
}

class _EditDialogueState extends State<EditDialogue> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  bool clicked = true;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.donators.name);
    ageController = TextEditingController(text: widget.donators.age);
    phoneController = TextEditingController(text: widget.donators.number);
    groupController = TextEditingController(text: widget.donators.group);
    Provider.of<HomeProviders>(context, listen: false).file =
        File(widget.donators.image ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: AlertDialog(
        title: Text('Add Item'),
        content: SingleChildScrollView(
          child: Consumer<HomeProviders>(
            builder: (context, provider, child) => Column(
              children: [
                FutureBuilder<File?>(
                  future: Future.value(provider.file),
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      backgroundImage: !clicked
                          ? FileImage(File(provider.file!.path))
                          : NetworkImage(provider.file!.path) as ImageProvider,
                    );
                  },
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                    ),
                    TextButton(
                      onPressed: () {
                        provider.getCam(ImageSource.camera);
                      },
                      child: Text('Camera'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        provider.getCam(ImageSource.gallery);
                        clicked = !clicked;
                      },
                      child: Text('Gallery'),
                    ),
                  ],
                ),
                textFields(controller: nameController, text: 'Name'),
                textFields(controller: ageController, text: 'Age'),
                textFields(controller: phoneController, text: 'Mobile'),
                DropDown()
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('save'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void update(imageurl) async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final pro = Provider.of<HomeProviders>(context, listen: false);
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final group = pro.selectedGroups;
    await provider.imageUpdate(imageurl, File(pro.file!.path));

    final updated = DataModel(
      name: name,
      age: age,
      number: phone,
      group: group,
      image: provider.downloadurl,
    );
    provider.updateDonor(widget.id, updated);
  }
}
