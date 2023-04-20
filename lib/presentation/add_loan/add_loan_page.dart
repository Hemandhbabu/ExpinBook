import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/loan.dart';
import '../core_package/core_widget.dart';
import 'add_loan_provider.dart';
import 'components/color_card.dart';
import 'components/date_card.dart';
import 'components/description_card.dart';
import 'components/icon_card.dart';
import 'components/interest_card.dart';
import 'components/name_card.dart';

class AddLoanPage extends StatelessWidget {
  static const route = 'add-loan-page';
  final Loan? loan;
  const AddLoanPage({
    super.key,
    required this.loan,
  });

  List<Override> buildOverrides() {
    final loan = this.loan;
    if (loan == null) return [];
    return [
      AddLoanProvider.nameProvider.overrideWith((ref) => loan.name),
      AddLoanProvider.iconProvider.overrideWith((ref) => loan.icon),
      AddLoanProvider.symbolProvider.overrideWith((ref) => loan.symbol),
      AddLoanProvider.interestProvider.overrideWith((ref) => loan.interest),
      AddLoanProvider.dateProvider.overrideWith((ref) => loan.dateTime),
      AddLoanProvider.colorProvider.overrideWith((ref) => loan.color),
      AddLoanProvider.descriptionProvider
          .overrideWith((ref) => loan.description ?? ''),
      AddLoanProvider.validatorProvider.overrideWith(AddLoanProvider.validator),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: buildOverrides(),
      child: Scaffold(
        appBar: CustomAppBar.elevated(
          provider: AddLoanProvider.elevatedProvider,
          title: '${loan == null ? 'Add' : 'Edit'} loan',
          actions: [
            if (loan != null)
              Consumer(
                builder: (context, ref, child) => IconButton(
                  onPressed: () => AddLoanProvider.delete(
                    context,
                    ref.read,
                    loan!,
                  ).then(
                    (value) => value == true ? Navigator.pop(context) : null,
                  ),
                  color: Colors.red,
                  icon: const Icon(Icons.delete_rounded),
                ),
              ),
            Consumer(
              builder: (context, ref, child) {
                final valid = ref.watch(
                  AddLoanProvider.validatorProvider(loan),
                );
                return IconButton(
                  onPressed: valid
                      ? () => AddLoanProvider.save(
                            context,
                            ref.read,
                            loan?.id ?? -1,
                          )
                      : null,
                  icon: const Icon(Icons.save_rounded),
                );
              },
            ),
          ],
        ),
        body: ScrollNotificationWrapper(
          provider: AddLoanProvider.elevatedProvider,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            children: [
              const DateCard(),
              const SizedBox(height: 12),
              const NameCard(),
              const SizedBox(height: 12),
              const InterestCard(),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(child: IconCard()),
                  Expanded(child: ColorCard()),
                ],
              ),
              const SizedBox(height: 12),
              const DescriptionCard(),
            ],
          ),
        ),
      ),
    );
  }
}
