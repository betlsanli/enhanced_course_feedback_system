import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../data/RequestForm.dart';


class FeedbackSummaryPage extends StatelessWidget {
  const FeedbackSummaryPage({super.key, required this.feedbackSummary});

  final RequestForm feedbackSummary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            expandedHeight: 45,
            title: FittedBox(
              child: Text(
                "Feedback Summary",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              [

                Container(
                  padding: EdgeInsets.only(top:20, left:14,right: 14, bottom: 7),
                  child: Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        //border: Border.all(width: 1, color: Colors.indigo.shade900),
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              feedbackSummary.name ,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top:7, left:14,right: 14, bottom: 7),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height:45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.indigo.shade50,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  feedbackSummary.code,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                      ),
                      Expanded(
                        child: Container(
                          height:45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.indigo.shade50,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  feedbackSummary.date,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top:7, left:14,right: 14, bottom: 7),
                  child: Expanded(
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 90
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.indigo.shade50,
                      ),

                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Flexible(
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "T O P I C\n",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                feedbackSummary.topic,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ]
                          ),
                        ),
                      ),

                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top:7, left:14,right: 14, bottom: 7),
                  child: Expanded(
                    child: Container(
                      constraints: const BoxConstraints(
                          minHeight: 90
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.indigo.shade50,
                      ),

                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Flexible(
                          child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "S U M M A R Y\n",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo.shade900,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  feedbackSummary.summary!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ]
                          ),
                        ),
                      ),

                    ),
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
