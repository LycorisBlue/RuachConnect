import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/person.dart';
import '../../utils/styles.dart';
import '../../utils/status_helper.dart';

class PersonDetailScreen extends ConsumerWidget {
  final Person person;

  const PersonDetailScreen({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header moderne avec actions
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(bottom: BorderSide(color: AppColors.divider.withValues(alpha: 0.3), width: 1)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Détails visiteur',
                                style: TextStyle(fontSize: 14.sp, color: AppColors.accent, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            person.fullName,
                            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // Bouton WhatsApp
                          GestureDetector(
                            onTap: () => _launchWhatsApp(person.phone),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF25D366).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.chat,
                                color: const Color(0xFF25D366),
                                size: 20.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Bouton Appel
                          GestureDetector(
                            onTap: () => _makePhoneCall(person.phone),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.phone,
                                color: AppColors.success,
                                size: 20.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Bouton Retour
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.arrow_back, color: AppColors.primary, size: 20.w),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),

            // Contenu principal
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    
                    // En-tête de la personne
                    _buildPersonHeader(),
                    
                    SizedBox(height: 24.h),
                    
                    // Informations personnelles
                    _buildPersonInfo(),
                    
                    SizedBox(height: 24.h),
                    
                    // Section suivi
                    _buildFollowUpSection(),
                    
                    SizedBox(height: 24.h),
                    
                    // Section actions
                    _buildActionsSection(context),
                    
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1), width: 1.5),
      ),
      child: Row(
        children: [
          // Avatar principal
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Text(
                person.firstName[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: 20.w),

          // Informations principales
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.fullName,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
                
                SizedBox(height: 6.h),
                
                Row(
                  children: [
                    Icon(Icons.phone_outlined, color: AppColors.accent, size: 16.w),
                    SizedBox(width: 6.w),
                    Text(
                      person.phone,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 4.h),
                
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: AppColors.accent, size: 16.w),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        '${person.commune}${person.quartier != 'Non renseigné' ? ' • ${person.quartier}' : ''}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 12.h),
                
                // Statut et première visite
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: StatusHelper.getStatusColor(person.status),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        StatusHelper.getStatusLabel(person.status),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (person.isFirstVisit) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.secondary, width: 1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Première visite',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonInfo() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Informations personnelles',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          _buildInfoRow('Sexe', person.gender),
          _buildInfoRow('Profession', person.profession),
          _buildInfoRow('Situation matrimoniale', person.maritalStatus),
          _buildInfoRow('Comment connu l\'église', person.howKnownChurch),
          _buildInfoRow('Date d\'enregistrement', _formatDate(person.createdAt)),
        ],
      ),
    );
  }

  Widget _buildFollowUpSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Suivi pastoral',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          _buildInfoRow('Statut actuel', StatusHelper.getStatusLabel(person.status)),
          
          if (person.assignedMentorId != null)
            _buildInfoRow('Encadreur assigné', person.assignedMentorId!),
          
          // Demande de prière dans une section spéciale
          SizedBox(height: 16.h),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_outline, color: AppColors.primary, size: 16.w),
                    SizedBox(width: 8.w),
                    Text(
                      'Demande de prière',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  person.prayerRequest,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.accent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final cardDate = DateTime(date.year, date.month, date.day);
    
    if (cardDate == today) {
      return 'Aujourd\'hui';
    } else if (cardDate == today.subtract(const Duration(days: 1))) {
      return 'Hier';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchWhatsApp(String phoneNumber) async {
    // Nettoyer le numéro de téléphone
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    // Ajouter le code pays si nécessaire (Côte d'Ivoire = +225)
    if (cleanNumber.length == 8 || cleanNumber.length == 10) {
      cleanNumber = '225$cleanNumber';
    }
    
    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanNumber?text=Bonjour, je vous contacte suite à votre visite à notre église.');
    
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildActionsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Actions de suivi',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          // Boutons d'actions
          Column(
            children: [
              // Ajouter une interaction
              _buildActionButton(
                'Ajouter une interaction',
                'Enregistrer une visite, appel ou rencontre',
                Icons.add_circle_outline,
                AppColors.primary,
                () {
                  // Navigation vers écran d'ajout d'interaction
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ajout d\'interaction - À implémenter')),
                  );
                },
              ),
              
              SizedBox(height: 12.h),
              
              // Assigner un encadreur
              _buildActionButton(
                'Gérer l\'assignation',
                'Assigner ou modifier l\'encadreur',
                Icons.assignment_ind_outlined,
                AppColors.secondary,
                () {
                  // Navigation vers écran d'assignation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gestion d\'assignation - À implémenter')),
                  );
                },
              ),
              
              SizedBox(height: 12.h),
              
              // Voir l'historique
              _buildActionButton(
                'Voir l\'historique',
                'Consulter toutes les interactions passées',
                Icons.history_outlined,
                AppColors.accent,
                () {
                  // Navigation vers historique
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Historique des interactions - À implémenter')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: color, size: 20.w),
            ),
            
            SizedBox(width: 16.w),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.accent,
              size: 16.w,
            ),
          ],
        ),
      ),
    );
  }
}