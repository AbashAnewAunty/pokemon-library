import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/models/repositories/user_repository.dart';
import 'package:pokemon_library/views/views_common/password_text_field.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);

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
                title: const Text("SignUp"),
                actions: [
                  GestureDetector(
                    onTap: () {},
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
              TextField(
                decoration: const InputDecoration(
                  label: Text('E-mail'),
                ),
                controller: _mailTextController,
              ),

              /// パスワード入力
              PasswordTextField(textEditingController: _passwordController),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  if (user != null) {
                    return;
                  }

                  await authController.signUp(
                    email: _mailTextController.text,
                    password: _passwordController.text,
                  );

                  await authController.verifyEmail();

                  await showDialog(
                    context: context,
                    builder: (_) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: AlertDialog(
                          content: Text(
                              "ご指定のアドレスに認証メールを送信しました。メール内に記載されているリンクから認証を完了させてください。"
                              "もしメールが届いていない場合、下のverification email をから認証メールを再送信してください"),
                        ),
                      );
                    },
                  );

                  await authController.signIn(
                    email: _mailTextController.text,
                    password: _passwordController.text,
                  );
                },
                child: Text(user != null ? "complete signup !" : "signUp"),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  await authController.verifyEmail();
                },
                child: const Text("email verification"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
