import 'package:flutter/material.dart';
import 'package:alzaware/view/screens/app_wide_widgets/custom_appbar.dart';
import '../../core/utils/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentQuestionIndex = 0;
  List<String> questions = [
    "Do you have difficulty remembering daily events?",
    "Do you feel lost in places you previously knew?",
    "Do you have trouble expressing your thoughts with appropriate words?",
    "Do you find it difficult to complete daily tasks like cooking or laundry?",
    "Have you noticed changes in your mood or general behavior?",
    "Do you struggle to concentrate or pay attention for long periods?",
    "Do you have difficulty recognizing family members or friends?",
    "Do you find it hard to do simple calculations or handle money?",
    "Do you feel like you frequently lose things?",
    "Do you have difficulty recognizing familiar people when you see them in different places?",
    "Do you feel increasingly confused or anxious in social situations?",
    "Have you noticed a significant decline in your work or study performance recently?",
    "Do you feel like simple things take longer for you to understand than before?",
    "Do you find it hard to coordinate between different activities in your life?",
    "Do you have difficulty recognizing items you need or want when shopping?",
    "Do you struggle to remember dates or important appointments?",
    "Do you feel confused when dealing with technology or electronic devices?",
    "Do you have difficulty understanding simple instructions or guidance?",
    "Do you feel like your social dialogue has significantly deteriorated?",
    "Do you feel like you waste time frequently?",
    "Do you have difficulty remembering people's names?",
    "Do you find it difficult to distinguish between similar things?",
    "Do you feel like you've lost interest in activities you used to enjoy?",
    "Do you have difficulty remembering where you placed personal belongings?",
    "Do you have trouble remembering details of stories or conversations that you repeat frequently?",
  ];
  List<bool?> answers = [];
  int? score;
  bool showScore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(showBackArrow: false, title: "Alzheimer Detection Survey"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("Normal Quiz",style: Theme.of(context).textTheme.bodyLarge,),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showScore = !showScore;
                      });
                    },
                    child: Icon(showScore? Icons.arrow_drop_down:Icons.arrow_right, color: Colors.white,size: 30,),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (!showScore)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        color: TColors.primary,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                questions[currentQuestionIndex],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        answers.add(true);
                                        _moveToNextQuestion();
                                      });
                                    },
                                    child: const Text("Yes"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        answers.add(false);
                                        _moveToNextQuestion();
                                      });
                                    },
                                    child: const Text("No"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (showScore && score != null)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        color: TColors.primary,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Your Score = $score",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                score! <= 5
                                    ? "Great news! Your memory seems to be doing well. Keep up the good work!"
                                    : (score! > 5 && score! < 10)
                                    ? "It looks like there might be some room for improvement in your memory. Try incorporating fun memory exercises into your daily routine."
                                    : (score! >= 10 && score! < 15)
                                    ? "Your memory score suggests some concerns. Consider talking to a healthcare professional for advice."
                                    : (score! >= 15 && score! < 20)
                                    ? "Your memory score indicates significant issues. It's a good idea to seek help from a healthcare provider."
                                    : "Your memory score indicates a high risk of memory-related issues. Seeking medical advice as soon as possible is important.",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _moveToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      int calculatedScore = _calculateScore();
      setState(() {
        score = calculatedScore;
        showScore = true;
      });
    }
  }

  int _calculateScore() {
    int score = answers.where((answer) => answer == true).length;
    return score;
  }
}

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    Key? key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.child,
    required this.backgroundColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor.withOpacity(0.1),
      ),
      child: child,
    );
  }
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const double curveHeight = 50;
    final double x = rect.width;
    final double y = rect.height;

    final path = Path()
      ..lineTo(0, y - curveHeight)
      ..quadraticBezierTo(0, y, curveHeight, y)
      ..lineTo(x - curveHeight, y)
      ..quadraticBezierTo(x, y, x, y - curveHeight)
      ..lineTo(x, 0)
      ..lineTo(0, 0);

    // Add circles
    const double circle1Radius = 20;
    final double circle1X = x - 250;
    const double circle1Y = curveHeight - 150;

    const double circle2Radius = 20;
    final double circle2X = x - 250;
    const double circle2Y = curveHeight - 100;

    path.addOval(Rect.fromCircle(center: Offset(circle1X, circle1Y), radius: circle1Radius));
    path.addOval(Rect.fromCircle(center: Offset(circle2X, circle2Y), radius: circle2Radius));

    return path;
  }
}
