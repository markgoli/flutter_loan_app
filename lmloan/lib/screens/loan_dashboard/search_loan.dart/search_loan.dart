import 'package:lmloan/config/extensions.dart';
import 'package:lmloan/enums/enums.dart';
import 'package:lmloan/provider/loan/loan_provider.dart';
import 'package:lmloan/screens/loan_dashboard/local_widget/loan_info_card.dart';
import 'package:lmloan/shared/widgets/busy_overlay.dart';
import 'package:lmloan/styles/color.dart';
import 'package:lmloan/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchLoanScreen extends StatefulWidget {
  const SearchLoanScreen({super.key});

  @override
  State<SearchLoanScreen> createState() => _SearchLoanScreenState();
}

class _SearchLoanScreenState extends State<SearchLoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoanProviderImpl>(builder: (context, stateModel, child) {
      return BusyOverlay(
        show: stateModel.viewState == ViewState.Busy,
        title: stateModel.message,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Search Loan',
              style: AppTheme.headerStyle(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomTextField(
                  stateModel.searchLoanQueryController,
                  hint: 'Enter loan name',
                  password: false,
                  border: Border.all(color: greyColor),
                  onFieldSubmitted: (value) {
                    print(value);
                    if (value.isNotEmpty) {
                      stateModel.searchLoan();
                    }
                  },
                ),
                20.height(),
                if (stateModel.searchedLoan != null && stateModel.searchedLoan!.isEmpty)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      'No Loan Found',
                      style: AppTheme.headerStyle(color: primaryColor),
                    ),
                  ),
                if (stateModel.searchedLoan != null && stateModel.searchedLoan!.isNotEmpty)
                  Expanded(
                    child: GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                      children: List.generate(
                        stateModel.searchedLoan!.length,
                        (index) {
                          final data = stateModel.searchedLoan![index];
                          return LoanInfoCard(
                            onTap: () {
                              context.push('/view_loan?loan_id=${data.loanId}');
                            },
                            loanData: data,
                          );
                        },
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
