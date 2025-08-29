import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerPart extends StatelessWidget {
  const DrawerPart({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;

    final width = size.width;

    return Drawer(
      backgroundColor: AppColor.surface.withOpacity(0.7),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColor.surface.withOpacity(0.2)),
            child: Center(
              child: Text("Settings", style: AppTextStyles.h2bold24),
            ),
          ),

          ListTile(
            leading: Icon(
              Icons.email_outlined,
              color: AppColor.primaryColor,
              size: width * 24 / 375,
            ),
            title: Text("Contact Us", style: AppTextStyles.h3bold18),
            subtitle: Text(
              "Reach us for feedback or questions",
              style: AppTextStyles.bady12,
            ),

            onTap: () async {
              final Uri emailUri = Uri.parse(
                "https://mail.google.com/mail/?view=cm&fs=1&to=hajarhassan001@gmail.com",
              );

              if (await canLaunchUrl(emailUri)) {
                await launchUrl(emailUri, mode: LaunchMode.externalApplication);
              } else {
                print("Could not launch Gmail");
              }
            },
          ),

          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: AppColor.primaryColor,
              size: width * 24 / 375,
            ),
            title: Text("About App", style: AppTextStyles.h3bold18),
            subtitle: Text(
              "Learn more about Cosmic",
              style: AppTextStyles.bady12,
            ),
            onTap: () {
              Navigator.pop(context);
              Future.delayed(Duration.zero, () {
                if (!context.mounted) return;
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColor.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 12 / 375),
                    ),
                    title: Text("About Cosmic", style: AppTextStyles.h2bold24),
                    content: Text(
                      "Cosmic is an educational app that helps you explore planets and galaxies with fun facts and visuals.",
                      style: AppTextStyles.bady12,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(
                          "Close",
                          style: AppTextStyles.bady12.copyWith(
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          ),

          ListTile(
            leading: Icon(
              Icons.star_border,
              color: AppColor.primaryColor,
              size: width * 24 / 375,
            ),
            title: Text("Rate App", style: AppTextStyles.h3bold18),
            subtitle: Text(
              "Give us your feedback",
              style: AppTextStyles.bady12,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(
              Icons.logout,
              color: AppColor.primaryColor,
              size: width * 24 / 375,
            ),
            title: Text("Sign Out", style: AppTextStyles.h3bold18),
            subtitle: Text(
              "Log out from your account",
              style: AppTextStyles.bady12,
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, Routes.loginScreen);
            },
          ),
        ],
      ),
    );
  }
}
