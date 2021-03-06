import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/screens/profile/profile.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';

class ProfileWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return profileManager.mamage(
        loaded: (Profile profile) => ProfilePage(profile: profile),
        error: (String err) => Text('$err'),
        loading: () => Center(child: CircularProgressIndicator()));
    /* ValueListenableBuilder<DataFetchState>(
        valueListenable: manager.currentState,
        builder: (_, DataFetchState state, child) {
          print(state.toString());
          if (state == DataFetchState.loaded) {
            return
                // Text('loading');
                ProfilePage(profile: manager.profile);
          } else if (state == DataFetchState.error) return Text('error');
          return Text('loading');
        });*/
  }
}
