import 'dart:io';

import 'package:b/controller/data_provider.dart';
import 'package:b/controller/home_provider.dart';
import 'package:b/model/data_model.dart';
import 'package:b/view/widget/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddingDialogue extends StatelessWidget {
  AddingDialogue({super.key});

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: AlertDialog(
        title: const Text('Add Item'),
        content: SingleChildScrollView(
          child: Consumer<HomeProviders>(
            builder: (context, provider, child) => Column(
              children: [
                FutureBuilder<File?>(
                  future:
                      Future.value(Provider.of<HomeProviders>(context).file),
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      backgroundImage: snapshot.data != null
                          ? FileImage(snapshot.data!)
                          : null,
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
                        Provider.of<HomeProviders>(context, listen: false)
                            .getCam(ImageSource.camera);
                      },
                      child: const Text('Camera'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<HomeProviders>(context, listen: false)
                            .getCam(ImageSource.gallery);
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
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              addData(context);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  addData(BuildContext context) async {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final pro = Provider.of<HomeProviders>(context, listen: false);
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final group = pro.selectedGroups;
    await provider.imageAdder(File(pro.file!.path));

    final data = DataModel(
      name: name,
      age: age,
      number: phone,
      group: group,
      image: provider.downloadurl,
    );
    provider.addDonor(data);
    pro.file = null;
  }
}
