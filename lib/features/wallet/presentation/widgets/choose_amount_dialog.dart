import 'package:clearance_processing_system/core/utils/dimensions.dart';
import 'package:clearance_processing_system/features/fee-management/domain/enitites/requirement_entity.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';

import '../../../../general_widgets/spacing.dart';

class ChooseAmountDialog extends StatelessWidget {
  const ChooseAmountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amount = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * .4,
          padding: const EdgeInsets.symmetric(vertical: Dimensions.medium, horizontal: Dimensions.large),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
                child: Text(
                  "How much would you like to add?",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                ),
              ),
              const Spacing.xxLargeHeight(),

              TextFormField(
                controller: amount,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),

              const Spacing.xxLargeHeight(),

              //
              //.......................Button......................
              //
              Container(
                width: 500.0,
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Dimensions.medium))),
                        minimumSize:
                        MaterialStateProperty.all(const Size(500.0, 50.0))),
                    onPressed: () async {
                      Navigator.of(context).pop(amount.text);
                    },
                    child: const Text(
                      'Checkout',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
