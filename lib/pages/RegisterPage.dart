import 'package:flutter/material.dart';
import 'package:enhanced_course_feedback_system/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.isRegistering}) : super(key: key);

  static Route<void> route({bool isRegistering = false}) {
    return MaterialPageRoute(
      builder: (context) => RegisterPage(isRegistering: isRegistering),
    );
  }

  final bool isRegistering;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final formKey = GlobalKey<FormState>();
  final bool isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    final email = emailController.text;
    final password = passwordController.text;
    final name = nameController.text;
    try {
      await supabase.auth.signUp(
          email: email, password: password, data: {'name': name });
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/landing', (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: formKey,
        child: Padding(
          padding: formPadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "E C F S",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                formSpacer,
            
                const Text(
                  "R E G I S T E R",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            
                formSpacer,
            
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text("Email")
                  ),
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "Required";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
            
                formSpacer,
            
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "Required";
                    }
                    if(val.length > 64){
                      return "Max 64 characters long";
                    }
                    return null;
                  },
                ),
            
                formSpacer,
            
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text("Password"),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Required';
                    }
                    if (val.length < 6) {
                      return '6 characters minimum';
                    }
                    return null;
                  },
                ),
            
                formSpacer,
            
                TextFormField(
                  controller: confirmpasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text("Password"),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Required';
                    }
                    if (val != passwordController.text) {
                      return 'Not matching';
                    }
                    return null;
                  },
                ),
            
                formSpacer,
            
                ElevatedButton(
                    onPressed: signUp,
                    child: const Text("Register"),
                ),
            
            
              ], // children
            ),
          ),
        ),
      ),
    );
  }
}
