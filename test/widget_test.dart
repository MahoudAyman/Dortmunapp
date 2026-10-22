import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_adaptive_layout/main.dart';

void main() {
  testWidgets('Renders Bottom NavigationBar on compact mobile screen', (WidgetTester tester) async {
    // Set compact mobile window dimensions (width: 400 dp, devicePixelRatio: 1.0)
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveAdaptiveApp());
    await tester.pumpAndSettle();

    // On mobile (< 600 dp), a Bottom NavigationBar should be present
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('Renders NavigationRail on medium tablet screen', (WidgetTester tester) async {
    // Set medium tablet window dimensions (width: 800 dp, devicePixelRatio: 1.0)
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveAdaptiveApp());
    await tester.pumpAndSettle();

    // On tablet (600 - 1023 dp), a NavigationRail should be present and bottom NavigationBar should not
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('Renders Desktop Sidebar on expanded desktop screen', (WidgetTester tester) async {
    // Set expanded desktop window dimensions (width: 1280 dp, devicePixelRatio: 1.0)
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveAdaptiveApp());
    await tester.pumpAndSettle();

    // On desktop (>= 1024 dp), navigation sidebar with 'Multi-Platform' branding is rendered
    expect(find.text('Multi-Platform'), findsOneWidget);
    expect(find.text('Active Window Diagnostics'), findsOneWidget);
  });
}
