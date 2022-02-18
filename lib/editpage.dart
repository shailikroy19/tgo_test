import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgo_test/models.dart';

// ignore: must_be_immutable
class EditDataPage extends StatelessWidget {
  EditDataPage({Key? key}) : super(key: key);

  TextEditingController? nameCont = TextEditingController();
  TextEditingController? eduCont = TextEditingController();
  TextEditingController? intCont = TextEditingController();
  TextEditingController? dobCont = TextEditingController();

  Future<void> uploadData(
    BuildContext context,
    String? email,
    String? name,
    String? edu,
    String? intern,
    String? dob,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    context.read<UserData>().updateUserData(email!, name!, edu!, intern!, dob!);

    //COPY USER DATA TO FIRESTORE
    await users.doc(email).update({
      'name': name,
      'edu': edu,
      'intern': intern,
      'dob': dob,
    });
  }

  @override
  Widget build(BuildContext context) {
    UserData userdata = context.read<UserData>();
    nameCont?.text = userdata.name!;
    eduCont?.text = userdata.edu!;
    intCont?.text = userdata.intern!;
    dobCont?.text = DateTime.now().toString().substring(0, 10);

    return Consumer<ColorDataProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: provider.primary,
          centerTitle: true,
          title: Text(
            'Edit Data',
            style: TextStyle(color: provider.text),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: provider.secondary,
          child: Form(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10.0),
              child: Consumer<LoaderProvider>(
                builder: (context, loader, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: TextFormField(
                          controller: nameCont,
                          style: TextStyle(color: provider.text),
                          decoration: InputDecoration(
                            icon: Icon(Icons.person_outlined,
                                color: provider.text?.withOpacity(0.7)),
                            hintText: 'Enter Name',
                            hintStyle: TextStyle(
                                color: provider.text?.withOpacity(0.5)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: TextFormField(
                          controller: eduCont,
                          style: TextStyle(color: provider.text),
                          decoration: InputDecoration(
                            icon: Icon(Icons.school_outlined,
                                color: provider.text?.withOpacity(0.7)),
                            hintText: 'Enter Education',
                            hintStyle: TextStyle(
                                color: provider.text?.withOpacity(0.5)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: TextFormField(
                          controller: intCont,
                          style: TextStyle(color: provider.text),
                          decoration: InputDecoration(
                            icon: Icon(Icons.work_outline,
                                color: provider.text?.withOpacity(0.7)),
                            hintText: 'Enter Internship',
                            hintStyle: TextStyle(
                                color: provider.text?.withOpacity(0.5)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        children: [
                          Icon(Icons.cake_outlined, color: provider.text),
                          const SizedBox(width: 16.0),
                          Text(
                            "Select Date of Birth",
                            style: TextStyle(color: provider.text),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 40.0),
                        child: SizedBox(
                          height: 100.0,
                          child: CupertinoDatePicker(
                            backgroundColor: provider.secondary,
                            onDateTimeChanged: (val) {
                              dobCont?.text = val.toString().substring(0, 10);
                              // print(dobCont?.text);
                            },
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            dateOrder: DatePickerDateOrder.dmy,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      (loader.isLoading)
                          ? const CircularProgressIndicator()
                          : ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: provider.primary),
                              onPressed: () async {
                                loader.startLoading();
                                await uploadData(
                                  context,
                                  userdata.email,
                                  nameCont?.text,
                                  eduCont?.text,
                                  intCont?.text,
                                  dobCont?.text,
                                ).then((value) {
                                  loader.stopLoading();
                                  Navigator.of(context).pop();
                                }).onError((error, stackTrace) {
                                  // print("Error Occured: " + error.toString());
                                  loader.stopLoading();
                                });
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text("Update Data"),
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
