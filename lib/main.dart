// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(const EchoTextProApp());

// class EchoTextProApp extends StatefulWidget {
//   const EchoTextProApp({super.key});

//   @override
//   State<EchoTextProApp> createState() => _EchoTextProAppState();
// }

// class _EchoTextProAppState extends State<EchoTextProApp> {
//   // persisted settings
//   bool _isDark = false;
//   ThemePalette _palette = ThemePalette.purplePink;

//   @override
//   void initState() {
//     super.initState();
//     _loadSettings();
//   }

//   Future<void> _loadSettings() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _isDark = prefs.getBool('isDark') ?? false;
//       final paletteIndex = prefs.getInt('paletteIndex') ?? 0;
//       _palette = ThemePalette.values[paletteIndex];
//     });
//   }

//   Future<void> _updateSettings(bool isDark, ThemePalette palette) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isDark', isDark);
//     await prefs.setInt('paletteIndex', palette.index);
//     setState(() {
//       _isDark = isDark;
//       _palette = palette;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeData = AppThemes.getTheme(_palette, false);
//     final darkThemeData = AppThemes.getTheme(_palette, true);

//     return MaterialApp(
//       title: 'EchoText Pro+',
//       debugShowCheckedModeBanner: false,
//       theme: themeData,
//       darkTheme: darkThemeData,
//       themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
//       home: HomeRoot(
//         isDark: _isDark,
//         palette: _palette,
//         onSettingsChanged: (isDark, palette) => _updateSettings(isDark, palette),
//       ),
//     );
//   }
// }

// /// ---------- Theme handling ----------
// enum ThemePalette { purplePink, blueCyan, goldOrange, tealIndigo }

// class PaletteColors {
//   final Color start;
//   final Color end;
//   final Color accent;
//   final Color card;
//   const PaletteColors({
//     required this.start,
//     required this.end,
//     required this.accent,
//     required this.card,
//   });
// }

// class AppThemes {
//   static PaletteColors paletteOf(ThemePalette p, bool dark) {
//     switch (p) {
//       case ThemePalette.blueCyan:
//         return PaletteColors(
//           start: dark ? const Color(0xFF0F172A) : const Color(0xFF3A9BF1),
//           end: dark ? const Color(0xFF1E293B) : const Color(0xFF00D4FF),
//           accent: dark ? const Color(0xFF60A5FA) : const Color(0xFF0366D6),
//           card: dark ? const Color(0xFF0F172A) : Colors.white,
//         );

//       case ThemePalette.goldOrange:
//         return PaletteColors(
//           start: dark ? const Color(0xFF2B1F0E) : const Color(0xFFF6C667),
//           end: dark ? const Color(0xFF402A11) : const Color(0xFFF08A2E),
//           accent: dark ? const Color(0xFFE6B86B) : const Color(0xFFC46A00),
//           card: dark ? const Color(0xFF22180F) : Colors.white,
//         );

//       case ThemePalette.tealIndigo:
//         return PaletteColors(
//           start: dark ? const Color(0xFF021026) : const Color(0xFF1BC5A9),
//           end: dark ? const Color(0xFF052033) : const Color(0xFF5D5FEF),
//           accent: dark ? const Color(0xFF4FD1C5) : const Color(0xFF0AA3A3),
//           card: dark ? const Color(0xFF081029) : Colors.white,
//         );

//       case ThemePalette.purplePink:
//       return PaletteColors(
//           start: dark ? const Color(0xFF120524) : const Color(0xFF9B59E8),
//           end: dark ? const Color(0xFF22093B) : const Color(0xFFC54FD0),
//           accent: dark ? const Color(0xFFAA6CF6) : const Color(0xFF7B30C7),
//           card: dark ? const Color(0xFF1B0E25) : Colors.white,
//         );
//     }
//   }

//   static ThemeData getTheme(ThemePalette palette, bool dark) {
//     final p = paletteOf(palette, dark);
//     final base = dark ? ThemeData.dark() : ThemeData.light();
//     return base.copyWith(
//       colorScheme: base.colorScheme.copyWith(
//         primary: p.accent,
//         secondary: p.end,
//       ),
//       primaryColor: p.accent,
//       scaffoldBackgroundColor: dark ? const Color(0xFF080812) : const Color(0xFFF5F3FF),
//       appBarTheme: AppBarTheme(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         titleTextStyle: TextStyle(
//           color: dark ? Colors.white : Colors.white,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       cardColor: p.card,
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: p.accent,
//       ),
//     );
//   }
// }

// /// ---------- Root & Navigation ----------
// class HomeRoot extends StatefulWidget {
//   final bool isDark;
//   final ThemePalette palette;
//   final void Function(bool, ThemePalette) onSettingsChanged;

