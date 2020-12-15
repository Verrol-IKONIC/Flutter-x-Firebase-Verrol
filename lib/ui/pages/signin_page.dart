part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign In", style: TextStyle(color: Colors.black)),
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
                          if (ctrlEmail.text == "" || ctrlPassword.text == "") {
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
                            String result = await AuthServices.signIn(
                                ctrlEmail.text, ctrlPassword.text);
                            if (result == "success") {
                              Fluttertoast.showToast(
                                msg: "Sign In Successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.lime[300],
                                textColor: Colors.black,
                                fontSize: 16.0,
                              );
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return MainMenu();
                              }));
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
                        icon: Icon(Icons.file_download),
                        label: Text("Sign In"),
                        textColor: Colors.black,
                        color: Colors.lime[300],
                      ),
                      SizedBox(height: 25),
                      RichText(
                        text: TextSpan(
                            text: "Not registered yet? Sign up.",
                            style: TextStyle(color: Colors.black),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignUpPage();
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
