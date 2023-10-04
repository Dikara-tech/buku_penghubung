import 'package:buku_penghubung/src/presentation/themes/themes.dart';
import 'package:buku_penghubung/src/utilities/ui/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// When a [controller] is specified, its [TextEditingController.text]
/// defines the [initialValue]. If this [FormField] is part of a scrolling
/// container that lazily constructs its children, like a [ListView] or a
/// [CustomScrollView], then a [controller] should be specified.
/// The controller's lifetime should be managed by a stateful widget ancestor
/// of the scrolling container.
///
/// If a [controller] is not specified, [initialValue] can be used to give
/// the automatically generated controller an initial value.
///
/// Remember to call dispose of the [TextEditingController]
/// when it is no longer needed. This will ensure we discard any resources used
/// by the object.
///
/// For a documentation about the various parameters, see [GoTextField] and [GoFormField].
///
/// {@tool snippet}
///
/// ```dart
/// GoFormField(
///   onSaved: (String? value) {
///     // This optional block of code can be used to run
///     // code when the user saves the form.
///   },
/// )
/// ```
/// {@end-tool}
///
/// {@tool dartpad --template=stateful_widget_material}
/// This example shows how to move the focus to the next field when the user
/// presses the SPACE key.
///
/// ```dart imports
/// import 'package:flutter/services.dart';
/// ```
///
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return Material(
///     child: Center(
///       child: Shortcuts(
///         shortcuts: const <ShortcutActivator, Intent>{
///           // Pressing space in the field will now move to the next field.
///           SingleActivator(LogicalKeyboardKey.space): NextFocusIntent(),
///         },
///         child: FocusTraversalGroup(
///           child: Form(
///             autovalidateMode: AutovalidateMode.always,
///             onChanged: () {
///               Form.of(primaryFocus!.context!)!.save();
///             },
///             child: Wrap(
///               children: List<Widget>.generate(5, (int index) {
///                 return Padding(
///                   padding: const EdgeInsets.all(8.0),
///                   child: ConstrainedBox(
///                     constraints: BoxConstraints.tight(const Size(200, 50)),
///                     child: GoFormField(
///                       onSaved: (String? value) {
///                         print('Value for field $index saved as "$value"');
///                       },
///                     ),
///                   ),
///                 );
///               }),
///             ),
///           ),
///         ),
///       ),
///     ),
///   );
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [GoTextField], which is the underlying text field without the [Form]
///    integration.
///  * Learn how to use a [TextEditingController] in one of our [cookbook recipes](https://flutter.dev/docs/cookbook/forms/text-field-changes#2-use-a-texteditingcontroller).
class GoFormField extends FormField<String> {
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue] or the empty string.
  ///
  /// For documentation about the various parameters, see the [GoTextField],
  /// [GoFormField] class, the constructor.
  GoFormField({
    Key? key,
    this.controller,
    String? initialValue,
    String? title,
    Widget? innerPrefix,
    Widget? outerPrefix,
    Widget? innerSuffix,
    String? hintText,
    String? helperText,
    int? helperMaxLines,
    String? errorText,
    int? errorMaxLines,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    bool autofocus = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    int? maxLines,
    int? minLines,
    bool expands = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    bool enableInteractiveSelection = true,
    GestureTapCallback? onTap,
    Iterable<String>? autofillHints,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    String? restorationId,
    bool enableIMEPersonalizedLearning = true,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    TextAlign? textAlign,
  })  : assert(initialValue == null || controller == null),
        assert(obscuringCharacter.length == 1),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(maxLength == null ||
            maxLength == TextField.noMaxLength ||
            maxLength > 0),
        super(
          key: key,
          restorationId: restorationId,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validator,
          enabled: enabled ?? true,
          autovalidateMode: autovalidateMode,
          builder: (field) {
            final state = field as _GoFormFieldState;

            return Builder(
              builder: (context) {
                return UnmanagedRestorationScope(
                  bucket: field.bucket,
                  child: GoTextField(
                    controller: state._effectiveController,
                    title: title,
                    innerPrefix: innerPrefix,
                    outerPrefix: outerPrefix,
                    innerSuffix: innerSuffix,
                    hintText: hintText,
                    helperText: helperText,
                    helperMaxLines: helperMaxLines,
                    errorText: field.errorText ?? errorText,
                    errorMaxLines: errorMaxLines,
                    focusNode: focusNode,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    textCapitalization: textCapitalization,
                    autofocus: autofocus,
                    obscuringCharacter: obscuringCharacter,
                    obscureText: obscureText,
                    autocorrect: autocorrect,
                    smartDashesType: smartDashesType,
                    smartQuotesType: smartQuotesType,
                    enableSuggestions: enableSuggestions,
                    maxLines: maxLines,
                    minLines: minLines,
                    expands: expands,
                    readOnly: readOnly,
                    toolbarOptions: toolbarOptions,
                    showCursor: showCursor,
                    maxLength: maxLength,
                    maxLengthEnforcement: maxLengthEnforcement,
                    onChanged: onChanged,
                    onEditingComplete: onEditingComplete,
                    onSubmitted: onSubmitted,
                    inputFormatters: [
                      ...?inputFormatters,
                      BracketFormatter(context),
                    ],
                    enabled: enabled ?? true,
                    enableInteractiveSelection: enableInteractiveSelection,
                    onTap: onTap,
                    autofillHints: autofillHints,
                    restorationId: restorationId,
                    enableIMEPersonalizedLearning:
                        enableIMEPersonalizedLearning,
                    textAlign: textAlign,
                  ),
                );
              },
            );
          },
        );

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() => _GoFormFieldState();
}