//   const HomeRoot({
//     super.key,
//     required this.isDark,
//     required this.palette,
//     required this.onSettingsChanged,
//   });

//   @override
//   State<HomeRoot> createState() => _HomeRootState();
// }

// class _HomeRootState extends State<HomeRoot> {
//   int _selectedIndex = 0;

//   // pass state down to pages via constructor
//   late bool _isDark;
//   late ThemePalette _palette;

//   @override
//   void initState() {
//     super.initState();
//     _isDark = widget.isDark;
//     _palette = widget.palette;
//   }

//   void _onSettingsUpdated(bool isDark, ThemePalette palette) {
//     setState(() {
//       _isDark = isDark;
//       _palette = palette;
//     });
//     widget.onSettingsChanged(isDark, palette);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pages = <Widget>[
//       HomePage(
//         palette: _palette,
//         isDark: _isDark,
//       ),
//       HistoryPage(palette: _palette, isDark: _isDark),
//       SettingsPage(
//         isDark: _isDark,
//         selectedPalette: _palette,
//         onApply: _onSettingsUpdated,
//       ),
//     ];

//     final paletteColors = AppThemes.paletteOf(_palette, _isDark);

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       // Animated gradient app bar (shared)
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(76),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 550),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [paletteColors.start, paletteColors.end],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
//             // ignore: deprecated_member_use
//             boxShadow: [BoxShadow(color: paletteColors.end.withOpacity(0.18), blurRadius: 18, offset: const Offset(0, 8))],
//           ),
//           child: SafeArea(
//             child: Row(
//               children: [
//                 const SizedBox(width: 16),
//                 Text(
//                   ['EchoText', 'History', 'Settings'][_selectedIndex],
//                   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   onPressed: () => SystemSound.play(SystemSoundType.click),
//                   icon: const Icon(Icons.info_outline, color: Colors.white),
//                   tooltip: 'About',
//                 ),
//                 const SizedBox(width: 8),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         selectedItemColor: paletteColors.accent,
//         unselectedItemColor: Colors.grey,
//         onTap: (i) => setState(() => _selectedIndex = i),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
//         ],
//       ),
//     );
//   }
// }

// /// ---------- Home Page (compose & save) ----------
// class HomePage extends StatefulWidget {
//   final ThemePalette palette;
//   final bool isDark;
//   const HomePage({super.key, required this.palette, required this.isDark});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _controller = TextEditingController();
//   String _display = '';
//   bool _typing = false;

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _typeAndShow(String text) async {
//     setState(() {
//       _display = '';
//       _typing = true;
//     });
//     for (int i = 0; i < text.length; i++) {
//       await Future.delayed(const Duration(milliseconds: 20));
//       setState(() {
//         _display += text[i];
//       });
//     }
//     setState(() => _typing = false);
//   }

//   Future<void> _saveMessage(String msg) async {
//     if (msg.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter some text first')));
//       return;
//     }
//     final prefs = await SharedPreferences.getInstance();
//     final list = prefs.getStringList('history') ?? <String>[];
//     final entry = jsonEncode({
//       'text': msg,
//       'time': DateTime.now().toIso8601String(),
//     });
//     list.insert(0, entry);
//     await prefs.setStringList('history', list);

//     HapticFeedback.selectionClick();
//     SystemSound.play(SystemSoundType.click);

//     // ignore: use_build_context_synchronously
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to History')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final paletteColors = AppThemes.paletteOf(widget.palette, widget.isDark);
//     return Stack(
//       children: [
//         // animated background
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 600),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               // ignore: deprecated_member_use
//               colors: [paletteColors.start.withOpacity(0.12), paletteColors.end.withOpacity(0.06)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.fromLTRB(20, 28, 20, 100),
//             child: Column(
//               children: [
//                 Card(
//                   elevation: 10,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.edit, color: paletteColors.accent),
//                             const SizedBox(width: 10),
//                             Text('Compose', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: paletteColors.accent)),
//                             const Spacer(),
//                             IconButton(
//                               tooltip: 'Clear',
//                               onPressed: () {
//                                 _controller.clear();
//                                 setState(() => _display = '');
//                               },
//                               icon: const Icon(Icons.clear),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         TextField(
//                           minLines: 1,
//                           maxLines: 6,
//                           controller: _controller,
//                           decoration: InputDecoration(
//                             hintText: 'Type something short note, reminder, quote...',
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                             filled: true,
//                             fillColor: Theme.of(context).cardColor,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                        Row(
//   children: [
//     Expanded(
//       child: ElevatedButton.icon(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.white,
//           foregroundColor: paletteColors.accent,
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 14),
//         ),
//         onPressed: () async {
//           final input = _controller.text.trim();
//           await _typeAndShow(input);
//           HapticFeedback.mediumImpact();
//         },
//         icon: Icon(Icons.visibility, color: paletteColors.accent),
//         label: Text(
//           "Preview",
//           style: TextStyle(
//             color: paletteColors.accent,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     ),
//     const SizedBox(width: 10),
//     Expanded(
//       child: ElevatedButton.icon(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: paletteColors.accent,
//           foregroundColor: Colors.white,
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 14),
//         ),
//         onPressed: () async {
//           final input = _controller.text.trim();
//           await _saveMessage(input);
//         },
//         icon: const Icon(Icons.save_outlined, color: Colors.white),
//         label: const Text(
//           "Save",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     ),
//   ],
// ),

