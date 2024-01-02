import 'package:b/controller/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProviders>(
      builder: (context, provider, child) => DropdownButton<String?>(
          value: provider.selectedGroups,
          items: provider.bloodGroups.map((grp) {
            return DropdownMenuItem<String>(value: grp, child: Text(grp));
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              provider.dropdownValuechange(newValue);
            }
          }),
    );
  }
}
