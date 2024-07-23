import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit4try/bloc/localization/localization_bloc.dart';
import 'package:fit4try/generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).profile_page_content),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<LocalizationBloc>(context)
                    .add(LocalizationEvent.toTurkish);
              },
              child: Text(S.of(context).turkish),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<LocalizationBloc>(context)
                    .add(LocalizationEvent.toEnglish);
              },
              child: Text(S.of(context).english),
            ),
          ],
        ),
      ),
    );
  }
}
