import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core_package/core_widget.dart';
import 'components/app_lock_preference.dart';
import 'components/app_lock_timeout_preference.dart';
import 'components/backup_preference.dart';
import 'components/currency_preference.dart';
import 'components/daily_notification_time_preference.dart';
import 'components/excel_export_preference.dart';
import 'components/has_daily_notification_preference.dart';
import 'components/pdf_export_preference.dart';
import 'components/prompt_fingerprint_preference.dart';
import 'components/restore_preference.dart';
import 'components/security_question_preference.dart';
import 'components/show_savings_preference.dart';
import 'components/theme_preference.dart';
import 'components/use_fingerprint_preference.dart';
import 'components/user_name_preference.dart';

final _elevatedProvider = StateProvider.autoDispose((ref) => false);

class SettingsPage extends StatelessWidget {
  static const route = 'settings-page';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: _elevatedProvider,
        title: 'Settings',
      ),
      body: ScrollNotificationWrapper(
        provider: _elevatedProvider,
        child: ListView(
          children: const [
            TitleCard(title: 'General'),
            CurrencyPreference(),
            SizedBox(height: 8),
            UsernamePreference(),
            SizedBox(height: 8),
            ThemePreference(),
            SizedBox(height: 8),
            ShowSavingsPreference(),
            SizedBox(height: 8),
            TitleCard(title: 'App lock'),
            AppLockPreference(),
            UseFingerprintPreference(),
            PromptFingerprintPreference(),
            AppLockTimeoutPreference(),
            SecurityQuestionPreference(),
            SizedBox(height: 8),
            TitleCard(title: 'Reminder'),
            HasDailyNotificationPreference(),
            DailyNotificationTimePreference(),
            SizedBox(height: 8),
            TitleCard(title: 'Backup & Restore'),
            BackupPreference(),
            SizedBox(height: 8),
            RestorePreference(),
            SizedBox(height: 8),
            TitleCard(title: 'Export'),
            PdfExportPreference(),
            SizedBox(height: 8),
            ExcelExportPreference(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
