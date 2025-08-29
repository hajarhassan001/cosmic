import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/features/profile/data/remote/profile_firebase.dart';
import 'package:cosmic/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;

    return BlocProvider(
      create: (_) => ProfileCubit(ProfileService())..loadProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final name = state is ProfileLoaded ? state.name : "";

          return Scaffold(
            body: Stack(
              children: [
                SizedBox.expand(
                  child: Image.asset("assets/images/BG.png", fit: BoxFit.cover),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(width * 16 / 375),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Spacer(),
                            Text("My Profile", style: AppTextStyles.h2bold24),
                            const Spacer(),
                            const SizedBox(width: 40),
                          ],
                        ),
                        SizedBox(height: height * 40 / 812),
                        Container(
                          padding: EdgeInsets.all(width * 16 / 375),
                          decoration: BoxDecoration(
                            color: AppColor.surface.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColor.surface),
                          ),
                          child: Column(
                            children: [
                              Text("Hi,", style: AppTextStyles.h2bold24),
                              if (state is ProfileLoading)
                                const CircularProgressIndicator()
                              else if (state is ProfileError)
                                Text(
                                  state.message,
                                  style: AppTextStyles.bady12.copyWith(
                                    color: Colors.red,
                                  ),
                                )
                              else ...[
                                Text(
                                  name,
                                  style: AppTextStyles.h1bold32.copyWith(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                SizedBox(height: height * 4 / 812),
                              ],
                              SizedBox(height: height * 16 / 812),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () => _showEditDialog(context, name),
                                child: Text(
                                  "Edit Name",
                                  style: AppTextStyles.h3bold18.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, String oldName) {
    final controller = TextEditingController(text: oldName);
    final cubit = context.read<ProfileCubit>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("Edit Name", style: AppTextStyles.h2bold24),
        content: TextField(
          controller: controller,
          style: AppTextStyles.bady12,
          decoration: InputDecoration(
            hintText: "Enter new name",
            filled: true,
            fillColor: AppColor.surface.withOpacity(0.3),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: AppTextStyles.bady12),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) cubit.updateName(newName);
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: AppTextStyles.bady12.copyWith(
                color: AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
