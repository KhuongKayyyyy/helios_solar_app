import "package:flutter/material.dart";
import "package:helios/core/util/extensions.dart";
import "package:helios/data/models/field/panel_group.dart";
import "package:helios/presentation/components/app_text.dart";
import "package:helios/presentation/widget/item/panel_group_item.dart";

class PanelGroupList extends StatefulWidget {
  const PanelGroupList({super.key});

  @override
  State<PanelGroupList> createState() => _PanelGroupListState();
}

class _PanelGroupListState extends State<PanelGroupList>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _showDropdown = false;
  final List<PanelGroup> _panelGroups = PanelGroup.getMockData();
  late AnimationController _stackAnimationController;
  late AnimationController _dropdownAnimationController;

  @override
  void initState() {
    super.initState();
    _stackAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _dropdownAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _stackAnimationController.dispose();
    _dropdownAnimationController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentIndex = index;
      _showDropdown = false;
    });
    _dropdownAnimationController.reverse();
  }

  void _navigateToFirst() {
    _navigateToPage(0);
  }

  void _navigateToLast() {
    _navigateToPage(_panelGroups.length - 1);
  }

  void _toggleDropdown() {
    setState(() {
      _showDropdown = !_showDropdown;
    });
    if (_showDropdown) {
      _dropdownAnimationController.forward();
    } else {
      _dropdownAnimationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          text: "Panel Groups",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        16.y,
        // Animated Dropdown menu
        AnimatedBuilder(
          animation: _dropdownAnimationController,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                heightFactor: _dropdownAnimationController.value,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _panelGroups.length,
                    itemBuilder: (context, index) {
                      final isSelected = index == _currentIndex;
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _navigateToPage(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFE6F3A5).withOpacity(0.3)
                                  : Colors.transparent,
                              borderRadius: index == 0
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    )
                                  : index == _panelGroups.length - 1
                                  ? const BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    )
                                  : BorderRadius.zero,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: _panelGroups[index].name ?? '',
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.grey[700],
                                  ),
                                ),
                                AppText(
                                  text: _panelGroups[index].powerRating ?? '',
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),

        // Enhanced Bottom navigation bar with animations
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // First button with animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  onPressed: _currentIndex > 0 ? _navigateToFirst : null,
                  icon: const Icon(Icons.first_page),
                  color: _currentIndex > 0 ? Colors.black : Colors.grey[400],
                ),
              ),

              // Enhanced dropdown toggle button
              Expanded(
                child: InkWell(
                  onTap: _toggleDropdown,
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: _showDropdown
                          ? const Color(0xFFE6F3A5).withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: AppText(
                              text: _panelGroups[_currentIndex].name ?? '',
                              key: ValueKey(_currentIndex),
                              textAlign: TextAlign.center,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedRotation(
                          turns: _showDropdown ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Last button with animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  onPressed: _currentIndex < _panelGroups.length - 1
                      ? _navigateToLast
                      : null,
                  icon: const Icon(Icons.last_page),
                  color: _currentIndex < _panelGroups.length - 1
                      ? Colors.black
                      : Colors.grey[400],
                ),
              ),
            ],
          ),
        ),

        // Main content with stacked cards animation
        SizedBox(
          height: 440,
          child: Stack(
            children: [
              // Background stacked cards
              for (int i = 0; i < _panelGroups.length && i < 3; i++)
                AnimatedBuilder(
                  animation: _stackAnimationController,
                  builder: (context, child) {
                    final offset =
                        (i * 8.0) * (1.0 - _stackAnimationController.value);
                    final scale =
                        1.0 -
                        (i * 0.05) * (1.0 - _stackAnimationController.value);
                    final opacity = i == 0
                        ? 1.0
                        : 0.3 + (0.7 * _stackAnimationController.value);

                    return Positioned(
                      top: offset,
                      left: 20 + offset,
                      right: 20 + offset,
                      bottom: 10,
                      child: Transform.scale(
                        scale: scale,
                        child: Opacity(
                          opacity: opacity,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F3A5),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

              // Main PageView with vertical scrolling
              PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  // Trigger stack animation on page change
                  _stackAnimationController.forward().then((_) {
                    _stackAnimationController.reverse();
                  });
                },
                itemCount: _panelGroups.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: PanelGroupItem(panelGroup: _panelGroups[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
