import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/features/auth/widgets/custoum_button.dart';
import 'package:cosmic/features/auth/widgets/custoum_filed.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
    TextEditingController emailcontroler=TextEditingController();
    TextEditingController passwordcontroler=TextEditingController();

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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                Text('Sign in', style: AppTextStyles.h1bold32),
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
                Text('Forgot password?', style: AppTextStyles.h4bold18),
                SizedBox(height: height * 20 / 812),
                GradientButton(
                  text: 'Sign in',
                  colors: [
                    AppColor.buttonColor1,
                    AppColor.buttonColor2,
                    AppColor.primaryColor,
                  ],
                  onPressed: () {},
                ),
                Spacer(), 
              ],
            ),
          
        ],
      ),
    );
  }
}