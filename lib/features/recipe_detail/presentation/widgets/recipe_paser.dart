import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart';

List<String> parseInstructions(String input) {
  if (_isValidHtml(input)) {
    Document document = htmlParser.parse(input);

    List<Element> stepElements = document.getElementsByTagName('ol').isNotEmpty
        ? document.getElementsByTagName('ol')[0].getElementsByTagName('li')
        : [];
    List<String> steps = stepElements.map((element) => element.text).toList();

    return steps;
  } else {
    return input.split('\n').map((step) => step.trim()).where((step) => step.isNotEmpty).toList();
  }
}

bool _isValidHtml(String input) {
  return input.contains('<') && input.contains('>');
}