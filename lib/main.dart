import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motivational Affirmations',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.cairoTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF6BBF59),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const AffirmationScreen(),
    );
  }
}

class AffirmationScreen extends StatefulWidget {
  const AffirmationScreen({super.key});

  @override
  State<AffirmationScreen> createState() => _AffirmationScreenState();
}

class _AffirmationScreenState extends State<AffirmationScreen> {
  // ✅ User Name
  String userName = "Tony Qaabar";
  final TextEditingController nameController = TextEditingController();

  // ✅ Counters for each card
  List<int>? counters;
  List<bool>? likedCards;

  // ✅ Fixed colors for each card
  List<Color>? cardColors;

  // 🎨 Color Palette
  static const List<Color> colors = [
    Color(0xFFFDF6EC),
    Color(0xFFFAE3D9),
    Color(0xFFBBDED6),
    Color(0xFF61C0BF),
    Color(0xFFFFB6B9),
    Color(0xFF8AC6D1),
    Color(0xFFB8F2E6),
    Color(0xFFD9F2B4),
  ];

  // 💬 Affirmations (30 statements)
  static const List<String> affirmations = [
    "ابتسم للحياة وكن إيجابياً",
    "القوة في الاستمرار رغم الصعاب",
    "الإصرار طريق النجاح",
    "الأمل يفتح أبواب الغد",
    "الثقة بالنفس سر التفوق",
    "العمل الجاد يصنع المعجزات",
    "العزيمة تصنع المستحيل",
    "كل يوم فرصة جديدة",
    "الحلم بداية الإنجاز",
    "النجاح يحتاج إلى صبر",
    "التفاؤل يضيء الطريق",
    "الطموح لا يعرف حدوداً",
    "العمل يسبق الكلام",
    "الثقة تفتح الأبواب المغلقة",
    "النجاح ثمرة الجهد المستمر",
    "الإيجابية تجذب الخير",
    "التحديات تصنع الأبطال",
    "النجاح يبدأ بخطوة",
    "العمل الجماعي سر القوة",
    "الطريق الطويل يبدأ بخطوة",
    "الإبداع يولد من الشغف",
    "النجاح لا يأتي صدفة",
    "الطموح يرفعك عالياً",
    "الجدية تصنع الفرق",
    "التفاؤل سر السعادة",
    "العمل الدؤوب يحقق الأحلام",
    "الثقة بالنفس أساس النجاح",
    "الأمل لا يموت أبداً",
    "النجاح يحتاج إلى عزيمة",
    "الإصرار يحقق المستحيل",
  ];

  @override
  void initState() {
    super.initState();
    _ensureStateLists();
  }

  void _ensureStateLists() {
    if (counters == null || counters!.length != affirmations.length) {
      counters = List.generate(affirmations.length, (_) => 0);
    }

    if (likedCards == null || likedCards!.length != affirmations.length) {
      likedCards = List.generate(affirmations.length, (_) => false);
    }

    if (cardColors == null || cardColors!.length != affirmations.length) {
      final random = Random();
      cardColors = List.generate(
        affirmations.length,
        (_) => colors[random.nextInt(colors.length)],
      );
    }
  }

  // ➕ Like/Unlike Card
  void toggleLike(int index) {
    setState(() {
      _ensureStateLists();
      likedCards![index] = !likedCards![index];
      if (likedCards![index]) {
        counters![index]++;
      }
    });
  }

  // ➕ Increment Counter
  void incrementCounter(int index) {
    setState(() {
      _ensureStateLists();
      counters![index]++;
    });
  }
void resetCounter(int index) {
    setState(() {
      _ensureStateLists();
      counters![index] = 0;
      likedCards![index] = false;
    });
  }
  // 🔁 Reset All
  void reset() {
    setState(() {
      counters = List.generate(affirmations.length, (_) => 0);
      likedCards = List.generate(affirmations.length, (_) => false);
    });
  }

