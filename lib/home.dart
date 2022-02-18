import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgo_test/editpage.dart';
import 'package:tgo_test/models.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorDataProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: provider.primary,
          centerTitle: true,
          title: Text(
            'TGO TEST',
            style: TextStyle(color: provider.text),
          ),
          actions: [
            IconButton(
              onPressed: () {
                (provider.isDarkMode)
                    ? provider.makeLightMode()
                    : provider.makeDarkMode();
              },
              icon: (provider.isDarkMode)
                  ? const Icon(Icons.light_mode_outlined)
                  : const Icon(Icons.dark_mode_outlined),
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: provider.secondary,
          child: Consumer<UserData>(builder: (context, userdata, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: provider.textColor,
                  ),
                  title: Text(
                    userdata.email ?? "",
                    style: TextStyle(
                      color: provider.textColor,
                      fontStyle: (userdata.email == "")
                          ? FontStyle.italic
                          : FontStyle.normal,
                      fontWeight: (userdata.email == "")
                          ? FontWeight.w400
                          : FontWeight.bold,
                    ),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    color: provider.textColor,
                  ),
                  title: Text(
                    userdata.name ?? "",
                    style: TextStyle(
                      color: provider.textColor,
                      fontStyle: (userdata.name == "")
                          ? FontStyle.italic
                          : FontStyle.normal,
                      fontWeight: (userdata.name == "")
                          ? FontWeight.w400
                          : FontWeight.bold,
                    ),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                ListTile(
                  leading: Icon(
                    Icons.school_outlined,
                    color: provider.textColor,
                  ),
                  title: Text(
                    (userdata.edu == "") ? "No Data" : userdata.edu ?? "",
                    style: TextStyle(
                      color: provider.textColor,
                      fontStyle: (userdata.edu == "")
                          ? FontStyle.italic
                          : FontStyle.normal,
                      fontWeight: (userdata.edu == "")
                          ? FontWeight.w400
                          : FontWeight.bold,
                    ),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                ListTile(
                  leading: Icon(
                    Icons.work_outline,
                    color: provider.textColor,
                  ),
                  title: Text(
                    (userdata.intern == "") ? "No Data" : userdata.intern ?? "",
                    style: TextStyle(
                      color: provider.textColor,
                      fontStyle: (userdata.intern == "")
                          ? FontStyle.italic
                          : FontStyle.normal,
                      fontWeight: (userdata.intern == "")
                          ? FontWeight.w400
                          : FontWeight.bold,
                    ),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                ListTile(
                  leading: Icon(
                    Icons.cake_outlined,
                    color: provider.textColor,
                  ),
                  title: Text(
                    (userdata.dob == "") ? "No Data" : userdata.dob ?? "",
                    style: TextStyle(
                      color: provider.textColor,
                      fontStyle: (userdata.dob == "")
                          ? FontStyle.italic
                          : FontStyle.normal,
                      fontWeight: (userdata.dob == "")
                          ? FontWeight.w400
                          : FontWeight.bold,
                    ),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 250.0),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: provider.primary),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return EditDataPage();
                      }),
                    ).then((value) {
                      //after pop
                      userdata = context.read<UserData>();
                      print(value.toString());
                    });
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Data"),
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