class _GoFormFieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController =>
      _GoFormField.controller ?? _controller!.value;

  // ignore: avoid-returning-widgets, handy to get a one-liner super.
  GoFormField get _GoFormField => super.widget as GoFormField;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    // Make sure to update the internal [FormFieldState] value to sync up with
    // text editing controller value.
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_GoFormField.controller == null) {
      _createLocalController(widget.initialValue != null
          ? TextEditingValue(text: widget.initialValue!)
          : null);
    } else {
      _GoFormField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(GoFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_GoFormField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _GoFormField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _GoFormField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_GoFormField.controller != null) {
        setValue(_GoFormField.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _GoFormField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    // setState will be called in the superclass, so even though state is being
    // manipulated, no setState call is needed here.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

/// A text field lets the user enter text, either with hardware keyboard or with
/// an onscreen keyboard.
///
/// The text field calls the [onChanged] callback whenever the user changes the
/// text in the field. If the user indicates that they are done typing in the
/// field (e.g., by pressing a button on the soft keyboard), the text field
/// calls the [onSubmitted] callback.
///
/// To control the text that is displayed in the text field, use the
/// [controller]. For example, to set the initial value of the text field, use
/// a [controller] that already contains some text. The [controller] can also
/// control the selection and composing region (and to observe changes to the
/// text, selection, and composing region).
///
/// To integrate the [GoTextField] into a [Form] with other [FormField] widgets,
/// consider using [GoFormField].
///
/// {@template flutter.material.textfield.wantKeepAlive}
/// When the widget has focus, it will prevent itself from disposing via its
/// underlying [EditableText]'s [AutomaticKeepAliveClientMixin.wantKeepAlive] in
/// order to avoid losing the selection. Removing the focus will allow it to be
/// disposed.
/// {@endtemplate}
///
/// Remember to call dispose of the [TextEditingController]
/// when it is no longer needed. This will ensure we discard any resources used
/// by the object.
///
/// {@tool snippet}
/// This example shows how to create a [GoTextField] that will obscure input. The
/// [InputDecoration] surrounds the field in a border using [OutlineInputBorder]
/// and adds a label.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/text_field.png)
///
/// ```dart
/// const GoTextField(
///   obscureText: true,
///   decoration: InputDecoration(
///     border: OutlineInputBorder(),
///     labelText: 'Password',
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## Reading values
///
/// A common way to read a value from a TextField is to use the [onSubmitted]
/// callback. This callback is applied to the text field's current value when
/// the user finishes editing.
///
/// {@tool dartpad}
/// This sample shows how to get a value from a TextField via the [onSubmitted]
/// callback.
///
/// ** See code in examples/api/lib/material/text_field/text_field.1.dart **
/// {@end-tool}
///
/// {@macro flutter.widgets.EditableText.lifeCycle}
///
/// For most applications the [onSubmitted] callback will be sufficient for
/// reacting to user input.
///
/// The [onEditingComplete] callback also runs when the user finishes editing.
/// It's different from [onSubmitted] because it has a default value which
/// updates the text controller and yields the keyboard focus. Applications that
/// require different behavior can override the default [onEditingComplete]
/// callback.
///
/// Keep in mind you can also always read the current string from a TextField's
/// [TextEditingController] using [TextEditingController.text].
///
/// ## Handling emojis and other complex characters
/// {@macro flutter.widgets.EditableText.onChanged}
///
/// In the live Dartpad example above, try typing the emoji 👨‍👩‍👦
/// into the field and submitting. Because the example code measures the length
/// with `value.characters.length`, the emoji is correctly counted as a single
/// character.
///
/// {@macro flutter.widgets.editableText.showCaretOnScreen}
///
/// See also:
///
///  * [GoFormField], which integrates with the [Form] widget.
///  * [InputDecorator], which shows the labels and other visual elements that
///    surround the actual text editing widget.
///  * [EditableText], which is the raw text editing control at the heart of a
///    [TextField]. The [EditableText] widget is rarely used directly unless
///    you are implementing an entirely different design language, such as
///    Cupertino.
///  * <https://material.io/design/components/text-fields.html>
///  * Cookbook: [Create and style a text field](https://flutter.dev/docs/cookbook/forms/text-input)
///  * Cookbook: [Handle changes to a text field](https://flutter.dev/docs/cookbook/forms/text-field-changes)
///  * Cookbook: [Retrieve the value of a text field](https://flutter.dev/docs/cookbook/forms/retrieve-input)
///  * Cookbook: [Focus and text fields](https://flutter.dev/docs/cookbook/forms/focus)
class GoTextField extends StatefulWidget {
  /// The [maxLines] property can be set to null to remove the restriction on
  /// the number of lines. By default, it is one, meaning this is a single-line
  /// text field. [maxLines] must not be zero.
  ///
  /// The [maxLength] property is set to null by default, which means the
  /// number of characters allowed in the text field is not restricted. If
  /// [maxLength] is set a character counter will be displayed below the
  /// field showing how many characters have been entered. If the value is
  /// set to a positive integer it will also display the maximum allowed
  /// number of characters to be entered.  If the value is set to
  /// [TextField.noMaxLength] then only the current length is displayed.
  ///
  /// After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforcement] is set to
  /// [MaxLengthEnforcement.none].
  /// The text field enforces the length with a [LengthLimitingTextInputFormatter],
  /// which is evaluated after the supplied [inputFormatters], if any.
  /// The [maxLength] value must be either null or greater than zero.
  ///
  /// If [maxLengthEnforcement] is set to [MaxLengthEnforcement.none], then more
  /// than [maxLength] characters may be entered, and the error counter and
  /// divider will switch to the errorStyle when the limit is
  /// exceeded.
  ///
  /// The text cursor is not shown if [showCursor] is false or if [showCursor]
  /// is null (the default) and [readOnly] is true.
  ///
  /// The [autofocus], [obscureText], [readOnly], [autocorrect], [maxLines],
  /// [maxLength], [enableSuggestions], and [enableIMEPersonalizedLearning]
  /// arguments must not be null.
  ///
  /// See also:
  ///
  ///  * [maxLength], which discusses the precise meaning of "number of
  ///    characters" and how it may differ from the intuitive meaning.
  const GoTextField({
    Key? key,
    this.controller,
    this.initialValue,
    this.title,
    this.innerPrefix,
    this.outerPrefix,
    this.innerSuffix,
    this.hintText,
    this.helperText,
    this.helperMaxLines,
    this.errorText,
    this.errorMaxLines,
    this.focusNode,
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines,
    this.minLines,
    this.expands = false,
    this.readOnly = false,
    ToolbarOptions? toolbarOptions,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.autofillHints,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.textAlign,
  })  : assert(initialValue == null || controller == null),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        assert(obscuringCharacter.length == 1),
        smartDashesType = smartDashesType ??
            (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ??
            (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(maxLength == null ||
            maxLength == TextField.noMaxLength ||
            maxLength > 0),
        toolbarOptions = toolbarOptions ??
            (obscureText
                ? const ToolbarOptions(
                    selectAll: true,
                    paste: true,
                  )
                : const ToolbarOptions(
                    copy: true,
                    cut: true,
                    selectAll: true,
                    paste: true,
                  )),
        assert(
          !identical(textInputAction, TextInputAction.newline) ||
              maxLines == 1 ||
              !identical(keyboardType, TextInputType.text),
          'Use keyboardType TextInputType.multiline when using TextInputAction.newline on a multiline TextField.',
        ),
        super(key: key);

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// An optional value to initialize the form field to, or null otherwise.
  final String? initialValue;

  /// The title to display in the form field.
  final String? title;

  /// Optional widget to place on the line before the input.
  ///
  /// This can be used, for example, to add a custom widget in
  /// front of the input. The widget's baseline is lined up with the input
  /// baseline.
  ///
  /// See also:
  ///
  ///  * [innerSuffix], the equivalent but on the trailing edge.
  final Widget? innerPrefix;

  /// Optional widget to place before the form.
  ///
  /// The size of this widget is height constrained to 42 dp/px as per design.
  ///
  /// This can be used, for example, to add a custom widget in
  /// front of the form. The widget's baseline is lined up with the form
  /// baseline.
  final Widget? outerPrefix;

  /// Optional widget to place on the line after the input.
  ///
  /// This can be used, for example, to add a custom widget after
  /// the input. The widget's baseline is lined up with the input baseline.
  ///
  /// See also:
  ///
  ///  * [innerPrefix], the equivalent but on the leading edge.
  final Widget? innerSuffix;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// Text that provides context about the [InputDecorator.child]'s value, such
  /// as how the value will be used.
  ///
  /// If non-null, the text is displayed below the [InputDecorator.child], in
  /// the same location as [errorText]. If a non-null [errorText] value is
  /// specified then the helper text is not shown.
  final String? helperText;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? helperMaxLines;

  /// Text that appears below the [InputDecorator.child] and the border.
  ///
  /// If non-null, the border's color animates to red and the [helperText] is
  /// not shown.
  final String? errorText;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? errorMaxLines;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.obscuringCharacter}
  final String obscuringCharacter;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.services.TextInputConfiguration.smartDashesType}
  final SmartDashesType smartDashesType;

  /// {@macro flutter.services.TextInputConfiguration.smartQuotesType}
  final SmartQuotesType smartQuotesType;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.maxLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// Configuration of toolbar options.
  ///
  /// If not set, select all and paste will default to be enabled. Copy and cut
  /// will be disabled if [obscureText] is true. If [readOnly] is true,
  /// paste and cut will be disabled regardless.
  final ToolbarOptions toolbarOptions;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  ///
  /// If set, a character counter will be displayed below the
  /// field showing how many characters have been entered. If set to a number
  /// greater than 0, it will also display the maximum number allowed.
  ///
  /// After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforcement] is set to
  /// [MaxLengthEnforcement.none].
  ///
  /// This value must be either null or greater than 0.
  /// If null (the default) then there is no limit to the number of characters
  /// that can be entered.
  ///
  /// Whitespace characters (e.g. newline, space, tab) are included in the
  /// character count.
  ///
  /// If [maxLengthEnforcement] is [MaxLengthEnforcement.none], then more than
  /// [maxLength] characters may be entered, but the error counter and divider
  /// will switch to the [InputDecoration.errorStyle] when the
  /// limit is exceeded.
  ///
  /// {@macro flutter.services.lengthLimitingTextInputFormatter.maxLength}
  final int? maxLength;

  /// Determines how the [maxLength] limit should be enforced.
  ///
  /// {@macro flutter.services.textFormatter.effectiveMaxLengthEnforcement}
  ///
  /// {@macro flutter.services.textFormatter.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted]:
  ///    which are more specialized input change notifications.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which
  ///    automatically shift the focus to the next/previous focusable item when
  ///    the user is done editing.
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// If false the text field is "disabled": it ignores taps and rendered in
  /// grey.
  final bool? enabled;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.material.textfield.onTap}
  final GestureTapCallback? onTap;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.material.textfield.restorationId}
  final String? restorationId;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign? textAlign;

  @override
  State<GoTextField> createState() => _GoTextFieldState();
}

class _GoTextFieldState extends State<GoTextField>
    with RestorationMixin, TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late FocusNode focusNode;
  RestorableTextEditingController? textEditingController;

  TextEditingController get effectiveController =>
      widget.controller ?? textEditingController!.value;

  @override
  String? get restorationId => widget.restorationId;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _createLocalController(widget.initialValue != null
          ? TextEditingValue(text: widget.initialValue!)
          : null);
      textEditingController!.addListener(_rebuild);
    } else {
      widget.controller!.addListener(_rebuild);
    }

    if (widget.focusNode == null) {
      focusNode = FocusNode();
    } else {
      focusNode = widget.focusNode!;
    }

    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..addListener(_rebuild);
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        animationController.forward();
      }
      if (!focusNode.hasFocus) {
        animationController.reverse();
      }
    });
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (textEditingController != null) {
      _registerController();
    }
  }

  @override
  void didUpdateWidget(GoTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller != null && widget.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (widget.controller != null) {
        if (oldWidget.controller == null) {
          unregisterFromRestoration(textEditingController!);
          textEditingController!.dispose();
          textEditingController = null;
        }
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    focusNode.dispose();
    textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: GoTypography.title(
              color: isLightMode ? GoColor.anaesthesia : GoColor.iron,
            ),
          ),
        if (widget.title != null) SizedBox(height: 8.h),
        // Workaround for https://github.com/flutter/flutter/issues/19488
        Row(
          children: [
            if (widget.outerPrefix != null)
              SizedBox(
                height: 42.h,
                width: 42.w,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: widget.outerPrefix,
                ),
              ),
            if (widget.outerPrefix != null) SizedBox(width: 8.w),
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      textAlign: widget.textAlign ?? TextAlign.start,
                      controller: effectiveController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12).r,
                        fillColor:
                            (widget.enabled ?? true) ? null : GoColor.calcium,
                        filled: !(widget.enabled ?? true),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        // Don't occupy the space as we use custom helper text
                        helperStyle: const TextStyle(height: 0),
                        hintText: widget.hintText,
                        // Don't occupy the space as we use custom error text
                        errorText: widget.errorText != null ? '' : null,
                        // Red border
                        errorStyle: const TextStyle(height: 0),
                        prefixIcon: widget.innerPrefix != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ).w,
                                child: widget.innerPrefix,
                              )
                            : null,
                        counterText: '',
                        // No built-in counter
                        // We keep building the counter inside the decoration
                        // so that the widget can handle the text form maxWidth
                        // (as to not overlay the counter)
                        suffix: widget.maxLength != null &&
                                widget.innerSuffix == null
                            ? Visibility(
                                visible: false,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: true,
                                child: _BuildCounterWidget(
                                  length: effectiveController
                                      .value.text.characters.length,
                                  maxLength: widget.maxLength!,
                                  isEnabled: widget.enabled,
                                  isNotEmpty:
                                      effectiveController.text.isNotEmpty,
                                  animation: animation,
                                ),
                              )
                            : null,
                      ),
                      keyboardType: widget.keyboardType,
                      textInputAction: widget.textInputAction,
                      textCapitalization: widget.textCapitalization,
                      style: GoTypography.text(
                        color: isLightMode ? GoColor.analgesic : GoColor.albin,
                      ),
                      autofocus: widget.autofocus,
                      obscuringCharacter: widget.obscuringCharacter,
                      obscureText: widget.obscureText,
                      autocorrect: widget.autocorrect,
                      smartDashesType: widget.smartDashesType,
                      smartQuotesType: widget.smartQuotesType,
                      enableSuggestions: widget.enableSuggestions,
                      readOnly: widget.readOnly,
                      toolbarOptions: widget.toolbarOptions,
                      showCursor: widget.showCursor,
                      maxLength: widget.maxLength,
                      maxLengthEnforcement: widget.maxLengthEnforcement,
                      maxLines: widget.obscureText && widget.maxLines == null
                          ? 1
                          : widget.maxLines,
                      minLines: widget.minLines,
                      expands: widget.expands,
                      onChanged: widget.onChanged,
                      onEditingComplete: widget.onEditingComplete,
                      onSubmitted: widget.onSubmitted,
                      inputFormatters: [
                        ...?widget.inputFormatters,
                        BracketFormatter(context),
                      ],
                      enabled: widget.enabled,
                      enableInteractiveSelection:
                          widget.enableInteractiveSelection,
                      onTap: widget.onTap,
                      autofillHints: widget.autofillHints,
                      enableIMEPersonalizedLearning:
                          widget.enableIMEPersonalizedLearning,
                    ),
                    if (widget.maxLength != null && widget.innerSuffix == null)
                      Padding(
                        padding: const EdgeInsets.only(right: 12).w,
                        child: _BuildCounterWidget(
                          length:
                              effectiveController.value.text.characters.length,
                          maxLength: widget.maxLength!,
                          isEnabled: widget.enabled,
                          isNotEmpty: effectiveController.text.isNotEmpty,
                          animation: animation,
                        ),
                      ),
                    if (widget.maxLength == null && widget.innerSuffix != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 12).w,
                        child: widget.innerSuffix,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (widget.helperText != null || widget.errorText != null)
          SizedBox(height: 8.h),
        _HelperError(
          helperText: widget.helperText,
          helperStyle: GoTypography.caption(
            color: isLightMode ? GoColor.anaesthesia : GoColor.iron,
          ),
          helperMaxLines: widget.helperMaxLines,
          errorText: widget.errorText,
          errorStyle: GoTypography.caption(color: GoColor.hemoglobin),
          errorMaxLines: widget.errorMaxLines,
        ),
      ],
    );
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(textEditingController == null);
    textEditingController = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  void _rebuild() {
    if (mounted) {
      setState(() {
        // Something has changed and needs to be rebuilt
      });
    }
  }

  void _registerController() {
    assert(textEditingController != null);
    registerForRestoration(textEditingController!, 'controller');
  }
}

