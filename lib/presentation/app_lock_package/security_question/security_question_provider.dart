import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../preference_provider.dart';

class SecurityQuestionProvider {
  const SecurityQuestionProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);
  static final questionProvider = StateProvider.autoDispose((ref) => 0);
  static final answerProvider = StateProvider.autoDispose((ref) => '');
  static final validatorProvider = Provider.autoDispose.family(validator);

  static bool validator(AutoDisposeProviderRef ref, bool verify) {
    if (verify) return true;
    final answer = ref.watch(answerProvider);
    final question = ref.read(questionProvider);
    final toVerifyAnswer = ref.watch(securityAnswerPreferencesProvider);
    final toVerifyQuestion = ref.read(securityQuestionPreferencesProvider);
    return answer.length >= 4 &&
        (answer != toVerifyAnswer || question != toVerifyQuestion);
  }

  static void save(BuildContext context,
      T Function<T>(ProviderListenable<T> provider) read, bool verify) {
    final question = read(questionProvider);
    final answer = read(answerProvider);
    if (verify) {
      final toVerifyQuestion = read(securityQuestionPreferencesProvider);
      final toVerifyAnswer = read(securityAnswerPreferencesProvider);

      if (question == toVerifyQuestion && answer == toVerifyAnswer) {
        Navigator.pop(context, true);
        return;
      }
      final snackbar = ScaffoldMessenger.of(context);
      snackbar.removeCurrentSnackBar();
      if (question != toVerifyQuestion) {
        snackbar.showSnackBar(const SnackBar(content: Text('Wrong question')));
      } else {
        snackbar.showSnackBar(const SnackBar(content: Text('Wrong answer')));
      }
    } else {
      read(securityQuestionPreferencesProvider.notifier).setInt(question);
      read(securityAnswerPreferencesProvider.notifier).setString(answer);
      Navigator.pop(context, true);
    }
  }
}
