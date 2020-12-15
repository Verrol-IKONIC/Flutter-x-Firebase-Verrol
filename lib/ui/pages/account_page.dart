part of 'pages.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isLoading = false;
  String name, email, profilePic;

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseImage() async {
    final selectedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = selectedImage;
    });
  }

  void fetchUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      name = value.data()['name'];
      email = value.data()['email'];
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .listen((event) {
      profilePic = event.data()['profilePicture'];
      if (profilePic == "") {
        profilePic = null;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.lime[300],
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(children: [
        Container(
            margin: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 100),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: NetworkImage(profilePic ??
                        "https://cdn.onlinewebfonts.com/svg/img_568656.png")),
                SizedBox(
                  height: 40,
                ),
                RaisedButton.icon(
                    onPressed: () async {
                      await chooseImage();
                      setState(() {
                        isLoading = true;
                      });
                      await UserServices.updateProfilePic(
                              FirebaseAuth.instance.currentUser.uid, imageFile)
                          .then((value) {
                        if (value) {
                          Fluttertoast.showToast(
                              msg: "Update Profile Successfull",
                              backgroundColor: Colors.lime[300],
                              textColor: Colors.black,
                              toastLength: Toast.LENGTH_LONG);
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Update Profile Failed",
                              backgroundColor: Colors.red[300],
                              textColor: Colors.black,
                              toastLength: Toast.LENGTH_LONG);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      });
                    },
                    label: Text("Edit photo"),
                    icon: Icon(Icons.camera_alt),
                    color: Colors.lime[300],
                    padding: EdgeInsets.all(8),
                    textColor: Colors.black),
                SizedBox(
                  height: 20,
                ),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(email)
              ],
            )),
        Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Sign Out Confirmation"),
                          content: Text("Are you sure to sign out?"),
                          actions: [
                            FlatButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await AuthServices.signOut().then((value) {
                                  if (value == true) {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignInPage();
                                    }));
                                  } else {
                                    isLoading = false;
                                  }
                                });
                              },
                              child: Text("Yes",
                                  style: TextStyle(color: Colors.lime[600])),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No",
                                  style: TextStyle(color: Colors.lime[600])),
                            )
                          ],
                        );
                      });
                },
                padding: EdgeInsets.all(12),
                child: Text("Sign Out"),
                textColor: Colors.white,
                color: Colors.red[300],
              ),
            )),
        isLoading == true
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: SpinKitFadingCircle(
                  size: 50,
                  color: Colors.lime[300],
                ),
              )
            : Container()
      ]),
    );
  }
}
