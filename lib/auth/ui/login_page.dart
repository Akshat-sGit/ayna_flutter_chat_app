import 'package:ayna/chat/ui/contacts_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utility/responsive.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ContactListScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Ayna Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isDesktop(context)
                            ? Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: CupertinoButton(
                                    color: CupertinoColors.systemBlue,
                                    borderRadius: BorderRadius.circular(25),
                                    onPressed: () {
                                      context
                                          .read<AuthBloc>()
                                          .add(GoogleSignInRequested());
                                    },
                                    child: state is AuthLoading
                                        ? const CupertinoActivityIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text("Sign in with Google"),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: CupertinoButton(
                                  color: CupertinoColors.systemBlue,
                                  borderRadius: BorderRadius.circular(25),
                                  onPressed: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(GoogleSignInRequested());
                                  },
                                  child: state is AuthLoading
                                      ? const CupertinoActivityIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text("Sign in with Google"),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