//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 28),
//                 // Display Card
//                 AnimatedOpacity(
//                   opacity: _display.isEmpty ? 0.0 : 1.0,
//                   duration: const Duration(milliseconds: 400),
//                   child: Card(
//                     color: Theme.of(context).cardColor,
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(18.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text("Here’s What You Wrote", style: TextStyle(fontWeight: FontWeight.w700, color: paletteColors.accent)),
//                               const Spacer(),
//                               IconButton(
//                                 tooltip: 'Copy',
//                                 onPressed: () {
//                                   if (_display.isEmpty) return;
//                                   Clipboard.setData(ClipboardData(text: _display));
//                                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied')));
//                                 },
//                                 icon: Icon(Icons.copy, color: paletteColors.accent),
//                               )
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           SelectableText(
//                             _display.isEmpty ? '' : _display,
//                             style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.w600),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(_typing ? 'typing...' : '—', style: const TextStyle(color: Colors.grey)),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// ---------- History Page ----------
// class HistoryPage extends StatefulWidget {
//   final ThemePalette palette;
//   final bool isDark;
//   const HistoryPage({super.key, required this.palette, required this.isDark});

//   @override
//   State<HistoryPage> createState() => _HistoryPageState();
// }

// class _HistoryPageState extends State<HistoryPage> {
//   List<Map<String, dynamic>> _entries = [];
//   bool _loading = true;
  
//   // ignore: non_constant_identifier_names
//   get shared_preferences => null;

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     setState(() => _loading = true);
//     final prefs = await SharedPreferences.getInstance();
//     final list = prefs.getStringList('history') ?? [];
//     _entries = list.map((s) {
//       final m = jsonDecode(s) as Map<String, dynamic>;
//       return {
//         'text': m['text'] as String,
//         'time': DateTime.parse(m['time'] as String),
//       };
//     }).toList();
//     setState(() => _loading = false);
//   }

//   Future<void> _deleteEntry(int index) async {
//     final prefs = await shared_preferences.getInstance();
//     final list = prefs.getStringList('history') ?? [];
//     list.removeAt(index);
//     await prefs.setStringList('history', list);
//     await _loadHistory();
//     HapticFeedback.selectionClick();
//     // ignore: use_build_context_synchronously
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted')));
//   }

//   Future<void> _clearAll() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('history');
//     await _loadHistory();
//     HapticFeedback.heavyImpact();
//     // ignore: use_build_context_synchronously
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('History Cleared')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final paletteColors = AppThemes.paletteOf(widget.palette, widget.isDark);

//     return SafeArea(
//       child: Stack(
//         children: [
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 500),
//             decoration: BoxDecoration(
//               // ignore: deprecated_member_use
//               gradient: LinearGradient(colors: [paletteColors.start.withOpacity(0.08), paletteColors.end.withOpacity(0.03)]),
//             ),
//           ),
//           Column(
//             children: [
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: Row(
//                   children: [
//                     Text('Saved Messages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: paletteColors.accent)),
//                     const Spacer(),
//                     IconButton(
//                       tooltip: 'Clear All',
//                       onPressed: _entries.isEmpty ? null : () async {
//                         final confirm = await showDialog<bool>(
//                           context: context,
//                           builder: (c) => AlertDialog(
//                             title: const Text('Clear all history?'),
//                             content: const Text('This will permanently remove all saved messages.'),
//                             actions: [
//                               TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
//                               TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Clear')),
//                             ],
//                           ),
//                         );
//                         if (confirm == true) await _clearAll();
//                       },
//                       icon: Icon(Icons.delete_sweep, color: paletteColors.accent),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: _loading
//                     ? const Center(child: CircularProgressIndicator())
//                     : _entries.isEmpty
//                         ? const Center(child: Text('No saved messages yet'))
//                         : RefreshIndicator(
//                             onRefresh: _loadHistory,
//                             child: ListView.separated(
//                               padding: const EdgeInsets.all(16),
//                               itemCount: _entries.length,
//                               separatorBuilder: (_, __) => const SizedBox(height: 12),
//                               itemBuilder: (context, idx) {
//                                 final e = _entries[idx];
//                                 final t = e['time'] as DateTime;
//                                 final formatted = "${t.year}-${_two(t.month)}-${_two(t.day)} ${_two(t.hour)}:${_two(t.minute)}";
//                                 return Card(
//                                   elevation: 6,
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                                   child: ListTile(
//                                     title: SelectableText(e['text'] as String),
//                                     subtitle: Text(formatted),
//                                     trailing: PopupMenuButton<int>(
//                                       onSelected: (v) async {
//                                         if (v == 0) {
//                                           Clipboard.setData(ClipboardData(text: e['text'] as String));
//                                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied')));
//                                         } else if (v == 1) {
//                                           await _deleteEntry(idx);
//                                         }
//                                       },
//                                       itemBuilder: (_) => const [
//                                         PopupMenuItem(value: 0, child: Text('Copy')),
//                                         PopupMenuItem(value: 1, child: Text('Delete')),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   static String _two(int n) => n.toString().padLeft(2, '0');
// }

// /// ---------- Settings Page ----------
// class SettingsPage extends StatefulWidget {
//   final bool isDarkMode;
//   final bool isDark;
//   final ThemePalette selectedPalette;
//   final void Function(bool, ThemePalette) onApply;

//   const SettingsPage({
//     super.key,
//     required this.isDark,
//     required this.selectedPalette,
//     required this.onApply,
//     this.isDarkMode = false,
//   });

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   late bool _isDark;
//   late ThemePalette _palette;

//   @override
//   void initState() {
//     super.initState();
//     _isDark = widget.isDark;
//     _palette = widget.selectedPalette;
//   }

//   Future<void> _apply() async {
//     // also persist settings at top-level (handled by callback)
//     widget.onApply(_isDark, _palette);
//     HapticFeedback.mediumImpact();
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings applied')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final palettes = ThemePalette.values;
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(18, 28, 18, 18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Theme', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 const Text('Dark Mode'),
//                 const Spacer(),
//                 Switch(
//                   value: _isDark,
//                   onChanged: (v) => setState(() => _isDark = v),
//                 )
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Text('Color Palette', style: TextStyle(fontWeight: FontWeight.w600)),
//             const SizedBox(height: 10),
//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: palettes.map((p) {
//                 final colors = AppThemes.paletteOf(p, _isDark);
//                 final isSelected = p == _palette;
//                 return GestureDetector(
//                   onTap: () => setState(() => _palette = p),
//                   child: Container(
//                     width: 120,
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: isSelected ? colors.accent : Colors.transparent, width: 2),
//                       gradient: LinearGradient(colors: [colors.start, colors.end]),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(p.name.splitMapJoin(RegExp(r'([A-Z])'), onMatch: (m)=>' ${m.group(0)}').trim(),
//                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Container(width: 18, height: 18, decoration: BoxDecoration(color: colors.accent, shape: BoxShape.circle)),
//                             const SizedBox(width: 8),
//                             Expanded(child: Text(_isDark ? 'Dark preview' : 'Light preview', style: const TextStyle(color: Colors.white70, fontSize: 12))),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: _apply,
//                   child: const Text('Apply'),
//                 ),
//                 const SizedBox(width: 12),
//                 OutlinedButton(
//                   onPressed: () async {
//                     final prefs = await SharedPreferences.getInstance();
//                     await prefs.remove('isDark');
//                     await prefs.remove('paletteIndex');
//                     setState(() {
//                       _isDark = false;
//                       _palette = ThemePalette.purplePink;
//                     });
//                     widget.onApply(_isDark, _palette);
//                     // ignore: use_build_context_synchronously
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset to defaults')));
//                   },
//                   child: const Text('Reset'),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }







import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const EchoTextProApp());

/// ------------------- App -------------------
class EchoTextProApp extends StatefulWidget {
  const EchoTextProApp({super.key});

  @override
  State<EchoTextProApp> createState() => _EchoTextProAppState();
}

class _EchoTextProAppState extends State<EchoTextProApp> {
  // persisted settings
  bool _isDark = false;
  ThemePalette _palette = ThemePalette.purplePink;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDark = prefs.getBool('isDark') ?? false;
      final paletteIndex = prefs.getInt('paletteIndex') ?? 0;
      _palette = ThemePalette.values[paletteIndex];
    });
  }

  Future<void> _updateSettings(bool isDark, ThemePalette palette) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
    await prefs.setInt('paletteIndex', palette.index);
    setState(() {
      _isDark = isDark;
      _palette = palette;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = AppThemes.getTheme(_palette, false);
    final darkThemeData = AppThemes.getTheme(_palette, true);

    return MaterialApp(
      title: 'EchoText Pro+',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      darkTheme: darkThemeData,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: HomeRoot(
        isDark: _isDark,
        palette: _palette,
        onSettingsChanged: (isDark, palette) => _updateSettings(isDark, palette),
      ),
    );
  }
}

