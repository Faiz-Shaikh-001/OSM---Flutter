// Global Constant for SVG icon dimensions
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double svgIconHeight = 30;
const double svgIconWidth = 70;

// SVG assets path
class AppAssets {
  static const String order = 'assets/icons/order.svg';
  static const String lowStock = 'assets/icons/low-stock.svg';
  static const String pendingOrder = 'assets/icons/pending-order.svg';
  static const String totalEarning = 'assets/icons/total-earning.svg';
}

// Helper widget function for building colored icons
class AppIcons {
  static Widget order({Color? color}) => SvgPicture.asset(
    AppAssets.order,
    semanticsLabel: "Order Icon",
    width: svgIconWidth,
    height: svgIconHeight,
    color: color ?? Colors.blue[800],
  );

  static Widget lowStock({Color? color}) => SvgPicture.asset(
    AppAssets.lowStock,
    semanticsLabel: "Low Stock Icon",
    width: svgIconWidth,
    height: svgIconHeight,
    color: color ?? Colors.red[800],
  );

  static Widget pendingOrder({Color? color}) => SvgPicture.asset(
    AppAssets.pendingOrder,
    semanticsLabel: "Pending Order Icon",
    width: svgIconWidth,
    height: svgIconHeight,
    color: color ?? Colors.yellow[800],
  );

  static Widget totalEarning({Color? color}) => SvgPicture.asset(
    AppAssets.totalEarning,
    semanticsLabel: "Total Earning Icon",
    width: svgIconWidth,
    height: svgIconHeight,
    color: color ?? Colors.green[800],
  );
}
