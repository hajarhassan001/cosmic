import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotePart extends StatelessWidget {
  final String planetName;

  const AddNotePart({super.key, required this.planetName});

  @override
  Widget build(BuildContext context) {
    final width = context.media.size.width;
    final height = context.media.size.height;

    return GestureDetector(
      onTap: () {
        final noteController = TextEditingController();

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Add Note"),
            content: TextField(
              controller: noteController,
              decoration: const InputDecoration(
                hintText: "Write your note here...",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (noteController.text.isNotEmpty) {
                    context.read<NotesCubit>().addNote(
                      planetName,
                      noteController.text,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Note added successfully!")),
                    );
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: width * 146 / 375,
        height: height * 48 / 812,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0xff00E5E5).withOpacity(0.1),
              const Color(0xff72A5F2).withOpacity(0.5),
              const Color(0xffE961FF).withOpacity(0.7),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text("Add Note", style: AppTextStyles.h2bold24),
      ),
    );
  }
}