/// ---------- Theme handling ----------
enum ThemePalette { purplePink, blueCyan, goldOrange, tealIndigo }

class PaletteColors {
  final Color start;
  final Color end;
  final Color accent;
  final Color card;
  const PaletteColors({
    required this.start,
    required this.end,
    required this.accent,
    required this.card,
  });
}

class AppThemes {
  static PaletteColors paletteOf(ThemePalette p, bool dark) {
    switch (p) {
      case ThemePalette.blueCyan:
        return PaletteColors(
          start: dark ? const Color(0xFF0F172A) : const Color(0xFF3A9BF1),
          end: dark ? const Color(0xFF1E293B) : const Color(0xFF00D4FF),
          accent: dark ? const Color(0xFF60A5FA) : const Color(0xFF0366D6),
          card: dark ? const Color(0xFF0F172A) : Colors.white,
        );

      case ThemePalette.goldOrange:
        return PaletteColors(
          start: dark ? const Color(0xFF2B1F0E) : const Color(0xFFF6C667),
          end: dark ? const Color(0xFF402A11) : const Color(0xFFF08A2E),
          accent: dark ? const Color(0xFFE6B86B) : const Color(0xFFC46A00),
          card: dark ? const Color(0xFF22180F) : Colors.white,
        );

      case ThemePalette.tealIndigo:
        return PaletteColors(
          start: dark ? const Color(0xFF021026) : const Color(0xFF1BC5A9),
          end: dark ? const Color(0xFF052033) : const Color(0xFF5D5FEF),
          accent: dark ? const Color(0xFF4FD1C5) : const Color(0xFF0AA3A3),
          card: dark ? const Color(0xFF081029) : Colors.white,
        );

      case ThemePalette.purplePink:
      return PaletteColors(
          start: dark ? const Color(0xFF120524) : const Color(0xFF9B59E8),
          end: dark ? const Color(0xFF22093B) : const Color(0xFFC54FD0),
          accent: dark ? const Color(0xFFAA6CF6) : const Color(0xFF7B30C7),
          card: dark ? const Color(0xFF1B0E25) : Colors.white,
        );
    }
  }

