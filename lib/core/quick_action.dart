import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:toolify/app/money_manage/money_manage.dart';

const QuickActions quickActions = QuickActions();

initializeAction(BuildContext context) {
  quickActions.initialize((String shortvutType) {
    switch (shortvutType) {
      case 'MoneyManage':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => const MoneyManage()));
        return;
      // case 'Writer':
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (builder) => const PersonPage()));
      //   return;
      // default:
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (builder) => const SettingPage(),
      //     ),
      //   );
      // return;
    }
  });
  quickActions.setShortcutItems(
    [
      const ShortcutItem(type: 'MoneyManage', localizedTitle: 'Money Manage'),
      // const ShortcutItem(
      //     type: 'Writer', localizedTitle: 'Writer', icon: 'person'),
      // const ShortcutItem(
      //     type: 'Setting', localizedTitle: 'Setting', icon: 'settings'),
    ],
  );
}
