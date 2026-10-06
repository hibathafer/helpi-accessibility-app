import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_failure_message.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    FocusScope.of(context).unfocus();
    BlocProvider.of<AuthBloc>(context).add(
      AuthRegisterSubmitted(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
        } else if (state.status == AuthStatus.failure &&
            state.failure != null) {
          final text = state.failure!.message(AppLocalizations.of(context)!);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(text)));
        }
      },
      child: AppScaffold(
        headerLeading: HeaderLeading.none,
        showBottomNav: false,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state.status == AuthStatus.loading;

            return SingleChildScrollView(
              padding: kScreenPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.registerTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.brandBlue,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.registerSubtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppDimens.gapLg),
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
                      decoration: AppDecorations.card(),
                      child: Column(
                        children: [
                          LabeledTextField(
                            label: l10n.fullNameLabel,
                            hint: l10n.fullNameHint,
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.name],
                            validator: (value) =>
                                Validators.required(value, l10n.errorNameRequired),
                          ),
                          const SizedBox(height: AppDimens.gap),
                          LabeledTextField(
                            label: l10n.emailLabel,
                            hint: l10n.emailHint,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) => Validators.email(
                              value,
                              requiredMessage: l10n.errorEmailRequired,
                              invalidMessage: l10n.errorEmailInvalid,
                            ),
                          ),
                          const SizedBox(height: AppDimens.gap),
                          PasswordField(
                            label: l10n.passwordLabel,
                            hint: l10n.passwordHint,
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            showTextToggle: false,
                            validator: (value) => Validators.password(
                              value,
                              requiredMessage: l10n.errorPasswordRequired,
                              tooShortMessage: l10n.errorPasswordShort,
                              weakMessage: l10n.errorPasswordWeak,
                            ),
                          ),
                          const SizedBox(height: AppDimens.gap),
                          PasswordField(
                            label: l10n.confirmPasswordLabel,
                            hint: l10n.passwordHint,
                            controller: _confirmController,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submit(),
                            showTextToggle: false,
                            validator: (value) => Validators.matches(
                              value,
                              _passwordController.text,
                              l10n.errorPasswordMismatch,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimens.gapLg),
                    PrimaryButton(
                      label: l10n.createAccount,
                      onPressed: _submit,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          l10n.haveAccount,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        LinkButton(
                          label: l10n.signIn,
                          onPressed: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRoutes.login);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