  static ThemeData getTheme(ThemePalette palette, bool dark) {
    final p = paletteOf(palette, dark);
    final base = dark ? ThemeData.dark() : ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: p.accent,
        secondary: p.end,
      ),
      primaryColor: p.accent,
      scaffoldBackgroundColor: dark ? const Color(0xFF080812) : const Color(0xFFF5F3FF),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: dark ? Colors.white : Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardColor: p.card,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: p.accent,
      ),
    );
  }
}

/// ---------- Notification model & storage helpers ----------
class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime time;
  bool read;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    this.read = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'time': time.toIso8601String(),
        'read': read,
      };

  static AppNotification fromJson(Map<String, dynamic> m) => AppNotification(
        id: m['id'] as String,
        title: m['title'] as String,
        body: m['body'] as String,
        time: DateTime.parse(m['time'] as String),
        read: m['read'] as bool? ?? false,
      );
}

class NotificationStore {
  static const _key = 'app_notifications';

  static Future<List<AppNotification>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw.map((s) => AppNotification.fromJson(jsonDecode(s) as Map<String, dynamic>)).toList();
  }

  static Future<void> save(List<AppNotification> list) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = list.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(_key, raw);
  }

  static Future<void> add(AppNotification n) async {
    final list = await load();
    list.insert(0, n);
    await save(list);
  }
}

/// ---------- Root & Navigation ----------
class HomeRoot extends StatefulWidget {
  final bool isDark;
  final ThemePalette palette;
  final void Function(bool, ThemePalette) onSettingsChanged;

  const HomeRoot({
    super.key,
    required this.isDark,
    required this.palette,
    required this.onSettingsChanged,
  });

  @override
  State<HomeRoot> createState() => _HomeRootState();
}

class _HomeRootState extends State<HomeRoot> {
  int _selectedIndex = 0;

  // pass state down to pages via constructor
  late bool _isDark;
  late ThemePalette _palette;

