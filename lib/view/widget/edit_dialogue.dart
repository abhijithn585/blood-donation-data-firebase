import 'dart:io';
import 'package:b/controller/data_provider.dart';
import 'package:b/controller/home_provider.dart';
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: AlertDialog(
        title: const Text('Update Item'),
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
                    const SizedBox(
                      width: 35,
                    ),
                    TextButton(
                      onPressed: () {
                        provider.getCam(ImageSource.camera);
                      },
                      child: const Text('Camera'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        provider.getCam(ImageSource.gallery);
                        clicked = !clicked;
                      },
                      child: const Text('Gallery'),
                    ),
                  ],
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: 'Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                const DropDown()
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('save'),
            onPressed: () {
              update(context);
              Navigator.of(context).pop();
            },
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
