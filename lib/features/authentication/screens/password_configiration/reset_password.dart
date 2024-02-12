import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../utils/constants/sizes.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [IconButton(onPressed: (){Get.back();},icon: const Icon(CupertinoIcons.clear),)  ],),body: const SingleChildScrollView(child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),child: Column(children: [


    ],),),),);
  }
}
