import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/views/sign_up_page.dart';
import 'package:pokemon_library/views/views_common/password_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/repositories/user_repository.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _mailTextController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    final authController = ref.watch(authControllerProvider.notifier);

    return Material(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: Column(
            children: [
              AppBar(
                title: const Text("Login"),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: user != null
                          ? const Icon(Icons.person)
                          : const Icon(Icons.person_outline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              /// メールアドレス入力
              if (user == null)
                TextField(
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                  controller: _mailTextController,
                ),

              /// パスワード入力
              if (user == null)
                PasswordTextField(textEditingController: _passwordController),
              if (user != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("User ID (FirebathAuth): ${user.uid}"),
                ),
              if (user != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Login Email: ${user.email}"),
                ),
              if (user != null && user.providerData.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text("Login by: ${user.providerData.first.providerId}"),
                ),
              if (user != null && user.providerData.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                  Text("Email verified: ${user.emailVerified}"),
                ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  if (user != null) {
                    await authController.signOut();
                  } else {
                    await authController.signIn(
                      email: _mailTextController.text,
                      password: _passwordController.text,
                    );
                  }
                },
                child:
                    user != null ? const Text("Log out") : const Text("Login"),
              ),
              const SizedBox(height: 50),
              if (user == null)
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => SignUpPage()));
                  },
                  child: const Text("アカウントが無い方はこちらから"),
                ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  launchUrl(Uri.parse("https://hogehogehoga.auth.us-east-1.amazoncognito.com/oauth2/authorize?client_id=7ihbbu2mvi78efu0g57epsobpa&response_type=code&scope=email+openid+phone&redirect_uri=https%3A%2F%2Fpokomon-library.web.app"));
                },
                child: const Text("cognitoを用いたアカウント作成はこちら？"),
              ),
              const SizedBox(height: 50),
              if (user != null)
                ElevatedButton(
                  onPressed: () async {
                    await authController.deleteAccount();
                  },
                  child: const Text("delete account"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
