import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'event_logger.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final email = TextEditingController();
  final password = TextEditingController();

  final auth = AuthService();

  bool loading = false;


  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
Future<void> registerUser() async {

  Future<void> registerUser() async {

  EventLogger.add(
    "Register Button Tapped",
  );


  final emailText =
      email.text.trim();

  final passwordText =
      password.text.trim();



  if (emailText.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Email is required",
        ),
      ),
    );

    return;
  }




  if (!RegExp(
    r'^[^@]+@[^@]+\.[^@]+',
  ).hasMatch(emailText)) {


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Enter a valid email",
        ),
      ),
    );


    return;

  }




  if (passwordText.isEmpty) {


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Password is required",
        ),
      ),
    );


    return;

  }




  if (passwordText.length < 6) {


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Password must be at least 6 characters",
        ),
      ),
    );


    return;

  }




  setState(() {

    loading = true;

  });




  final user = await auth.register(
    emailText,
    passwordText,
  );




  if (!mounted) return;




  setState(() {

    loading = false;

  });





  if (user != null &&
      user["success"] == true) {


    EventLogger.add(
      "User Registered Successfully",
    );



    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text(
              "Registration Successful",
            ),
      ),
    );



    Navigator.pop(context);



  } else {


    EventLogger.add(
      "Registration Failed",
    );



    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(
              user?["message"] ??
              "Registration Failed",
            ),
      ),
    );

  }

}

    final emailText = email.text.trim();
    final passwordText = password.text.trim();


    if (emailText.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email is required"),
        ),
      );

      return;
    }


    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
        .hasMatch(emailText)) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter a valid email"),
        ),
      );

      return;
    }


    if (passwordText.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password is required"),
        ),
      );

      return;
    }


    if (passwordText.length < 6) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password must be at least 6 characters",
          ),
        ),
      );

      return;
    }


    setState(() {
      loading = true;
    });


    final user = await auth.register(
      emailText,
      passwordText,
    );


    if (!mounted) return;


    setState(() {
      loading = false;
    });


    if (user != null && user["success"] == true) {

    EventLogger.add("User Registered Successfully");


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Registration Successful",
          ),
        ),
      );


      Navigator.pop(context);


    } else {

      EventLogger.add("Registration Failed");


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            user?["message"] ??
                "Registration Failed",
          ),
        ),
      );
    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),

      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
                        const Icon(
              Icons.person_add,
              size: 80,
              color: Color(0xFF6C63FF),
            ),


            const SizedBox(height: 20),


            TextField(
              controller: email,

              keyboardType:
                  TextInputType.emailAddress,

              textInputAction:
                  TextInputAction.next,

              decoration: InputDecoration(
                labelText: "Email",

                prefixIcon:
                    const Icon(Icons.email),

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),


            const SizedBox(height: 15),


            TextField(
              controller: password,

              obscureText: true,

              textInputAction:
                  TextInputAction.done,

              onSubmitted: (_) {
                registerUser();
              },


              decoration: InputDecoration(
                labelText: "Password",

                prefixIcon:
                    const Icon(Icons.lock),

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),


            const SizedBox(height: 25),


            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed:
                    loading ? null : registerUser,


                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(0xFF6C63FF),

                  foregroundColor:
                      Colors.white,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                ),


                child: Text(
                  loading
                      ? "Creating Account..."
                      : "Register",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}