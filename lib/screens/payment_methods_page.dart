import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  // Sample payment methods
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'visa',
      'last4': '4242',
      'expiry': '05/25',
      'isDefault': true,
    },
    {
      'type': 'mastercard',
      'last4': '8765',
      'expiry': '12/24',
      'isDefault': false,
    },
  ];

  // Sample transactions
  final List<Map<String, dynamic>> _recentTransactions = [
    {
      'id': 'TX123456',
      'date': '2023-07-15',
      'amount': 12.50,
      'description': 'Bike Ride - 45 min',
      'status': 'completed',
    },
    {
      'id': 'TX123455',
      'date': '2023-07-12',
      'amount': 5.00,
      'description': 'Wallet Top-up',
      'status': 'completed',
    },
    {
      'id': 'TX123454',
      'date': '2023-07-10',
      'amount': 8.75,
      'description': 'Bike Ride - 30 min',
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Payment Methods',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B7280)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet balance card
              _buildWalletCard(),
              
              const SizedBox(height: 24),
              
              // Payment methods section
              _buildSectionHeader('Payment Methods'),
              ..._paymentMethods.map((method) => _buildPaymentMethodCard(method)),
              
              // Add payment method button
              _buildAddPaymentButton(),
              
              const SizedBox(height: 24),
              
              // Recent transactions section
              _buildSectionHeader('Recent Transactions'),
              _buildTransactionsCard(),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1F2937),
        ),
      ),
    );
  }

  Widget _buildWalletCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF22C55E).withAlpha((0.3 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wallet Balance',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'BikeGo Credits',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '\$25.50',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Add money logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF22C55E),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Add Money',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // View history logic
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'View History',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    IconData cardIcon;
    Color cardColor;
    
    // Set card icon and color based on type
    switch (method['type']) {
      case 'visa':
        cardIcon = Icons.credit_card;
        cardColor = const Color(0xFF1A56DB);
        break;
      case 'mastercard':
        cardIcon = Icons.credit_card;
        cardColor = const Color(0xFFEF4444);
        break;
      case 'amex':
        cardIcon = Icons.credit_card;
        cardColor = const Color(0xFF3B82F6);
        break;
      default:
        cardIcon = Icons.credit_card;
        cardColor = const Color(0xFF6B7280);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: cardColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            cardIcon,
            color: cardColor,
            size: 20,
          ),
        ),
        title: Row(
          children: [
            Text(
              method['type'].toString().toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(width: 8),
            if (method['isDefault'])
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Default',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(
          '•••• ${method['last4']} | Expires ${method['expiry']}',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF6B7280),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert, color: Color(0xFF9CA3AF)),
          onPressed: () {
            _showCardOptions(method);
          },
        ),
      ),
    );
  }

  Widget _buildAddPaymentButton() {
    return InkWell(
      onTap: () {
        // Navigate to add payment method
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF22C55E),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Add Payment Method',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF22C55E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ..._recentTransactions.map((transaction) => _buildTransactionItem(transaction)),
          InkWell(
            onTap: () {
              // Navigate to full transaction history
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View All Transactions',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF22C55E),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF22C55E),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    // Format date
    final DateTime date = DateTime.parse(transaction['date']);
    final String formattedDate = '${date.day}/${date.month}/${date.year}';
    
    // Set icon based on transaction type
    IconData transactionIcon;
    Color iconColor;
    
    if (transaction['description'].contains('Ride')) {
      transactionIcon = Icons.pedal_bike;
      iconColor = const Color(0xFF3B82F6);
    } else if (transaction['description'].contains('Top-up')) {
      transactionIcon = Icons.account_balance_wallet;
      iconColor = const Color(0xFF22C55E);
    } else {
      transactionIcon = Icons.receipt;
      iconColor = const Color(0xFF6B7280);
    }

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              transactionIcon,
              color: iconColor,
              size: 20,
            ),
          ),
          title: Text(
            transaction['description'],
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
          ),
          subtitle: Text(
            formattedDate,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
          ),
          trailing: Text(
            '\$${transaction['amount'].toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
          ),
        ),
        if (_recentTransactions.indexOf(transaction) < _recentTransactions.length - 1)
          const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }

  void _showCardOptions(Map<String, dynamic> method) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.check_circle_outline, color: Color(0xFF22C55E)),
                title: Text(
                  'Set as Default',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Set as default logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: Color(0xFF6B7280)),
                title: Text(
                  'Edit Card',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Edit card logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
                title: Text(
                  'Remove Card',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFEF4444),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(method);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> method) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Remove Card',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to remove this card? This action cannot be undone.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Remove card logic
                setState(() {
                  _paymentMethods.remove(method);
                });
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Card removed successfully',
                      style: GoogleFonts.inter(),
                    ),
                    backgroundColor: const Color(0xFF22C55E),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Remove',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

