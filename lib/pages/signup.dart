import 'package:flutter/material.dart';
import 'package:mockshop/components/advance_button.dart';
import 'package:mockshop/components/form_text_field.dart';
import 'package:mockshop/components/form_text_field_with_icon.dart';
import 'package:mockshop/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  late SharedPreferences prefs;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  var hidePassword = true;
  String errorText = '';
  var fails = false;

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

  void signup() async {
    String accountType;
    bool isEmailValid = RegExp(
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
    ).hasMatch(emailController.text);
    if (tabController.index == 0) {
      accountType = 'C';
    } else {
      accountType = 'V';
    }
    if (emailController.text == '' ||
        passwordController.text == '' ||
        usernameController.text == '' ||
        nameController.text == '') {
      setState(() {
        fails = true;
        errorText = 'Please fill all fields';
      });
      return;
    } else if (!isEmailValid) {
      setState(() {
        fails = true;
        errorText = 'Please enter a valid email address';
      });
      return;
    } else {
      setState(() {
        fails = false;
      });
    }
    var data = {
      "fullname": nameController.text,
      "username": usernameController.text,
      "password": passwordController.text,
      "email": emailController.text,
      "accounttype": accountType,
    };
    try {
      var token = await Api.createuser(data);
      if (!context.mounted) return;
      if (token != null && (token != 'error')) {
        if (token == 'exists') {
          setState(() {
            fails = true;
            errorText = 'The Username or Email already exists!';
          });
          return;
        }
        Navigator.pop(context);
        prefs.setString('token', token);
        if (!context.mounted) return;
        if (accountType == 'C') {
          Navigator.pushNamed(context, '/products_page', arguments: token);
        } else {
          Navigator.pushNamed(context, '/manage_products', arguments: token);
        }
      }
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  void changeToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

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
                  hintText: 'Name',
                  obscureText: false,
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                FormTextField(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
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
                const SizedBox(height: 7),
                if (fails)
                  Text(
                    errorText,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 7),
                AdvanceButton(
                    displayText: "Sign Up", onPressed: () => signup()),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text("Already have an account?",
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
                    displayText: "Log In",
                    onPressed: () => changeToLogin(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
