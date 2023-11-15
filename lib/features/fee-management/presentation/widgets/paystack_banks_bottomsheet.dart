import 'package:flutter/material.dart';

import '../../domain/enitites/paystack_bank.dart';

class PayStackBanksBottomSheet extends StatelessWidget {
  final List<PayStackBankEntity> payStackBanks;

  const PayStackBanksBottomSheet({Key? key, required this.payStackBanks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bankSearchCtrl = TextEditingController();
    PayStackBankEntity? selectedBank;
    final bankNameCtrl = TextEditingController();

    final searchFocusField = FocusNode();
    bool isClearFieldButtonVisible = false;

    List<PayStackBankEntity> tempPayStackBankList = [...payStackBanks];

    return SingleChildScrollView(
      child: StatefulBuilder(
        builder: (ctx, myState) => SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 50,
                margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                child: TextFormField(
                  controller: bankSearchCtrl,
                  focusNode: searchFocusField,
                  style: const TextStyle(fontSize: 18.0),
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.name,
                  onFieldSubmitted: (value) {
                    myState(() {
                      searchFocusField.unfocus();
                    });
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty && !isClearFieldButtonVisible) {
                      myState(() {
                        isClearFieldButtonVisible = true;
                      });
                    } else if (value.isEmpty && isClearFieldButtonVisible) {
                      myState(() {
                        isClearFieldButtonVisible = false;
                      });
                    }

                    List<PayStackBankEntity> newBankList = [];

                    if (value != "") {
                      for (PayStackBankEntity bank in tempPayStackBankList) {
                        if (bank.name!
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          newBankList.add(bank);
                        }
                      }
                    } else {
                      myState(() {
                        tempPayStackBankList = [...payStackBanks];
                      });
                    }

                    if (newBankList.isNotEmpty) {
                      myState(() {
                        tempPayStackBankList = [...newBankList];
                      });
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Search bank",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () {
                          bankSearchCtrl.text = "";

                          myState(() {
                            searchFocusField.unfocus();
                            isClearFieldButtonVisible = false;
                            tempPayStackBankList = [...payStackBanks];
                          });
                        },
                        splashRadius: 25.0,
                        icon: isClearFieldButtonVisible
                            ? const Icon(Icons.close)
                            : const SizedBox(),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
              const Divider(thickness: 1.5),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: tempPayStackBankList.length,
                    itemBuilder: (ctx, i) {
                      return ListTile(
                        title: Text(tempPayStackBankList[i].name!),
                        style: ListTileStyle.drawer,
                        onTap: () async {
                          selectedBank = tempPayStackBankList[i];

                          bankNameCtrl.text = tempPayStackBankList[i].name!;

                          Navigator.of(context).pop(selectedBank);
                        },
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
  }
}
