import 'package:flutter/material.dart';
import 'package:mockshop/components/advance_button.dart';
import 'package:mockshop/components/form_text_field.dart';
import 'package:mockshop/components/form_text_field_with_icon.dart';
import 'package:mockshop/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var incorrect = false;
  var hidePassword = true;
  late SharedPreferences prefs;

  late TabController tabController;
  void hideTrigger() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> signin(BuildContext context) async {
    String accountType = tabController.index == 0 ? "C" : "V";
    var token = await Api.getuser({
      'username': usernameController.text,
      'password': passwordController.text,
      'accounttype': accountType
    });
    if (token != null && token != "error") {
      prefs.setString('token', token);
      if (!context.mounted) return;
      Navigator.pop(context);
      if (accountType == 'C') {
        Navigator.pushNamed(context, '/products_page', arguments: token);
      } else {
        Navigator.pushNamed(context, '/manage_products', arguments: token);
      }
    } else {
      setState(() {
        incorrect = true;
      });
    }
  }

  void changeToSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/signup');
  }

  void forgotPassword() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'lib/assets/logo.png',
                ),
                const SizedBox(height: 20),
                Text("Welcome to MockShop!",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                    )),
                const SizedBox(height: 20),
                TabBar(
                  controller: tabController,
                  indicatorColor: Colors.black,
                  dividerColor: Colors.grey[400],
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[300],
                  tabs: const [
                    Tab(text: "Customer"),
                    Tab(text: "Vendor"),
                  ],
                ),
                const SizedBox(height: 20),
                FormTextField(
                  hintText: 'Username',
                  obscureText: false,
                  controller: usernameController,
                ),
                const SizedBox(height: 20),
                FormTextFieldWithIcon(
                  hideTrigger: () => hideTrigger(),
                  hintText: 'Password',
                  obscureText: hidePassword,
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                if (incorrect)
                  const Text(
                    "Incorrect Login information, try again!",
                    style: TextStyle(color: Colors.red),
                  ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: TextButton(
                      onPressed: () => forgotPassword(),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 20),
                AdvanceButton(
                    displayText: "Sign In", onPressed: () => signin(context)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text("Don't have an account yet?",
                        style: TextStyle(color: Colors.grey[700])),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[700],
                        thickness: 0.5,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                AdvanceButton(
                    displayText: "Sign Up",
                    onPressed: () => changeToSignUp(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
