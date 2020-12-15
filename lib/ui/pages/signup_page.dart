part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  void clearForm(){
    ctrlName.clear();
    ctrlEmail.clear();
    ctrlPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.lime[300],
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 25),
                      TextFormField(
                        controller: ctrlName,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          labelText: 'Full Name',
                          hintText: 'Write your full name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: ctrlEmail,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          labelText: 'Email',
                          hintText: 'Write your active email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: ctrlPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 40),
                      RaisedButton.icon(
                        onPressed: () async {
                          if (ctrlName.text == "" ||
                              ctrlEmail.text == "" ||
                              ctrlPassword.text == "") {
                            Fluttertoast.showToast(
                              msg: "Please Fill in all Fields!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red[300],
                              textColor: Colors.black,
                              fontSize: 16.0,
                            );
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            String result = await AuthServices.signUp(
                                ctrlEmail.text,
                                ctrlPassword.text,
                                ctrlName.text);
                            if (result == "success") {
                              Fluttertoast.showToast(
                                msg: "Sign Up Successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.lime[300],
                                textColor: Colors.black,
                                fontSize: 16.0,
                              );
                              setState(() {
                                isLoading = false;
                                clearForm();
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: result,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red[300],
                                textColor: Colors.black,
                                fontSize: 16.0,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        icon: Icon(Icons.file_upload),
                        label: Text("Sign Up"),
                        textColor: Colors.black,
                        color: Colors.lime[300],
                      ),
                      SizedBox(height: 25),
                      RichText(
                        text: TextSpan(
                            text: "Already registered? Sign in.",
                            style: TextStyle(color: Colors.black),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignInPage();
                                }));
                              }),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