/// Merges multiple [GoFormField] widgets into one widget tree laid
/// vertically.
///
/// This is useful if the form requires grouping or a common [title].
///
/// See [GoFormField] for further information.
class MultiGoFormField extends StatelessWidget {
  /// Merges multiple [GoFormField] widgets into one widget tree laid
  /// vertically.
  ///
  /// See [GoFormField] for further information.
  const MultiGoFormField({
    Key? key,
    this.title,
    required this.forms,
  }) : super(key: key);

  /// The title to display in the form field.
  final String? title;

  /// A list of [GoFormField] to be laid out vertically.
  final List<GoFormField> forms;

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: GoTypography.title(
              color: isLightMode ? GoColor.anaesthesia : GoColor.iron,
            ),
          ),
        if (title != null) SizedBox(height: 8.h),
        ListView.separated(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: forms.length,
          itemBuilder: (context, index) {
            return forms[index];
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
        ),
      ],
    );
  }
}

// Display the helper and error text. When the error text appears
// it fades and the helper text fades out. The error text also
// slides upwards a little when it first appears.
class _HelperError extends StatefulWidget {
  const _HelperError({
    Key? key,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
  }) : super(key: key);

  final String? helperText;
  final TextStyle? helperStyle;
  final int? helperMaxLines;
  final String? errorText;
  final TextStyle? errorStyle;
  final int? errorMaxLines;

