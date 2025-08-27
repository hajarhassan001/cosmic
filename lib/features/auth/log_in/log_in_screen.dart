import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/features/auth/cubit/auth-logic.dart';
import 'package:cosmic/features/auth/cubit/auth_state.dart';
import 'package:cosmic/features/auth/widgets/custoum_button.dart';
import 'package:cosmic/features/auth/widgets/custoum_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BG.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
            if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
            );}
            else if (state is AuthSuccess){
            Navigator.pushReplacementNamed(context, Routes.mainScreen);
            }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Align(
                   alignment: Alignment.centerLeft,
                   child: Text('Sign in', style: AppTextStyles.h1bold32),
                    ),
                    SizedBox(height: height * 20 / 812),
                    CustoumFiled(
                      controller: emailcontroler,
                      label: 'Email',
                      obscureText: false,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                    ),
                    SizedBox(height: height * 20 / 812),
                    CustoumFiled(
                      controller: passwordcontroler,
                      label: 'Password',
                      obscureText: true,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                    ),
                    SizedBox(height: height * 20 / 812),
                
                    Align(
                    alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.signUpScreen);
                        },
                        child: Text(
                          'Don\'t have an account?, Sign up',
                          style: AppTextStyles.h3bold18,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 20 / 812),
                    GradientButton(
                      text: 'Sign in',
                      colors: [
                        AppColor.buttonColor1,
                        AppColor.buttonColor2,
                        AppColor.primaryColor,
                      ],
                      onPressed: () {
                        context.read<AuthCubit>().login(
                              emailcontroler.text,
                              passwordcontroler.text,
                        );
                      },
                    ),
                  ],
                ),
              );
            },

          

          ),
        ],
      ),
    );
  }
}
