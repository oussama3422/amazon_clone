import 'package:amazon_clone/features/widget/acount_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: [
              AcountButton(text: 'Your Orders', onTap: (){}),
              AcountButton(text: 'Turn Seller', onTap: (){}),
            ],
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              AcountButton(text: 'Log Out', onTap: (){}),
              AcountButton(text: 'Your Wish List', onTap: (){}),
            ],
            ),
        ],
    );
  }
}