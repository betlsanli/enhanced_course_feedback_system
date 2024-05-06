import 'package:enhanced_course_feedback_system/constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async{
    // setState(() {
    //   isLoading = true;
    // });
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    try{
      await supabase.auth.signInWithPassword(
          email: emailController.text,
          password: passwordController.text,
      );
      Navigator.of(context).pushNamedAndRemoveUntil('/landing', (route) => false);

    }on AuthException catch(error){
      context.showErrorSnackBar(message: error.message);
    }catch(error){
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: formKey,
        child: Padding(
          padding: formPadding,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const Text(
                "Enchanced Course Feedback System",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
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
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    label: Text("Password")
                ),
                validator: (val){
                  if(val == null || val.isEmpty){
                    return "Required";
                  }
                  return null;
                },
              ),

              formSpacer,

              ElevatedButton(
                onPressed: signIn,
                child: const Text("S I G N  I N"),
              ),

            ],

          ),

        ),
      ),
    );
  }
}
