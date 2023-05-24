import "package:datn/providers/app_state.dart";
import "package:email_validator/email_validator.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:loader_overlay/loader_overlay.dart";
import "package:provider/provider.dart";

import "../../common/alert_dialog.dart";
import "sign_up_screen.dart";

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String id = "sign_in_screen";
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool _isShowPassword = false;
  bool _isFormSubmit = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String,String> _formData = {};

  Future _onSignIn() async {
    setState(() {
      _isFormSubmit = true;
    });
    if(_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
       try {
        context.loaderOverlay.show();
        await context.read<AppState>().signInUser(_formData).then((value) {
          context.loaderOverlay.hide();
          Navigator.of(context).pop();
        });
      } catch (e) {
        context.loaderOverlay.hide();
        showAlertDialog(context, title: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Đăng nhập để tiếp tục",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: _isFormSubmit ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          if(value == null || value.trim().isEmpty) {
                            return "Không để trống phần này";
                          }
                          if(!EmailValidator.validate(value.trim())) {
                            return "Email không đúng định dạng";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _formData["email"] = (newValue ?? "").trim();
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                         autovalidateMode: _isFormSubmit ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
                         keyboardType: TextInputType.visiblePassword,
                         obscureText: !_isShowPassword,
                         decoration: InputDecoration(
                          hintText: "Mật khẩu",
                          border: const OutlineInputBorder(),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isShowPassword = !_isShowPassword;
                              });
                            },
                            child:  Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                _isShowPassword ? "assets/icons/ic_show_password.svg"  : "assets/icons/ic_hide_password.svg",
                              ),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if(value == null || value.replaceAll(" ", "").isEmpty) {
                            return "Không bỏ trống phần này";
                          }
                          if(value.replaceAll(" ", "").length <6) {
                            return "Mật khẩu phải từ 6 ký tự";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _formData["password"] = (newValue ?? "").trim();
                        },
                      ),
                      const SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: _onSignIn,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(45)
                        ),
                        child: const Text("Đăng nhập")
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Chưa có tài khoản? "
                            ),
                            WidgetSpan(
                              alignment:PlaceholderAlignment.middle,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(SignUpScreen.id);
                                }, 
                                child: const Text(
                                  "Đăng ký"
                                )
                              )
                            )
                          ]
                        )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}