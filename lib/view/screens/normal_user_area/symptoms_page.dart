import 'package:alzaware/view/screens/app_wide_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/text_strings.dart';

class SymptomsPage extends StatelessWidget {
  final List<Map<String, String>> symptoms = [
    {
      "name": "Memory loss".tr,
      "details":
          "Memory loss is the most common symptom of Alzheimer's disease. It may include forgetting important events or information; asking for the same information repeatedly; relying on memory aids or family members for tasks they used to handle themselves."
              .tr,
    },
    {
      "name": "Difficulty concentrating".tr,
      "details":
          "People with Alzheimer's may have difficulty focusing on tasks, following conversations or instructions, and may stop in the middle of tasks without completing them."
              .tr,
    },
    {
      "name": "Trouble performing familiar tasks".tr,
      "details":
          "Routine tasks may become challenging, such as getting lost while driving to a familiar location or forgetting the rules of a favorite game."
              .tr,
    },
    {
      "name": "Language problems".tr,
      "details":
          "People with Alzheimer's may have trouble finding the right words to express themselves, or they may stop in the middle of conversations and not know how to continue."
              .tr,
    },
    {
      "name": "Disorientation of time and place",
      "details":
          "People with Alzheimer's may lose track of dates, seasons, and the passage of time. They may also forget where they are or how they got there."
              .tr,
    },
    {
      "name": "Poor judgment".tr,
      "details":
          "People with Alzheimer's may exhibit poor judgment, such as giving large amounts of money to telemarketers or wearing inappropriate clothing for the weather."
              .tr,
    },
    {
      "name": "Mood changes".tr,
      "details":
          "Alzheimer's can cause changes in mood, including becoming depressed, anxious, confused, or suspicious."
              .tr,
    },
    {
      "name": "Trouble understanding visual images".tr,
      "details":
          "People with Alzheimer's may have difficulty interpreting visual images, which can affect their ability to read, judge distance, or determine color or contrast."
              .tr,
    },
    {
      "name": "Withdrawal from work or social activities".tr,
      "details":
          "People with Alzheimer's may begin to withdraw from work or social activities, as they find it increasingly difficult to engage in these activities."
              .tr,
    },
    {
      "name": "Changes in sleep patterns".tr,
      "details":
          "People with Alzheimer's may experience changes in their sleep patterns, including difficulty falling asleep, waking up frequently during the night, or sleeping during the day."
              .tr,
    },
    {
      "name": "Loss of interest in hobbies".tr,
      "details":
          "People with Alzheimer's may lose interest in activities or hobbies they used to enjoy, or they may have difficulty initiating or completing tasks."
              .tr,
    },
    {
      "name": "Misplacing things".tr,
      "details":
          "People with Alzheimer's may put things in unusual places and then be unable to find them. They may accuse others of stealing, especially as the disease progresses."
              .tr,
    },
    {
      "name": "Difficulty planning or solving problems".tr,
      "details":
          "People with Alzheimer's may have difficulty planning or solving problems. They may have trouble following a recipe or keeping track of monthly bills."
              .tr,
    },
    {
      "name": "Confusion about time or place".tr,
      "details":
          "People with Alzheimer's may become confused about the date, time, or location. They may forget how they got somewhere or how to get back home."
              .tr,
    },
    {
      "name":
          "Trouble understanding visual images and spatial relationships".tr,
      "details":
          "People with Alzheimer's may have difficulty understanding visual images or spatial relationships, which can make it hard for them to judge distances or see contrasts."
              .tr,
    },
    {
      "name": "New problems with words in speaking or writing".tr,
      "details":
          "People with Alzheimer's may have trouble following or joining a conversation. They may stop in the middle of a conversation and not know how to continue."
              .tr,
    },
    {
      "name": "Misplacing things and losing the ability to retrace steps".tr,
      "details":
          "People with Alzheimer's may put things in unusual places and then be unable to find them. They may also lose the ability to retrace their steps and find the lost item."
              .tr,
    },
    {
      "name": "Withdrawal from work or social activities".tr,
      "details":
          "People with Alzheimer's may begin to withdraw from work or social activities, as they find it increasingly difficult to engage in these activities."
              .tr,
    },
    {
      "name": "Changes in mood and personality".tr,
      "details":
          "Alzheimer's can cause changes in mood and personality, including becoming depressed, anxious, aggressive, or apathetic."
              .tr,
    },
    {
      "name": "Difficulty concentrating".tr,
      "details":
          "People with Alzheimer's may have difficulty focusing on tasks, following conversations or instructions, and may stop in the middle of tasks without completing them."
              .tr,
    },
    {
      "name": "Difficulty making decisions".tr,
      "details":
          "People with Alzheimer's may have difficulty making decisions, such as what to wear or what to eat, and may rely on others to make decisions for them."
              .tr,
    },
    {
      "name": "Changes in personality and mood".tr,
      "details":
          "Alzheimer's can cause changes in personality and mood, including becoming more withdrawn, suspicious, or disinhibited."
              .tr,
    },
  ];

  SymptomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: false,
        title: "Symptoms",
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              height: 55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: TColors.primary, // or any other color you prefer
              ),
              child: Center(
                child: Text(
                  symptoms[index]['name']!,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    title: Text(TTexts.symptomDetails),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TTexts.details,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(symptoms[index]['details']!),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(TTexts.close),
                      ),
                    ],
                  );
                },
              );
            },
            splashColor: Colors.black,
          );
        },
      ),
    );
  }
}
