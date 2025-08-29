import 'package:cosmic/features/notes/data/remote/notes_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cosmic/features/notes/presentation/cubit/notes_cubit.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? "guest";
    return BlocProvider(
      create: (context) => NotesCubit(NotesService(), userId)..loadNotes(),
      child: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is NotesLoaded) {
            final notes = state.notes;

            if (notes.isEmpty) {
              return const Center(
                child: Text(
                  "No notes yet",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    color: Colors.black.withOpacity(0.3),
                    child: ListTile(
                      title: Text(
                        note["planet"],
                        style: const TextStyle(color: Colors.cyan),
                      ),
                      subtitle: Text(
                        note["note"],
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          context.read<NotesCubit>().removeNote(note["id"]);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
