import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanga_care/features/user_authentication/presentation/bloc/bloc.dart';
import '../../../../screens/main_screen.dart';
import 'forgetPwScreen.dart';
import 'signUpScreen.dart';
import '../../../../utils/helper.dart';
import '../../../../widgets/customTextInput.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen";

  Widget netWorkMessage = const Text('');
  final TextEditingController phoneNumberOrEmail = TextEditingController();

  final TextEditingController password = TextEditingController();
  LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: BlocListener<UserAuthenticationBloc, UserAuthenticationState>(
          listener: (context, state) => {
            if (state is Empty)
              {
                setState(() {
                  widget.netWorkMessage = const Text('Empty');
                })
              }
            else if (state is Loading)
              {
                setState(() {
                  widget.netWorkMessage =
                      const CircularProgressIndicator.adaptive();
                })
              }
            else if (state is Loaded)
              {
                setState(() {
                  widget.netWorkMessage = const Text('Success');
                }),
                Navigator.of(context).pushNamed(MainScreen.routeName)
              }
            else if (state is Error)
              {
                setState(() {
                  widget.netWorkMessage = Text(
                    state.errorMessage ?? 'Error',
                    style: const TextStyle(color: Colors.red),
                  );
                })
              }
          },
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 30,
              ),
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: Helper.getTheme(context).headlineMedium,
                  ),
                  const Spacer(),
                  const Text('Add your details to login'),
                  const Spacer(),
                  CustomTextInput(
                    hintText: "Your email or Tel",
                    textController: widget.phoneNumberOrEmail,
                  ),
                  const Spacer(),
                  CustomTextInput(
                    hintText: "password",
                    textController: widget.password,
                    hideText: true,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.password.text != "" &&
                            widget.phoneNumberOrEmail.text != "") {
                          context.read<UserAuthenticationBloc>().add(LoginEvent(
                              userEmailOrTel: widget.phoneNumberOrEmail.text,
                              password: widget.password.text));
                        } else {
                          setState(() {
                            widget.netWorkMessage = const Text(
                              'Fill All Fields!',
                              style: TextStyle(color: Colors.red),
                            );
                          });
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  widget.netWorkMessage,
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ForgetPwScreen.routeName);
                    },
                    child: const Text("Forget your password?"),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text("Don't have an Account? "),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
