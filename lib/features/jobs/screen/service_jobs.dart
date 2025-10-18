import 'package:flutter/material.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

class ServiceJobs extends StatefulWidget {
  const ServiceJobs({super.key});
  static const String routeName = '/serviceJobs';

  @override
  State<ServiceJobs> createState() => _ServiceJobsState();
}

class _ServiceJobsState extends State<ServiceJobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: GlobalAppbar(text: "Browse Jobs"),
      body:
      Center(
        child: Text("data"),
      ),
      
    );
  }
}