  // 🔤 Update User Name
  void _showNameDialog() {
    nameController.text = userName;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "أدخل اسمك",
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(    
            hintText: "اسمك هنا",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("إلغاء", style: GoogleFonts.cairo()),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = nameController.text.isEmpty
                    ? "Your Name"
                    : nameController.text;
              });
              Navigator.pop(context);
            },
            child: Text("حفظ", style: GoogleFonts.cairo()),
          ),
        ],
      ),
    );
  }

  // 📱 Responsive Grid
  int getCrossAxisCount(double width) {
    if (width >= 1024) return 4; // Desktop
    if (width >= 600) return 3;  // Tablet
    return 1;                    // Mobile
  }

  // 🔤 Responsive Text Size
  double getAffirmationFontSize(double width) {
    if (width >= 1024) return 18;
    if (width >= 600) return 16;
    return 14;
  }

  double getCounterFontSize(double width) {
    if (width >= 1024) return 48;
    if (width >= 600) return 40;
    return 36;
  }

  @override
  Widget build(BuildContext context) {
    _ensureStateLists();
    final currentCounters = counters!;
    final currentLiked = likedCards!;
    final currentCardColors = cardColors!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
     appBar: AppBar(
  centerTitle: true,
  title: LayoutBuilder(
    builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "تطبيق التأكيدات الإيجابية",
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 22, // حجم ثابت لكن بيتصغر تلقائي
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );  
    },
  ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: GestureDetector(
                onTap: _showNameDialog,
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 20),
                    if (screenWidth >= 400) ...[
                      const SizedBox(width: 8),
                      Text(
                        userName,
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = getCrossAxisCount(constraints.maxWidth);

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: affirmations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final color = currentCardColors[index];
              final isLiked = currentLiked[index];

              return AffirmationCard(
                affirmation: affirmations[index],
                counter: currentCounters[index],
                backgroundColor: color,
                isLiked: isLiked,
                onLike: () => toggleLike(index),
                reset: () => resetCounter(index),
                affirmationFontSize: getAffirmationFontSize(screenWidth),
                counterFontSize: getCounterFontSize(screenWidth),
              );
            },
          );
        },
      ),

      // 🔄 Reset Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: reset,
        backgroundColor: const Color(0xFF6BBF59),
        icon: const Icon(Icons.refresh),
        label: Text(
          "إعادة تعيين",
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  
  
}

// 🎨 Affirmation Card Widget
class AffirmationCard extends StatelessWidget {
  final String affirmation;
  final int counter;
  final Color backgroundColor;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback reset;
  final double affirmationFontSize;
  final double counterFontSize;

  const AffirmationCard({
    required this.affirmation,
    required this.counter,
    required this.backgroundColor,
    required this.isLiked,
    required this.onLike,
    required this.reset,
    required this.affirmationFontSize,
    required this.counterFontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 💬 Affirmation Text
          Expanded(
            child: Center(
              child: Text(
                affirmation,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                softWrap: true,
                style: GoogleFonts.cairo(
                  fontSize: affirmationFontSize,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 🔢 Counter Display with decorative lines
          Column(
            children: [
              Container(
                height: 2,
                color: Colors.black.withOpacity(0.15),
                margin: const EdgeInsets.only(bottom: 8),
              ),
              Text(
                "$counter",
                style: TextStyle(
                  fontSize: counterFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 3, 3, 3),
                ),
              ),
              Container(
                height: 2,
                color: Colors.black.withOpacity(0.15),
                margin: const EdgeInsets.only(top: 8),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 🔘 Action Buttons
          Row(
            children: [
              // Like Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onLike,
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 18,
                  ),
                  label: Text(
                    isLiked ? "أعجبني" : "إعجاب",
                    style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isLiked ? const Color(0xFFFF6B6B) : Colors.grey[300],
                    foregroundColor: isLiked ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Reset Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: reset,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(
                    "تحديث",
                    style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF61C0BF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
}