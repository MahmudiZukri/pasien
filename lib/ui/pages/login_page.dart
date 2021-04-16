part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final PreferredSizeWidget appBar = AppBar(
      centerTitle: true,
      title: Text(
        'Halaman Login',
        style: TextStyle(fontWeight: FontWeight.bold),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  CustomTextField(usernameController, 'Username'),
                  CustomTextField(passwordController, 'Password',
                      obscureText: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () {
                        if (usernameController.text == 'admin' &&
                            passwordController.text == 'adminpass') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => MainPage()));
                          Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Colors.green,
                              message: "Berhasil login sebagai Admin",
                              icon: Icon(Icons.check_box, color: Colors.white))
                            ..show(context);

                          usernameController.text = '';
                          passwordController.text = '';
                        } else {
                          Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Colors.red,
                              message: "Username / Password anda salah",
                              icon: Icon(Icons.delete, color: Colors.white))
                            ..show(context);
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height - 405),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => UserPage()));
                        },
                        child: Text(
                          'Lihat Data Pasien',
                          style: TextStyle(color: Colors.teal),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
