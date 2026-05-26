import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:groupcheck/main.dart';

void main() {
  testWidgets('logs in and opens home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('간편하게 로그인하고\n동아리 활동을 확인하세요'), findsOneWidget);
    expect(find.text('홈'), findsNothing);

    await tester.enterText(find.byKey(const Key('idField')), 'test_user');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pumpAndSettle();

    expect(find.text('홈'), findsWidgets);
    expect(find.text('출석체크'), findsOneWidget);
    expect(find.text('캘린더'), findsOneWidget);
    expect(find.text('옵션'), findsOneWidget);
    expect(find.text('test_user님, 안녕하세요'), findsOneWidget);
    expect(find.text('프로젝트 피드'), findsOneWidget);
    expect(find.text('캠퍼스 매칭 서비스'), findsWidgets);
  });
}
