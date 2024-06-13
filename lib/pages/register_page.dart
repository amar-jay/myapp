import 'package:flutter/material.dart';
import 'package:myapp/pages/chat_page.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:3223400663.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:20092009.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // email and password controller
  final TextEditingController _emailController = TextEditingController();
  bool obscure = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _errorMessage;
    toHome() {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage()));
    }

    _submit(BuildContext context) async {
      AuthService auth = AuthService();
      try {
        if (_passwordController.text != _confirmPasswordController.text) {
          _passwordController.clear();
          _confirmPasswordController.clear();
          setState(() {
            _errorMessage = 'Passwords do not match';
          });
          return;
        }
        await auth.register(_emailController.text, _passwordController.text);
        toHome();
      } catch (e) {
          setState(() {
            _errorMessage = auth.formatErrorMessage(e.toString());
          });
      }

      
    }
    _login() {
      return const RegisterPage();
    }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Register', style: theme.textTheme.h1),
          const SizedBox(height: 10),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              
              child: ShadInput(
                      placeholder: const Text('Email'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                ),
          ),
          const SizedBox(height: 10),
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
                  obscure == true ? LucideIcons.eyeOff : LucideIcons.eye,
                ),
                onPressed: () {
                  setState(() => obscure = !obscure);
       },
     ),
   )),
    ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320), 
              child: ShadInput(
              placeholder: const Text('Confirm Password'),
              controller: _confirmPasswordController,
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
            text: const Text('Register'),
            onPressed: () => _submit(context),
          )),
          // redirect to Register page if...
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account?'),
              TextButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
          // error 
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