  @override
  _HelperErrorState createState() => _HelperErrorState();
}

class _HelperErrorState extends State<_HelperError>
    with SingleTickerProviderStateMixin {
  // If the height of this widget and the counter are zero ("empty") at
  // layout time, no space is allocated for the subtext.
  static const Widget empty = SizedBox();

  late AnimationController _controller;
  Widget? _helper;
  Widget? _error;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    if (widget.errorText != null) {
      _error = _BuildErrorWidget(
        errorText: widget.errorText!,
        errorStyle: widget.errorStyle,
        errorMaxLines: widget.errorMaxLines,
        animationOpacityValue: _controller.value,
        animationCurrentView: _controller.view,
      );
      _controller.value = 1.0;
    } else if (widget.helperText != null) {
      _helper = _BuildHelperWidget(
        helperText: widget.helperText!,
        helperStyle: widget.helperStyle,
        helperMaxLines: widget.helperMaxLines,
        animationOpacityValue: _controller.value,
      );
    }
    _controller.addListener(_handleChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChange() {
    if (mounted) {
      setState(() {
        // The _controller's value has changed.
      });
    }
  }

  @override
  void didUpdateWidget(_HelperError old) {
    super.didUpdateWidget(old);

    final newErrorText = widget.errorText;
    final newHelperText = widget.helperText;
    final oldErrorText = old.errorText;
    final oldHelperText = old.helperText;

    final errorTextStateChanged =
        (newErrorText != null) != (oldErrorText != null);
    final helperTextStateChanged = newErrorText == null &&
        (newHelperText != null) != (oldHelperText != null);

    if (errorTextStateChanged || helperTextStateChanged) {
      if (newErrorText != null) {
        _error = _BuildErrorWidget(
          errorText: widget.errorText!,
          errorStyle: widget.errorStyle,
          errorMaxLines: widget.errorMaxLines,
          animationOpacityValue: _controller.value,
          animationCurrentView: _controller.view,
        );
        _controller.forward();
      } else if (newHelperText != null) {
        _helper = _BuildHelperWidget(
          helperText: widget.helperText!,
          helperStyle: widget.helperStyle,
          helperMaxLines: widget.helperMaxLines,
          animationOpacityValue: _controller.value,
        );
        _controller.reverse();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isDismissed) {
      _error = null;
      if (widget.helperText != null) {
        return _helper = _BuildHelperWidget(
          helperText: widget.helperText!,
          helperStyle: widget.helperStyle,
          helperMaxLines: widget.helperMaxLines,
          animationOpacityValue: _controller.value,
        );
      } else {
        _helper = null;
        return empty;
      }
    }

    if (_controller.isCompleted) {
      _helper = null;
      if (widget.errorText != null) {
        return _error = _BuildErrorWidget(
          errorText: widget.errorText!,
          errorStyle: widget.errorStyle,
          errorMaxLines: widget.errorMaxLines,
          animationOpacityValue: _controller.value,
          animationCurrentView: _controller.view,
        );
      } else {
        _error = null;
        return empty;
      }
    }

    if (_helper == null && widget.errorText != null) {
      return _BuildErrorWidget(
        errorText: widget.errorText!,
        errorStyle: widget.errorStyle,
        errorMaxLines: widget.errorMaxLines,
        animationOpacityValue: _controller.value,
        animationCurrentView: _controller.view,
      );
    }

    if (_error == null && widget.helperText != null) {
      return _BuildHelperWidget(
        helperText: widget.helperText!,
        helperStyle: widget.helperStyle,
        helperMaxLines: widget.helperMaxLines,
        animationOpacityValue: _controller.value,
      );
    }

    if (widget.errorText != null) {
      return Stack(
        children: <Widget>[
          Opacity(
            opacity: 1.0 - _controller.value,
            child: _helper,
          ),
          _BuildErrorWidget(
            errorText: widget.errorText!,
            errorStyle: widget.errorStyle,
            errorMaxLines: widget.errorMaxLines,
            animationOpacityValue: _controller.value,
            animationCurrentView: _controller.view,
          ),
        ],
      );
    }

    if (widget.helperText != null) {
      return Stack(
        children: <Widget>[
          _BuildHelperWidget(
            helperText: widget.helperText!,
            helperStyle: widget.helperStyle,
            helperMaxLines: widget.helperMaxLines,
            animationOpacityValue: _controller.value,
          ),
          Opacity(
            opacity: _controller.value,
            child: _error,
          ),
        ],
      );
    }

    return empty;
  }
}

class _BuildCounterWidget extends StatelessWidget {
  const _BuildCounterWidget({
    Key? key,
    required this.length,
    required this.maxLength,
    this.isEnabled,
    required this.isNotEmpty,
    required this.animation,
  }) : super(key: key);

  final int length;
  final int maxLength;
  final bool? isEnabled;
  final bool isNotEmpty;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final counterText = '$length/$maxLength';

    return Padding(
      padding: const EdgeInsets.only(left: 8).w,
      child: Text(
        counterText,
        style: _handleCounterTypographyColor(isLightMode: isLightMode),
      ),
    );
  }

  GoTypography _handleCounterTypographyColor({required bool isLightMode}) {
    if (isEnabled ?? true) {
      if (isNotEmpty) {
        return GoTypography.caption(
          color: isLightMode ? GoColor.hydro : GoColor.albin,
        );
      } else {
        final counterColorTween = ColorTween(
          begin: GoColor.anaesthesia,
          end: isLightMode ? GoColor.hydro : GoColor.albin,
        );

        return GoTypography.caption(
          color: counterColorTween.evaluate(animation),
        );
      }
    } else {
      return GoTypography.caption(
        color: isLightMode ? GoColor.iron : GoColor.anaesthesia,
      );
    }
  }
}

class _BuildErrorWidget extends StatelessWidget {
  const _BuildErrorWidget({
    Key? key,
    required this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    required this.animationOpacityValue,
    required this.animationCurrentView,
  }) : super(key: key);

  final String errorText;
  final TextStyle? errorStyle;
  final int? errorMaxLines;
  final double animationOpacityValue;
  final Animation<double> animationCurrentView;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      liveRegion: true,
      child: Opacity(
        opacity: animationOpacityValue,
        child: FractionalTranslation(
          translation: Tween<Offset>(
            begin: const Offset(0.0, -0.25),
            end: Offset.zero,
          ).evaluate(animationCurrentView),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2.0).h,
            child: Text(
              errorText,
              style: errorStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: errorMaxLines,
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildHelperWidget extends StatelessWidget {
  const _BuildHelperWidget({
    Key? key,
    required this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    required this.animationOpacityValue,
  }) : super(key: key);

  final String helperText;
  final TextStyle? helperStyle;
  final int? helperMaxLines;
  final double animationOpacityValue;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Opacity(
        opacity: 1.0 - animationOpacityValue,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0).h,
          child: Text(
            helperText,
            style: helperStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: helperMaxLines,
          ),
        ),
      ),
    );
  }
}
