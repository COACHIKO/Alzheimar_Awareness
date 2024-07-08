import 'package:alzaware/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:alzaware/view/screens/app_wide_widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/utils/constants/text_strings.dart';
import '../../core/utils/helpers/helper_functions.dart';
import 'normal_user_area/detect_alzheimar.dart';

class DiagnosisHistory extends StatelessWidget {
  const DiagnosisHistory({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    final AlzheimarDetectionController controller =
        Get.put(AlzheimarDetectionController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          showBackArrow: false,
          title: TTexts.diagnosisHistory,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.selectedImages.length,
        itemExtent: 110,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var dateTime = controller.selectedImages[index].dateTime;
          var formattedDateTime =
              DateFormat('E-dd-MM-yyyy hh:mm a').format(dateTime);
          return Card(
            color: TColors.primary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text("${TTexts.diagnosis} ${index + 1}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: dark ? TColors.light : TColors.dark))),
                  const SizedBox(height: 10),
                  Text(
                    "${TTexts.diagnosisDate}: $formattedDateTime",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: dark ? TColors.light : TColors.dark),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        controller.selectedImages[index].randomNum,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: dark ? TColors.light : TColors.dark),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
