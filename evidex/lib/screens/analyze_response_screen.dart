import 'package:flutter/material.dart';

class AnalyzeResponseScreen extends StatefulWidget {
  const AnalyzeResponseScreen({super.key});

  @override
  State<AnalyzeResponseScreen> createState() => _AnalyzeResponseScreenState();
}

class _AnalyzeResponseScreenState extends State<AnalyzeResponseScreen> {
  String party1Response = "Response from Party 1 will appear here...";
  String party2Response = "Response from Party 2 will appear here...";

  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1765BE);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP BRAND
              Row(
                children: const [
                  Icon(Icons.verified, color: primaryBlue, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "Evidex",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// MENU + GREETING
              Row(
                children: const [
                  Icon(Icons.menu, size: 22),
                  SizedBox(width: 10),
                  Text(
                    "Greetings!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// PARTY 2 RESPONSE (BLUE)
              _responseCard(
                title: "AI Agent - Party 2",
                titleColor: Colors.blue,
                bgColor: const Color(0xFFCFE3F3),
                text: party2Response,
              ),

              const SizedBox(height: 18),

              /// PARTY 1 RESPONSE (ORANGE)
              _responseCard(
                title: "AI Agent - Party 1",
                titleColor: Colors.deepOrange,
                bgColor: const Color(0xFFF8DCCB),
                text: party1Response,
              ),

              const Spacer(),

              /// INPUT BAR
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: inputController,
                        decoration: const InputDecoration(
                          hintText: "Write something ...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// SEND BUTTON
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0B2F58),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        // TODO:
                        // 1. Call Party 1 API
                        // 2. Call Party 2 API
                        // 3. Update party1Response & party2Response
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  /// REUSABLE RESPONSE CARD
  Widget _responseCard({
    required String title,
    required Color titleColor,
    required Color bgColor,
    required String text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: titleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(text, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