  // notifications badge
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
    _palette = widget.palette;
    _loadUnreadCount();
    // listen for when returning from notification center to refresh badge
    // (no streams used — we refresh on resume)
  }

  Future<void> _loadUnreadCount() async {
    final list = await NotificationStore.load();
    final unread = list.where((n) => !n.read).length;
    setState(() => _unreadCount = unread);
  }

  void _onSettingsUpdated(bool isDark, ThemePalette palette) {
    setState(() {
      _isDark = isDark;
      _palette = palette;
    });
    widget.onSettingsChanged(isDark, palette);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(
        palette: _palette,
        isDark: _isDark,
        onNotify: _handleManualNotificationFromHome,
      ),
      HistoryPage(palette: _palette, isDark: _isDark),
      SettingsPage(
        isDark: _isDark,
        selectedPalette: _palette,
        onApply: _onSettingsUpdated,
      ),
    ];

    final paletteColors = AppThemes.paletteOf(_palette, _isDark);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // Animated gradient app bar (shared)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(76),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 550),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [paletteColors.start, paletteColors.end],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
            // ignore: deprecated_member_use
            boxShadow: [BoxShadow(color: paletteColors.end.withOpacity(0.18), blurRadius: 18, offset: const Offset(0, 8))],
          ),
          child: SafeArea(
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  ['EchoText', 'History', 'Settings'][_selectedIndex],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Spacer(),
                // Menu items popup
                PopupMenuButton<String>(
                  tooltip: 'Menu',
                  onSelected: (v) async {
                    if (v == 'about') {
                      showAboutDialog(
                        context: context,
                        applicationName: 'EchoText Pro+',
                        applicationVersion: '1.0',
                        applicationLegalese: '© EchoText',
                        children: [const Text('A small sample app with notifications.')],
                      );
                    } else if (v == 'help') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open Help (not implemented)')));
                    } else if (v == 'clear_notifications') {
                      final list = await NotificationStore.load();
                      for (var n in list) {
                        n.read = true;
                      }
                      await NotificationStore.save(list);
                      await _loadUnreadCount();
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notifications marked read')));
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'about', child: Text('About')),
                    PopupMenuItem(value: 'help', child: Text('Help')),
                    PopupMenuItem(value: 'clear_notifications', child: Text('Mark notifications read')),
                  ],
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                ),
                const SizedBox(width: 8),
                // Notification icon with badge
                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => NotificationCenterPage()));
                    await _loadUnreadCount(); // refresh after returning
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.notifications, color: Colors.white, size: 26),
                        if (_unreadCount > 0)
                          Positioned(
                            right: -6,
                            top: -6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                              child: Center(
                                child: Text(
                                  _unreadCount > 99 ? '99+' : '$_unreadCount',
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: paletteColors.accent,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Future<void> _handleManualNotificationFromHome(String title, String body) async {
    final n = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      time: DateTime.now(),
      read: false,
    );
    await NotificationStore.add(n);
    await _loadUnreadCount();
    // show a snackbar to confirm
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification created')));
  }
}

/// ---------- Home Page (compose & save) ----------
class HomePage extends StatefulWidget {
  final ThemePalette palette;
  final bool isDark;
  final Future<void> Function(String title, String body)? onNotify;

  const HomePage({super.key, required this.palette, required this.isDark, this.onNotify});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String _display = '';
  bool _typing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _typeAndShow(String text) async {
    setState(() {
      _display = '';
      _typing = true;
    });
    for (int i = 0; i < text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      setState(() {
        _display += text[i];
      });
    }
    setState(() => _typing = false);
  }

  Future<void> _saveMessage(String msg) async {
    if (msg.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter some text first')));
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('history') ?? <String>[];
    final entry = jsonEncode({
      'text': msg,
      'time': DateTime.now().toIso8601String(),
    });
    list.insert(0, entry);
    await prefs.setStringList('history', list);

    HapticFeedback.selectionClick();
    SystemSound.play(SystemSoundType.click);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to History')));
  }

  Future<void> _sendNotificationNow() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Type message to notify')));
      return;
    }
    // create an in-app notification
    if (widget.onNotify != null) {
      await widget.onNotify!('New Note', text);
    } else {
      final n = AppNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Note',
        body: text,
        time: DateTime.now(),
        read: false,
      );
      await NotificationStore.add(n);
    }

    // give immediate user feedback
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification sent (in-app)')));
  }

  Future<void> _scheduleNotification(int seconds) async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Type message to schedule')));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Will create notification in $seconds seconds')));
    Timer(Duration(seconds: seconds), () async {
      final n = AppNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Scheduled Note',
        body: text,
        time: DateTime.now(),
        read: false,
      );
      await NotificationStore.add(n);
      // if still mounted, show a little SnackBar to confirm
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Scheduled notification fired (in-app)')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final paletteColors = AppThemes.paletteOf(widget.palette, widget.isDark);
    return Stack(
      children: [
        // animated background
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // ignore: deprecated_member_use
              colors: [paletteColors.start.withOpacity(0.12), paletteColors.end.withOpacity(0.06)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 100),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.edit, color: paletteColors.accent),
                            const SizedBox(width: 10),
                            Text('Compose', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: paletteColors.accent)),
                            const Spacer(),
                            IconButton(
                              tooltip: 'Clear',
                              onPressed: () {
                                _controller.clear();
                                setState(() => _display = '');
                              },
                              icon: const Icon(Icons.clear),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          minLines: 1,
                          maxLines: 6,
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Type something short note, reminder, quote...',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: paletteColors.accent,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                onPressed: () async {
                                  final input = _controller.text.trim();
                                  await _typeAndShow(input);
                                  HapticFeedback.mediumImpact();
                                },
                                icon: Icon(Icons.visibility, color: paletteColors.accent),
                                label: Text(
                                  "Preview",
                                  style: TextStyle(
                                    color: paletteColors.accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: paletteColors.accent,
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                onPressed: () async {
                                  final input = _controller.text.trim();
                                  await _saveMessage(input);
                                },
                                icon: const Icon(Icons.save_outlined, color: Colors.white),
                                label: const Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Notification action row
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _sendNotificationNow,
                                icon: const Icon(Icons.notifications_active_outlined),
                                label: const Text('Notify now'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _scheduleNotification(5),
                                icon: const Icon(Icons.schedule),
                                label: const Text('Notify in 5s'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // Display Card
                AnimatedOpacity(
                  opacity: _display.isEmpty ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 400),
                  child: Card(
                    color: Theme.of(context).cardColor,
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Here’s What You Wrote", style: TextStyle(fontWeight: FontWeight.w700, color: paletteColors.accent)),
                              const Spacer(),
                              IconButton(
                                tooltip: 'Copy',
                                onPressed: () {
                                  if (_display.isEmpty) return;
                                  Clipboard.setData(ClipboardData(text: _display));
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied')));
                                },
                                icon: Icon(Icons.copy, color: paletteColors.accent),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            _display.isEmpty ? '' : _display,
                            style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(_typing ? 'typing...' : '—', style: const TextStyle(color: Colors.grey)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------- Notification Center Page ----------
class NotificationCenterPage extends StatefulWidget {
  const NotificationCenterPage({super.key});

  @override
  State<NotificationCenterPage> createState() => _NotificationCenterPageState();
}

class _NotificationCenterPageState extends State<NotificationCenterPage> {
  List<AppNotification> _list = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    _list = await NotificationStore.load();
    setState(() => _loading = false);
  }

  Future<void> _toggleRead(int idx) async {
    _list[idx].read = !_list[idx].read;
    await NotificationStore.save(_list);
    setState(() {});
  }

  Future<void> _delete(int idx) async {
    _list.removeAt(idx);
    await NotificationStore.save(_list);
    setState(() {});
  }

  Future<void> _clearAll() async {
    _list.clear();
    await NotificationStore.save(_list);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            tooltip: 'Clear all',
            onPressed: _list.isEmpty
                ? null
                : () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: const Text('Clear all notifications?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Clear')),
                        ],
                      ),
                    );
                    if (ok == true) await _clearAll();
                  },
            icon: const Icon(Icons.delete_forever_outlined),
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _list.isEmpty
              ? const Center(child: Text('No notifications yet'))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: _list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, idx) {
                      final n = _list[idx];
                      final formatted = "${n.time.year}-${_two(n.time.month)}-${_two(n.time.day)} ${_two(n.time.hour)}:${_two(n.time.minute)}";
                      return Card(
                        // ignore: deprecated_member_use
                        color: n.read ? Theme.of(context).cardColor.withOpacity(0.9) : null,
                        child: ListTile(
                          leading: Icon(n.read ? Icons.notifications_none : Icons.notifications_active, color: n.read ? Colors.grey : Colors.blueAccent),
                          title: Text(n.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${n.body}\n$formatted'),
                          isThreeLine: true,
                          trailing: PopupMenuButton<int>(
                            onSelected: (v) async {
                              if (v == 0) await _toggleRead(idx);
                              if (v == 1) await _delete(idx);
                            },
                            itemBuilder: (_) => [
                              PopupMenuItem(value: 0, child: Text(n.read ? 'Mark unread' : 'Mark read')),
                              const PopupMenuItem(value: 1, child: Text('Delete')),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  static String _two(int n) => n.toString().padLeft(2, '0');
}

/// ---------- History Page ----------
class HistoryPage extends StatefulWidget {
  final ThemePalette palette;
  final bool isDark;
  const HistoryPage({super.key, required this.palette, required this.isDark});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _entries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('history') ?? [];
    _entries = list.map((s) {
      final m = jsonDecode(s) as Map<String, dynamic>;
      return {
        'text': m['text'] as String,
        'time': DateTime.parse(m['time'] as String),
      };
    }).toList();
    setState(() => _loading = false);
  }

  Future<void> _deleteEntry(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('history') ?? [];
    list.removeAt(index);
    await prefs.setStringList('history', list);
    await _loadHistory();
    HapticFeedback.selectionClick();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted')));
  }

  Future<void> _clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
    await _loadHistory();
    HapticFeedback.heavyImpact();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('History Cleared')));
  }

  @override
  Widget build(BuildContext context) {
    final paletteColors = AppThemes.paletteOf(widget.palette, widget.isDark);

    return SafeArea(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              gradient: LinearGradient(colors: [paletteColors.start.withOpacity(0.08), paletteColors.end.withOpacity(0.03)]),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text('Saved Messages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: paletteColors.accent)),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Clear All',
                      onPressed: _entries.isEmpty
                          ? null
                          : () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (c) => AlertDialog(
                                  title: const Text('Clear all history?'),
                                  content: const Text('This will permanently remove all saved messages.'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                                    TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Clear')),
                                  ],
                                ),
                              );
                              if (confirm == true) await _clearAll();
                            },
                      icon: Icon(Icons.delete_sweep, color: paletteColors.accent),
                    )
                  ],
                ),
              ),
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : _entries.isEmpty
                        ? const Center(child: Text('No saved messages yet'))
                        : RefreshIndicator(
                            onRefresh: _loadHistory,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemCount: _entries.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, idx) {
                                final e = _entries[idx];
                                final t = e['time'] as DateTime;
                                final formatted = "${t.year}-${_two(t.month)}-${_two(t.day)} ${_two(t.hour)}:${_two(t.minute)}";
                                return Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  child: ListTile(
                                    title: SelectableText(e['text'] as String),
                                    subtitle: Text(formatted),
                                    trailing: PopupMenuButton<int>(
                                      onSelected: (v) async {
                                        if (v == 0) {
                                          Clipboard.setData(ClipboardData(text: e['text'] as String));
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied')));
                                        } else if (v == 1) {
                                          await _deleteEntry(idx);
                                        }
                                      },
                                      itemBuilder: (_) => const [
                                        PopupMenuItem(value: 0, child: Text('Copy')),
                                        PopupMenuItem(value: 1, child: Text('Delete')),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              )
            ],
          ),
        ],
      ),
    );
  }

  static String _two(int n) => n.toString().padLeft(2, '0');
}

