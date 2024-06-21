part of values;
const myDefaultPadding = 20.0;
const myDefaultBorderRadius = 10.0;

class SizeCustom {
  double widthOfScreen(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double heightOfScreen(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double assignHeight({
    BuildContext context,
    double fraction,
    double additions = 0,
    double subs = 0,
  }) {
    return (heightOfScreen(context) - (subs) + (additions)) * fraction;
  }

  //
  double assignWidth({
    BuildContext context,
    double fraction,
    double additions = 0,
    double subs = 0,
  }) {
    return (widthOfScreen(context) - (subs) + (additions)) * fraction;
  }
  double assignTextSize({
    BuildContext context,
    int sizeText,
    double size
  }) {

    if (sizeText < 5)
      return (size / (sizeText * 50) * (heightOfScreen(context) * 0.1));
    else if (sizeText > 5 && sizeText < 10)
      return (size / (sizeText * 20) * (heightOfScreen(context) * 0.1));
    else if (sizeText > 10 && sizeText < 15)
      return (size / (sizeText * 10) * (heightOfScreen(context) * 0.1));
    else
      return (size / (sizeText * 10) * (heightOfScreen(context) * 0.1));

  }
}
