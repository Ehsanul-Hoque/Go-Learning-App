part of "package:app/pages/profile/user_profile.dart";

class EditProfileFormPart extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameTextController;
  final TextEditingController emailTextController;
  final TextEditingController phoneTextController;
  final TextEditingController addressTextController;
  final TextEditingController institutionNameTextController;
  final TextEditingController currentClassTextController;
  final bool formFieldsEnabled;

  const EditProfileFormPart({
    Key? key,
    required this.formKey,
    required this.nameTextController,
    required this.emailTextController,
    required this.phoneTextController,
    required this.addressTextController,
    required this.institutionNameTextController,
    required this.currentClassTextController,
    required this.formFieldsEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: nameTextController,
              label: Res.str.fullName,
              textInputType: TextInputType.name,
              maxLength: 20,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              validator: onNameValidation,
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: false,
              textEditingController: emailTextController,
              label: Res.str.email,
              textInputType: TextInputType.emailAddress,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: phoneTextController,
              label: Res.str.phone,
              prefixText: "${Res.str.bdCountryCode} ",
              textInputType: TextInputType.phone,
              maxLength: 11,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              validator: onPhoneValidation,
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: addressTextController,
              label: Res.str.address,
              textInputType: TextInputType.streetAddress,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              validator: (String? value) {
                return onFieldNotEmptyValidation(
                  value,
                  Res.str.enterAddress,
                );
              },
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: institutionNameTextController,
              label: Res.str.institutionName,
              textInputType: TextInputType.name,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              validator: (String? value) {
                return onFieldNotEmptyValidation(
                  value,
                  Res.str.enterInstitutionName,
                );
              },
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: currentClassTextController,
              label: Res.str.currentClass,
              textInputType: TextInputType.name,
              maxLength: 20,
              goNextOnComplete: false,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              validator: (String? value) {
                return onFieldNotEmptyValidation(
                  value,
                  Res.str.enterCurrentClass,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String? onNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return Res.str.enterName;
    } else if (value.length < 5) {
      return Res.str.nameTooSmall;
    } else if (value.length > 20) {
      return Res.str.nameTooBig;
    }

    return null;
  }

  String? onPhoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return Res.str.enterPhoneNumber;
    } else if (value.length != 11) {
      return Res.str.invalidPhoneNumber;
    }

    return null;
  }

  String? onFieldNotEmptyValidation(String? value, String errorIfEmpty) {
    if ((value == null) || value.isEmpty) {
      return errorIfEmpty;
    }

    return null;
  }
}
