// import "package:flutter/cupertino.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:myapp/pages/register_page.dart";
import "package:myapp/services/auth_service.dart";
// import "package:flutter/widgets.dart";
import "package:shadcn_ui/shadcn_ui.dart";

class LoginPage extends StatefulWidget {
  
  const LoginPage({super.key});
   @override
   State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
 bool obscure = true;
 String? _errorMessage;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


// redict to register page method
  _register() {
// navigate to register page
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  _submit(BuildContext context) async {
    AuthService authService = AuthService();

    try {
        UserCredential credentials = await authService.signIn(_emailController.text, _passwordController.text);

        if (credentials.credential == null) {
          setState(() {
            _errorMessage = "Error logging in";
          });
          return;
        }
    } catch (e) {
      setState(() {
        _errorMessage = authService.formatErrorMessage(e.toString());
      });
    }
  }
  
  @override
  Widget build(BuildContext context){
    final theme = ShadTheme.of(context);

    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login', style: theme.textTheme.h1),

          const SizedBox(height: 10),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              
              child: ShadInput(
                      placeholder: const Text('Email'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                ),
          ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              
              child: ShadInput(
     placeholder: const Text('Password'),
     controller: _passwordController,
     obscureText: obscure,
     prefix: const Padding(
       padding: EdgeInsets.all(4.0),
       child: ShadImage.square(size: 16, LucideIcons.lock),
     ),
     suffix: ShadButton(
       width: 24,
       height: 24,
       padding: EdgeInsets.zero,
       decoration: const ShadDecoration(
         secondaryBorder: ShadBorder.none,
         secondaryFocusedBorder: ShadBorder.none,
       ),
       icon: ShadImage.square(
         size: 16,
         obscure ? LucideIcons.eyeOff : LucideIcons.eye,
       ),
       onPressed: () {
         setState(() => obscure = !obscure);
       },
     ),
   )),
  const SizedBox(height: 10),
  ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              
              child: ShadButton(
    text: const Text('Login'),
    onPressed: () => _submit(context),
  )),
  const SizedBox(height: 10),
  // redirect to Register page if...
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Don\'t have an account?'),
      TextButton(
        onPressed: _register,
        child: const Text('Register'),
      ),
    ],
  ),
  const SizedBox(height: 25),
  _errorMessage != null ?  ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: ShadAlert.destructive(
                iconSrc: LucideIcons.circleAlert, 
                title: const Text('Error'), 
                description: Text(_errorMessage!)
                )): Container(),
        ],
      )),
      );

  }
}
