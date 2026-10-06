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
import '../../../../core/widgets/helpi_logo.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_failure_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    FocusScope.of(context).unfocus();
    BlocProvider.of<AuthBloc>(context).add(
      AuthLoginSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _goToRegister() {
    Navigator.of(context).pushNamed(AppRoutes.register);
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
                    const Center(child: HelpIAvatar(size: 104)),
                    const SizedBox(height: 24),
                    Text(
                      l10n.loginSubtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: AppColors.brandBlue,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: AppDimens.gapLg),
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 22, 18, 8),
                      decoration: AppDecorations.card(),
                      child: Column(
                        children: [
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
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submit(),
                            validator: (value) => Validators.required(
                              value,
                              l10n.errorPasswordRequired,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimens.gapLg),
                    PrimaryButton(
                      label: l10n.signIn,
                      onPressed: _submit,
                      isLoading: isLoading,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: LinkButton(
                        label: l10n.forgotPassword,
                        onPressed: () => ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(content: Text(l10n.forgotPasswordMsg)),
                          ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          l10n.noAccount,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        LinkButton(label: l10n.createOne, onPressed: _goToRegister),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.demoHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontStyle: FontStyle.italic),
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
