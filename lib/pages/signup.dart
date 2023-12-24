import 'package:flutter/material.dart';
import 'package:mockshop/components/advance_button.dart';
import 'package:mockshop/components/form_text_field.dart';
import 'package:mockshop/services/api.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void signup() {
    String accountType;
    if (tabController.index == 0) {
      accountType = 'C';
    } else {
      accountType = 'V';
    }
    var data = {
      "fullname": nameController.text,
      "username": usernameController.text,
      "password": passwordController.text,
      "email": emailController.text,
      "accounttype": accountType,
    };
    Api.createuser(data);
  }

  void changeToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/');
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
                FormTextField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
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
