import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F6F8),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Text(
              "Add Demat Account",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF00338B),
              ),
            ),

            Divider(thickness: 2),

            const SizedBox(height: 20),

            // Applicant Name
            _buildLabel("Applicant Name"),
            const SizedBox(height: 6),
            _buildTextField("Application Name"),

            const SizedBox(height: 20),

            // PAN Number
            _buildLabel("PAN Number"),
            const SizedBox(height: 6),
            _buildTextField("PAN Number"),

            const SizedBox(height: 20),

            // Client ID
            _buildLabel("Client Id/Beneficiary Number"),
            const SizedBox(height: 6),
            _buildTextField("Client Id/Beneficiary Number"),

            const SizedBox(height: 20),

            // UPI ID
            _buildLabel("UPI Id (Phonepe, Gpay, BHIM etc.)"),
            const SizedBox(height: 6),
            _buildTextField("UPI Id (Phonepe, Gpay, BHIM etc.)"),

            const SizedBox(height: 40),

            // Add Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00338B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF00338B)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
