// 定义断点常量
import 'package:flutter/widgets.dart';

const double kTabletBreakpoint = 768.0;
const double kDesktopBreakpoint = 1024.0;

extension ScreenUtil on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < kTabletBreakpoint;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= kTabletBreakpoint &&
      MediaQuery.of(this).size.width < kDesktopBreakpoint;
  bool get isDesktop => MediaQuery.of(this).size.width >= kDesktopBreakpoint;
}
