import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cards.dart';
import 'profile.dart';
import 'viewprofile.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<Editprofile> {
  final _firestore = FirebaseFirestore.instance;
  bool showPassword = false;
  String? id = FirebaseAuth.instance.currentUser?.uid;
  final _auth = FirebaseAuth.instance;
  var userEmail = FirebaseAuth.instance.currentUser?.email;
  var userNAME = FirebaseAuth.instance.currentUser?.displayName;
  var userphone = FirebaseAuth.instance.currentUser?.phoneNumber;
  var newname = FirebaseAuth.instance.currentUser?.displayName;
  var newpass;
  var newphone;
  var newjob;
  var newaddress;
  var newskill;
  var newhoobie;
  var newtwitter;
  var newinsta;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 58,
              backgroundImage: const AssetImage("images/profile.png"),
              child: Stack(children: const [
                Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Color.fromARGB(179, 255, 255, 255),
                    child: Icon(
                      Icons.flip_camera_ios,
                      size: 20,
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 30),
            const Divider(
              thickness: 2,
              height: 40,
              color: Color.fromARGB(255, 250, 223, 103),
            ),
            const SizedBox(height: 30),
            buildTextField("Name", "$userNAME", false),
            buildTextField("Password", "", true),
            buildTextField("Phone", '', false),
            buildTextField("Address", '', false),
            buildTextField("Job Title", '', false),
            buildTextField("Skills", '', false),
            buildTextField("Hobbies", '', false),
            buildTextField("Twitter Account", '', false),
            buildTextField("Instagram Account", '', false),
            ElevatedButton(
              onPressed: () {
                updatefire(newphone, 'phone');
                updatefire(newjob, 'jobtitle');
                updatefire(newinsta, 'instagram');
                updatefire(newtwitter, 'job');
                updatefire(newaddress, 'address');
                updatefire(newskill, 'skills');
                updatefire(newhoobie, 'twitter');
                FirebaseAuth.instance.currentUser?.updateDisplayName(newname);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 7, 7, 7),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                    fontSize: 14, letterSpacing: 2.2, color: Colors.white),
              ),
            )
          ],
        )),
      ),
    );
  }

  void updatefire(var data, String type) {
    if (data != "" && data != null) {
      FirebaseFirestore.instance.collection("profile").doc("$id").update({
        '$type': data,
      });
    }
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        onSubmitted: (value) {
          if (labelText == 'Name' && value != '') {
            newname = value;
          }
          if (labelText == 'Password' && value != '') {
            newpass = value;
          }
          if (labelText == 'Phone' && value != '') {
            newphone = value;
          }
          if (labelText == 'Address' && value != '') {
            newaddress = value;
          }
          if (labelText == 'Job Title' && value != '') {
            newjob = value;
          }
          if (labelText == 'Skills' && value != '') {
            newskill = value;
          }
          if (labelText == 'Hobbies' && value != '') {
            newhoobie = value;
          }
          if (labelText == 'Twitter Account' && value != '') {
            newtwitter = value;
          }
          if (labelText == 'Instagram Account' && value != '') {
            newinsta = value;
          }
        },
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 250, 223, 103),
            ),
          ),
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Color.fromARGB(255, 5, 5, 5),
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
