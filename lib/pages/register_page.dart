|1
55555565
      _auth.Register(_emailController.text, _passwordController.txt)
    }
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
                  obscure ? LucideIcons.eyeOff : LucideIcons.eye,
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
            onPressed: () {},
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
                ],
              )),
              );
  }
}
