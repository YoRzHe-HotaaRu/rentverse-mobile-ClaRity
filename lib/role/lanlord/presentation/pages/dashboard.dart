import 'package:flutter/material.dart';
import 'package:rentverse/common/widget/custom_app_bar.dart';
import 'package:rentverse/role/lanlord/widget/dashboard/property_being_proposed.dart';
import 'package:rentverse/role/lanlord/widget/dashboard/rented_property.dart';
import 'package:rentverse/role/lanlord/widget/dashboard/stats_widget.dart';
import 'package:rentverse/role/lanlord/widget/dashboard/your_trust_index.dart';

class LandlordDashboardPage extends StatelessWidget {
  const LandlordDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          displayName: 'Landlord',
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatsWidget(
                periods: const ['Monthly', 'Weekly', 'Daily'],
                selectedPeriod: 'Monthly',
                items: const [
                  StatItem(
                    icon: Icons.remove_red_eye_outlined,
                    title: 'New Visits',
                    value: '90',
                    delta: '+1%',
                  ),
                  StatItem(
                    icon: Icons.home_work_outlined,
                    title: 'Property for Rent',
                    value: '3',
                    delta: '+1%',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const YourTrustIndex(score: 80),
              const SizedBox(height: 16),
              PropertyBeingProposed(
                items: const [
                  PropertyProposal(
                    title: 'Joane Residence',
                    city: 'Kuala Lumpur',
                    status: 'Waiting',
                    imageUrl:
                        'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80',
                  ),
                  PropertyProposal(
                    title: 'Joane Residence',
                    city: 'Kuala Lumpur',
                    status: 'Waiting',
                    imageUrl:
                        'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RentedProperty(
                items: const [
                  RentedItem(
                    renterName: 'Renata',
                    renterAvatarUrl:
                        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80',
                    title: 'Joane Residence',
                    city: 'Kuala Lumpur',
                    startDate: '28/12/2025',
                    endDate: '30/12/2025',
                    duration: '2 Days',
                    imageUrl:
                        'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80',
                  ),
                  RentedItem(
                    renterName: 'Renata',
                    renterAvatarUrl:
                        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80',
                    title: 'Joane Residence',
                    city: 'Kuala Lumpur',
                    startDate: '28/12/2025',
                    endDate: '30/12/2025',
                    duration: '2 Days',
                    imageUrl:
                        'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
