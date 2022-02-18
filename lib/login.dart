import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tgo_test/home.dart';
import 'package:tgo_test/models.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<UserCredential> signInWithGoogle() async {
    /// Trigger auth flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    /// Obtain auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    /// Create new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    /// Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> uploadData(
      BuildContext context, UserCredential loginData) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String? userEmail = loginData.user?.email.toString();
    String? userName = loginData.user?.displayName.toString();

    context
        .read<UserData>()
        .updateUserData(userEmail!, userName ?? "", "", "", "");
    //LOGIN AND COPY USER DATA TO FIRESTORE
    await users.doc(userEmail).set({'name': userName});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Center(
          child: Consumer<LoaderProvider>(
            builder: (ctx, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'TGO Flutter Assignment',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Developed By: Shailik Roy',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 90.0),
                  (provider.isLoading)
                      ? const CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 85.0),
                            SizedBox(
                              width: 41.0,
                              child: Image.network(
                                  "https://kgo.googleusercontent.com/profile_vrt_raw_bytes_1587515358_10512.png"),
                            ),
                            const SizedBox(width: 10.0),
                            ElevatedButton(
                              // style: ElevatedButton.styleFrom(
                              //     fixedSize: const Size(200.0, 70.0)),
                              onPressed: (provider.isLoading)
                                  ? null
                                  : () {
                                      provider.startLoading();
                                      signInWithGoogle().then((value) async {
                                        uploadData(context, value);
                                        //stop loader
                                        provider.stopLoading();
                                        //push the page
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            // ignore: prefer_const_constructors
                                            builder: (f) => HomePage(),
                                          ),
                                        );
                                      }).onError((error, stackTrace) {
                                        print(error.toString());
                                        provider.stopLoading();
                                      });
                                    },
                              // icon: (provider.isLoading)
                              //     ? const CircularProgressIndicator(color: Colors.white)
                              //     : const Icon(Icons.login_outlined),
                              child: (provider.isLoading)
                                  ? const Text('')
                                  : const Text('Sign In with Google'),
                            ),
                          ],
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
