import 'package:flutter/material.dart';

Widget getDynamicImg(String weatherDescription) {
  switch (weatherDescription) {
    case "Clear":
      {
        return Image.asset("images/sun.png");
      }
      break;
    case "Clouds":
      {
        return Image.asset("images/cloud.png");
      }
      break;
    case "Rain":
      {
        return Image.asset("images/cloud.png");
      }
      break;
    case "Snow":
      {
        return Image.asset("images/cloud.png");
      }
      break;
    default:
      {
        return Image.asset("images/sun.png");
      }
      break;
  }
}
