import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanga_care/features/user_authentication/presentation/bloc/bloc.dart';
import 'package:kanga_care/screens/main_screen.dart';
import 'loginScreen.dart';
import '../../../../utils/helper.dart';
import '../../../../widgets/customTextInput.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUpScreen';
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _secondName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  Widget netWorkMessage = const Text('');

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            child:
                BlocListener<UserAuthenticationBloc, UserAuthenticationState>(
      listener: (context, state) => {
        if (state is Empty)
          {
            setState(() => {
                  widget.netWorkMessage = const Text('Empty'),
                })
          }
        else if (state is Loading)
          {
            setState(() => {
                  widget.netWorkMessage =
                      const CircularProgressIndicator.adaptive()
                })
          }
        else if (state is Loaded)
          {
            setState(() => {
                  widget.netWorkMessage = const Text('Success'),
                }),
            Navigator.of(context).pushNamed(MainScreen.routeName)
          }
        else if (state is Error)
          {
            setState(() => {
                  widget.netWorkMessage = Text(
                    state.errorMessage ?? 'Error',
                    style: const TextStyle(color: Colors.red),
                  ),
                })
          }
      },
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: ListView(
            children: [
              Center(
                child: Text(
                  "Sign Up",
                  style: Helper.getTheme(context).headline6,
                ),
              ),
              Container(
                height: Helper.getScreenHeight(context) * 0.02,
              ),
              const Center(
                child: Text(
                  "Add your details to sign up",
                ),
              ),
              Container(
                height: Helper.getScreenHeight(context) * 0.03,
              ),
              CustomTextInput(
                  hintText: "First Name", textController: widget._firstName),
              Container(
                height: Helper.getScreenHeight(context) * 0.02,
              ),
              CustomTextInput(
                hintText: "Second Name",
                textController: widget._secondName,
              ),
              Container(
                height: Helper.getScreenHeight(context) * 0.02,
              ),
              CustomTextInput(hintText: "Email", textController: widget._email),
              Container(
                height: Helper.getScreenHeight(context) * 0.02,
              ),
              CustomTextInput(
                  hintText: "Phone", textController: widget._phoneNumber),
              Container(
                height: Helper.getScreenHeight(context) * 0.02,
              ),
              CustomTextInput(
                hintText: "Password",
                textController: widget._password,
                hideText: true,
              ),
              Container(
                height: Helper.getScreenHeight(context) * 0.02,
              ),
              CustomTextInput(
                hintText: "Confirm Password",
                textController: widget._confirmPassword,
                hideText: true,
              ),
              Container(
                height: Helper.getScreenHeight(context) * 0.05,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget._firstName.text != "" &&
                        widget._secondName.text != "" &&
                        widget._email.text != "" &&
                        widget._phoneNumber.text != "" &&
                        widget._password.text != "" &&
                        widget._confirmPassword.text != "") {
                      if (widget._password.text ==
                          widget._confirmPassword.text) {
                        context.read<UserAuthenticationBloc>().add(
                            RegisterUserEvent(
                                userFirstName: widget._firstName.text,
                                userSecondName: widget._secondName.text,
                                userEmail: widget._email.text,
                                userTel: widget._phoneNumber.text,
                                dpImage: "",
                                password: widget._password.text));
                      } else {
                        setState(() => {
                              widget.netWorkMessage = const Text(
                                "Passwords don't match",
                                style: TextStyle(color: Colors.red),
                              ),
                            });
                      }
                    } else {
                      setState(() => {
                            widget.netWorkMessage = const Text(
                              'Fill All Fields!',
                              style: TextStyle(color: Colors.red),
                            ),
                          });
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: Helper.getScreenHeight(context) * 0.03,
              ),
              Center(child: widget.netWorkMessage),
              Container(
                height: Helper.getScreenHeight(context) * 0.03,
              ),
              Container(
                height: Helper.getScreenHeight(context) * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text("Already have an Account? "),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    )));
  }
}
