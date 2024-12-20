import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/route.dart';


class PageNotFound extends StatelessWidget {
  final String errorMessage;
  const PageNotFound({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                errorMessage,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () => context.goNamed(RouteNames.main),
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
