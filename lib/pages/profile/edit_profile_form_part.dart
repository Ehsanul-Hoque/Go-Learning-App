part of "package:app/pages/profile/user_profile.dart";

class EditProfileFormPart extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ProfileGetResponseData profileData;
  final EditProfilePostRequest editInfo;

  const EditProfileFormPart({
    Key? key,
    required this.formKey,
    required this.profileData,
    required this.editInfo,
  }) : super(key: key);

  @override
  State<EditProfileFormPart> createState() => _EditProfileFormPartState();
}

class _EditProfileFormPartState extends State<EditProfileFormPart> {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _addressTextController;
  late TextEditingController _institutionNameTextController;
  late TextEditingController _currentClassTextController;

  bool _nameEdited = false;
  bool _phoneEdited = false;
  bool _addressEdited = false;
  bool _institutionNameEdited = false;
  bool _currentClassEdited = false;

  @override
  void initState() {
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _addressTextController = TextEditingController();
    _institutionNameTextController = TextEditingController();
    _currentClassTextController = TextEditingController();

    widget.editInfo.photo = widget.profileData.photo ?? "";

    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _phoneTextController.dispose();
    _addressTextController.dispose();
    _institutionNameTextController.dispose();
    _currentClassTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool formFieldsEnabled = !widget.profileData.isGuest;
    // Email is not changeable
    _emailTextController.text = widget.profileData.email ?? "";

    if (!_nameEdited) {
      _nameTextController.text = widget.profileData.name ?? "";
      widget.editInfo.name = _nameTextController.text;
    }

    if (!_phoneEdited) {
      _phoneTextController.text = widget.profileData.phone ?? "";
      widget.editInfo.phone = _phoneTextController.text;
    }

    if (!_addressEdited) {
      _addressTextController.text = widget.profileData.address ?? "";
      widget.editInfo.address = _addressTextController.text;
    }

    if (!_institutionNameEdited) {
      _institutionNameTextController.text =
          widget.profileData.institution ?? "";
      widget.editInfo.institution = _institutionNameTextController.text;
    }

    if (!_currentClassEdited) {
      _currentClassTextController.text = widget.profileData.selectedClass ?? "";
      widget.editInfo.selectedClass = _currentClassTextController.text;
    }

    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          MyCircleAvatar(
            imageUrl: widget.profileData.photo,
            radius: Res.dimen.drawerAvatarRadius,
            padding: 1,
            backgroundColor: Res.color.drawerAvatarBg,
            shadow: const <BoxShadow>[],
          ),
          SizedBox(
            height: Res.dimen.normalSpacingValue,
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: _nameTextController,
              label: Res.str.fullName,
              textInputType: TextInputType.name,
              maxLength: 20,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              validator: onNameValidation,
              onChange: (String value) {
                _nameEdited = true;
                widget.editInfo.name = value.trim();
              },
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: false,
              textEditingController: _emailTextController,
              label: Res.str.email,
              textInputType: TextInputType.emailAddress,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: _phoneTextController,
              label: Res.str.phone,
              prefixText: "${Res.str.bdCountryCodeShort} ",
              textInputType: TextInputType.phone,
              maxLength: 11,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              validator: onPhoneValidation,
              onChange: (String value) {
                _phoneEdited = true;
                widget.editInfo.phone = value.trim();
              },
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: _addressTextController,
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
              onChange: (String value) {
                _addressEdited = true;
                widget.editInfo.address = value.trim();
              },
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: _institutionNameTextController,
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
              onChange: (String value) {
                _institutionNameEdited = true;
                widget.editInfo.institution = value.trim();
              },
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              enabled: formFieldsEnabled,
              textEditingController: _currentClassTextController,
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
              onChange: (String value) {
                _currentClassEdited = true;
                widget.editInfo.selectedClass = value.trim();
              },
            ),
          ),
        ],
      ),
    );
  }

  String? onNameValidation(String? value) {
    value = value?.trim();

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
    value = value?.trim();

    if (value == null || value.isEmpty) {
      return Res.str.enterPhoneNumber;
    } else if (value.length != 11) {
      return Res.str.invalidPhoneNumber;
    }

    return null;
  }

  String? onFieldNotEmptyValidation(String? value, String errorIfEmpty) {
    value = value?.trim();

    if ((value == null) || value.isEmpty) {
      return errorIfEmpty;
    }

    return null;
  }
}
