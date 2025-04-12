import 'dart:developer';

import 'package:flicknest/core/utils/context_utility.dart';
import 'package:flicknest/core/widgets/app_background.dart';
import 'package:flicknest/core/widgets/app_button.dart' show AppButton;
import 'package:flutter/material.dart';

void setupErrorWidget() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    // Log the error to console
    log(
      "Caught Flutter Error: ${errorDetails.exceptionAsString()}",
      stackTrace: StackTrace.current,
    );

    return AppBackGround(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Oops! Something went wrong",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 20),
                  Text(
                    "Something went wrong. Please try again later. A Restart may help",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Courier"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    errorDetails.exceptionAsString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "Courier"),
                  ),
                  AppButton(
                    text: 'Report Issue',
                    onTap: () {
                      Ctx.navigatorKey.currentState?.push(
                        MaterialPageRoute(
                          builder:
                              (context) => Scaffold(
                                appBar: AppBar(title: Text("Report an Issue")),
                                body: const Text('Report the Issue Screen', style: TextStyle()),
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  };
}
