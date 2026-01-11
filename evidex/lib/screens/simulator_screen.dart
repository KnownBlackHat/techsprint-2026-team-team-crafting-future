import 'package:flutter/material.dart';
import '../models/policy_model.dart';
import '../services/policy_api_service.dart';

class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  final List<String> states = [
    "delhi",
    "maharashtra",
    "karnataka",
  ];
  String? selectedState;

  List<PolicyModel> policies = [];
  PolicyModel? selectedPolicy;

  bool loadingPolicies = false;

  Future<void> _fetchPolicies(String state) async {
    setState(() {
      loadingPolicies = true;
      policies = [];
      selectedPolicy = null;
    });

    try {
      policies = await PolicyApiService.fetchPolicies(state);
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() => loadingPolicies = false);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1765BE);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// TOP LOGO
              Row(
                children: const [
                  Icon(Icons.verified,
                      color: primaryBlue, size: 18),
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

              const SizedBox(height: 80),

              /// TITLE
              const Text(
                "Get educated about a policy\nof your choice!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              /// STATE DROPDOWN
              Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedState,
                    hint: const Text("Select state"),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: states
                        .map(
                          (state) => DropdownMenuItem(
                            value: state,
                            child: Text(state),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedState = value;
                      });
                      _fetchPolicies(value!);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// POLICY DROPDOWN + SEND
              loadingPolicies
                  ? const CircularProgressIndicator()
                  : Row(
                      children: [
                        /// POLICY DROPDOWN
                        Expanded(
                          child: Container(
                            height: 46,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedState == null
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade400,
                              ),
                              borderRadius:
                                  BorderRadius.circular(30),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<PolicyModel>(
                                value: selectedPolicy,
                                hint: const Text(
                                    "Select policy of your choice"),
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down),
                                items: policies.map((policy) {
                                  return DropdownMenuItem(
                                    value: policy,
                                    child: Text(
                                      policy.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: selectedState == null
                                    ? null
                                    : (value) {
                                        setState(() {
                                          selectedPolicy = value;
                                        });
                                      },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        /// SEND BUTTON
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: selectedPolicy == null
                                ? null
                                : const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF104684),
                                      Color(0xFF0A2B51),
                                      Color(0xFF04101E),
                                    ],
                                  ),
                            color: selectedPolicy == null
                                ? Colors.grey.shade300
                                : null,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.send,
                                color: Colors.white),
                            onPressed: selectedPolicy == null
                                ? null
                                : () {
                                    // NEXT STEP:
                                    // Navigate to explanation screen
                                    // Pass selectedState & selectedPolicy
                                  },
                          ),
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
