// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appLanguage": MessageLookupByLibrary.simpleMessage("Language"),
        "hello": MessageLookupByLibrary.simpleMessage("Hello"),
        "onboardingContent1": MessageLookupByLibrary.simpleMessage(
            "We\'re excited to have you on board. Our app is designed to simplify your life and boost your productivity."),
        "onboardingContent2": MessageLookupByLibrary.simpleMessage(
            "With an intuitive interface, you can effortlessly create and manage your tasks. Stay organized by categorizing them, and prioritizing them."),
        "onboardingTitle":
            MessageLookupByLibrary.simpleMessage("Welcome to\nSelf Control")
      };
}