/// ---------- Settings Page ----------
class SettingsPage extends StatefulWidget {
  final bool isDark;
  final ThemePalette selectedPalette;
  final void Function(bool, ThemePalette) onApply;

  const SettingsPage({
    super.key,
    required this.isDark,
    required this.selectedPalette,
    required this.onApply,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDark;
  late ThemePalette _palette;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
    _palette = widget.selectedPalette;
  }

  Future<void> _apply() async {
    // also persist settings at top-level (handled by callback)
    widget.onApply(_isDark, _palette);
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings applied')));
  }

  @override
  Widget build(BuildContext context) {
    final palettes = ThemePalette.values;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 28, 18, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Dark Mode'),
                const Spacer(),
                Switch(
                  value: _isDark,
                  onChanged: (v) => setState(() => _isDark = v),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text('Color Palette', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: palettes.map((p) {
                final colors = AppThemes.paletteOf(p, _isDark);
                final isSelected = p == _palette;
                return GestureDetector(
                  onTap: () => setState(() => _palette = p),
                  child: Container(
                    width: 120,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? colors.accent : Colors.transparent, width: 2),
                      gradient: LinearGradient(colors: [colors.start, colors.end]),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name.splitMapJoin(RegExp(r'([A-Z])'), onMatch: (m)=>' ${m.group(0)}').trim(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(width: 18, height: 18, decoration: BoxDecoration(color: colors.accent, shape: BoxShape.circle)),
                            const SizedBox(width: 8),
                            Expanded(child: Text(_isDark ? 'Dark preview' : 'Light preview', style: const TextStyle(color: Colors.white70, fontSize: 12))),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _apply,
                  child: const Text('Apply'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('isDark');
                    await prefs.remove('paletteIndex');
                    setState(() {
                      _isDark = false;
                      _palette = ThemePalette.purplePink;
                    });
                    widget.onApply(_isDark, _palette);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset to defaults')));
                  },
                  child: const Text('Reset'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
