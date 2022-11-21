import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/widget/acount_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: [
              AcountButton(
                text: 'Your Orders',
                onTap: (){}
                ),
              AcountButton(text: 'Turn Seller', onTap: (){}),
            ],
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              AcountButton(
                text: 'Log Out',
                onTap: ()=>AccountServices().logout(context)
              ),
              AcountButton(text: 'Your Wish List', onTap: (){}),
            ],
            ),
        ],
    );
  }
}