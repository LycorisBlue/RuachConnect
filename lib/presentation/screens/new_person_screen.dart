import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/styles.dart';
import '../../providers/newcomers_provider.dart';
import '../../models/person.dart';

class NewPersonScreen extends ConsumerStatefulWidget {
  const NewPersonScreen({super.key});

  @override
  ConsumerState<NewPersonScreen> createState() => _NewPersonScreenState();
}

class _NewPersonScreenState extends ConsumerState<NewPersonScreen> {
  final TextEditingController _nomCompletController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _communeController = TextEditingController();
  final TextEditingController _quartierController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _prayerRequestController = TextEditingController();
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _selectedSexe;
  String? _selectedSituationMatrimoniale;
  String? _selectedCommentKnownChurch;
  bool _isFirstVisit = true;

  @override
  void dispose() {
    _nomCompletController.dispose();
    _phoneController.dispose();
    _communeController.dispose();
    _quartierController.dispose();
    _professionController.dispose();
    _prayerRequestController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est requis';
    }
    return null;
  }

  String? _validateNomComplet(String? value) {
    final error = _validateRequired(value, 'Le nom complet');
    if (error != null) return error;
    
    final parts = value!.trim().split(' ');
    if (parts.length < 2) {
      return 'Veuillez saisir le nom et le prénom';
    }
    
    if (value.trim().length < 4) {
      return 'Le nom complet doit contenir au moins 4 caractères';
    }
    if (value.trim().length > 200) {
      return 'Le nom complet ne peut pas dépasser 200 caractères';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final error = _validateRequired(value, 'Le téléphone');
    if (error != null) return error;
    
    final phoneRegex = RegExp(r'^[0-9]{8,10}$');
    final cleanPhone = value!.replaceAll(RegExp(r'[^\d]'), '');
    if (!phoneRegex.hasMatch(cleanPhone)) {
      return 'Format de téléphone invalide (8 à 10 chiffres)';
    }
    return null;
  }

  String? _validateSexe() {
    if (_selectedSexe == null) {
      return 'Veuillez sélectionner le sexe';
    }
    return null;
  }

  String? _validateCommentKnownChurch() {
    if (_selectedCommentKnownChurch == null) {
      return 'Veuillez indiquer comment vous avez connu notre église';
    }
    return null;
  }

  void _clearForm() {
    _nomCompletController.clear();
    _phoneController.clear();
    _communeController.clear();
    _quartierController.clear();
    _professionController.clear();
    _prayerRequestController.clear();
    
    setState(() {
      _selectedSexe = null;
      _selectedSituationMatrimoniale = null;
      _selectedCommentKnownChurch = null;
      _isFirstVisit = true;
    });

    _formKey.currentState?.reset();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Formulaire effacé'),
        backgroundColor: AppColors.accent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleRegister() {
    final sexeError = _validateSexe();
    if (sexeError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(sexeError),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final knownChurchError = _validateCommentKnownChurch();
    if (knownChurchError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(knownChurchError),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      
      final parts = _nomCompletController.text.trim().split(' ');
      final person = Person(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        firstName: parts.first,
        lastName: parts.skip(1).join(' '),
        phone: _phoneController.text.trim(),
        commune: _communeController.text.trim(),
        quartier: _quartierController.text.trim().isNotEmpty ? _quartierController.text.trim() : 'Non renseigné',
        gender: _selectedSexe!,
        profession: _professionController.text.trim().isNotEmpty ? _professionController.text.trim() : 'Non renseigné',
        maritalStatus: _selectedSituationMatrimoniale ?? 'Non renseigné',
        isFirstVisit: _isFirstVisit,
        howKnownChurch: _selectedCommentKnownChurch ?? 'Non renseigné',
        prayerRequest: _prayerRequestController.text.trim().isNotEmpty ? _prayerRequestController.text.trim() : 'Aucune demande',
        status: 'nouveau',
        createdAt: DateTime.now(),
      );
      
      ref.read(newcomersProvider.notifier).addPerson(person);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Visiteur enregistré avec succès'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.onSurface,
            size: 20.w,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh_outlined,
              color: AppColors.accent,
              size: 22.w,
            ),
            onPressed: _clearForm,
            tooltip: 'Effacer le formulaire',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                
                Text(
                  'Nouveau Visiteur',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                
                SizedBox(height: 8.h),
                
                Text(
                  'Enregistrez les informations du visiteur pour le suivi pastoral',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.accent,
                  ),
                ),
                
                SizedBox(height: 32.h),
                
                // Nom complet
                _buildTextField(
                  controller: _nomCompletController,
                  labelText: 'Nom complet *',
                  hintText: 'Ex: Jean Kouassi',
                  prefixIcon: Icons.person_outline,
                  validator: _validateNomComplet,
                ),
                
                SizedBox(height: 20.h),
                
                // Téléphone
                _buildTextField(
                  controller: _phoneController,
                  labelText: 'Numéro de téléphone *',
                  hintText: 'Ex: 0102030405',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: _validatePhone,
                ),
                
                SizedBox(height: 20.h),
                
                // Commune
                _buildTextField(
                  controller: _communeController,
                  labelText: 'Commune *',
                  hintText: 'Ex: Cocody',
                  prefixIcon: Icons.location_on_outlined,
                  validator: (value) => _validateRequired(value, 'La commune'),
                ),
                
                SizedBox(height: 20.h),
                
                // Quartier
                _buildTextField(
                  controller: _quartierController,
                  labelText: 'Quartier (optionnel)',
                  hintText: 'Ex: Riviera Palmeraie',
                  prefixIcon: Icons.location_city_outlined,
                ),
                
                SizedBox(height: 20.h),
                
                // Sexe
                _buildDropdown(
                  label: 'Sexe *',
                  value: _selectedSexe,
                  hint: 'Sélectionner le sexe',
                  prefixIcon: Icons.person_outline,
                  items: [
                    'Masculin',
                    'Féminin',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedSexe = value;
                    });
                  },
                  isRequired: true,
                ),
                
                SizedBox(height: 20.h),
                
                // Profession
                _buildTextField(
                  controller: _professionController,
                  labelText: 'Profession (optionnel)',
                  hintText: 'Ex: Ingénieur',
                  prefixIcon: Icons.work_outline,
                ),
                
                SizedBox(height: 20.h),
                
                // Situation matrimoniale
                _buildDropdown(
                  label: 'Situation matrimoniale (optionnel)',
                  value: _selectedSituationMatrimoniale,
                  hint: 'Sélectionner la situation',
                  prefixIcon: Icons.favorite_outline,
                  items: [
                    'Célibataire',
                    'Marié(e)',
                    'Divorcé(e)',
                    'Veuf/Veuve',
                    'En union libre',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedSituationMatrimoniale = value;
                    });
                  },
                ),
                
                SizedBox(height: 20.h),
                
                // Comment avez-vous connu l'église
                _buildDropdown(
                  label: 'Comment avez-vous connu notre église? *',
                  value: _selectedCommentKnownChurch,
                  hint: 'Sélectionner une option',
                  prefixIcon: Icons.lightbulb_outline,
                  items: [
                    'Par un ami/membre de l\'église',
                    'Par la famille',
                    'Passage dans le quartier',
                    'Réseaux sociaux/Internet',
                    'Invitation lors d\'un événement',
                    'Recherche personnelle',
                    'Radio/Télévision',
                    'Tract/Affiche',
                    'Autre',
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCommentKnownChurch = value;
                    });
                  },
                  isRequired: true,
                ),
                
                SizedBox(height: 20.h),
                
                // Demande de prière
                _buildTextField(
                  controller: _prayerRequestController,
                  labelText: 'Demande de prière *',
                  hintText: 'Ex: Pour ma famille, mon travail, ma santé...',
                  maxLines: 3,
                  prefixIcon: Icons.favorite_outline,
                  validator: (value) => _validateRequired(value, 'La demande de prière'),
                ),
                
                SizedBox(height: 20.h),
                
                // Questions booléennes
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informations supplémentaires',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      
                      // Première visite
                      CheckboxListTile(
                        title: Text(
                          'Première visite dans notre église',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        value: _isFirstVisit,
                        onChanged: (value) {
                          setState(() {
                            _isFirstVisit = value ?? true;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 40.h),
                
                // Bouton d'enregistrement
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Enregistrer le visiteur',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                
                SizedBox(height: 32.h),
                
                // Note d'information
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primary,
                        size: 24.w,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Accueil et suivi pastoral',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Les informations collectées permettent un meilleur accueil et suivi pastoral. Toutes les données sont confidentielles et utilisées uniquement dans le cadre de l\'accompagnement spirituel.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.accent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.accent,
              fontSize: 16.sp,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: AppColors.accent,
              size: 20.w,
            ),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.danger),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required String hint,
    required IconData prefixIcon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 48.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.surface,
          ),
          child: Row(
            children: [
              Icon(
                prefixIcon,
                color: AppColors.accent,
                size: 20.w,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    hint: Text(
                      hint,
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 16.sp,
                      ),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.accent,
                      size: 20.w,
                    ),
                    isExpanded: true,
                    items: items.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}