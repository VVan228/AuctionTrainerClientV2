import 'package:auction_trainer_client_v2/inject_config/DependenciesConfiguration.dart';
import 'package:auction_trainer_client_v2/pages/login/api/LoginPresenter.dart';
import 'package:auction_trainer_client_v2/pages/main/impl/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/SignInView.dart';
import '../api/SignUpView.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<LoginPage> {
  bool logging = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              logging
                  ? const Card(child: SignInForm())
                  : const Card(child: SignUpForm()),
              const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        disabledTextColor: Theme.of(context).primaryColor,
                        onPressed: logging
                            ? null
                            : () {
                                setState(() {
                                  logging = !logging;
                                });
                              },
                        child: const Text("Sign in")),
                    Text(
                      "/",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    MaterialButton(
                        disabledTextColor: Theme.of(context).primaryColor,
                        onPressed: logging
                            ? () {
                                setState(() {
                                  logging = !logging;
                                });
                              }
                            : null,
                        child: const Text("Sign up"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> implements SignInView {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? passwordError;
  String? emailError;
  String? globalError;
  bool loading = false;
  LoginPresenter presenter = getIt<LoginPresenter>();

  void clearErrors() {
    setState(() {
      passwordError = null;
      emailError = null;
      globalError = null;
    });
  }

  @override
  void initState() {
    super.initState();
    presenter.setSignInView(this);
    clearErrors();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Text('Sign in',
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("email"),
                    ),
                    controller: _emailController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: emailError != null
                        ? Text(
                            emailError!,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const Text(""),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    label: Text("password"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: passwordError != null
                      ? Text(
                          passwordError!,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const Text(""),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: globalError != null
                    ? Text(
                        globalError!,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const Text(""),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text(""),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8),
                child: FilledButton(
                  onPressed: () {
                    clearErrors();
                    presenter.login(
                        _passwordController.text, _emailController.text);
                  },
                  child: const Text("Sign in"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void showEmailError(String? error) {
    setState(() {
      emailError = error;
    });
  }

  @override
  void showGlobalError(String? error) {
    setState(() {
      globalError = error;
    });
  }

  @override
  void showPasswordError(String? error) {
    setState(() {
      passwordError = error;
    });
  }

  @override
  void openMainPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  void hideLoading() {
    setState(() {
      loading = false;
    });
  }

  @override
  void showLoading() {
    setState(() {
      loading = true;
    });
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> implements SignUpView {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  String? passwordError;
  String? emailError;
  String? usernameError;
  String? globalError;
  bool loading = false;
  LoginPresenter presenter = getIt<LoginPresenter>();

  void clearErrors() {
    setState(() {
      passwordError = null;
      emailError = null;
      usernameError = null;
      globalError = null;
    });
  }

  @override
  void initState() {
    super.initState();
    presenter.setSignUpView(this);
    clearErrors();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Sign up',
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text("email"),
              ),
              controller: _emailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: emailError != null
                ? Text(
                    emailError!,
                    style: const TextStyle(color: Colors.red),
                  )
                : const Text(""),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text("username"),
              ),
              controller: _usernameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: usernameError != null
                ? Text(
                    usernameError!,
                    style: const TextStyle(color: Colors.red),
                  )
                : const Text(""),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                label: Text("password"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: passwordError != null
                ? Text(
                    passwordError!,
                    style: const TextStyle(color: Colors.red),
                  )
                : const Text(""),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: globalError != null
                    ? Text(
                        globalError!,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const Text(""),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text(""),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8),
                child: FilledButton(
                  onPressed: () {
                    clearErrors();
                    presenter.register(_passwordController.text,
                        _emailController.text, _usernameController.text);
                  },
                  child: const Text("Sign up"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void hideLoading() {
    setState(() {
      loading = false;
    });
  }

  @override
  void openMainPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  void showEmailError(String? error) {
    setState(() {
      emailError = error;
    });
  }

  @override
  void showGlobalError(String? error) {
    setState(() {
      globalError = error;
    });
  }

  @override
  void showLoading() {
    setState(() {
      loading = true;
    });
  }

  @override
  void showPasswordError(String? error) {
    setState(() {
      passwordError = error;
    });
  }

  @override
  void showUsernameError(String? error) {
    setState(() {
      usernameError = error;
    });
  }
}
