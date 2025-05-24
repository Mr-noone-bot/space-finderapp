import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vit_spacefinder/providers/space_provider.dart';

class BlockSelector extends StatelessWidget {
  const BlockSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final spaceProvider = Provider.of<SpaceProvider>(context);
    final selectedBlock = spaceProvider.selectedBlock;
    
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: spaceProvider.blocks.length,
        itemBuilder: (context, index) {
          final block = spaceProvider.blocks[index];
          final isSelected = block == selectedBlock;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                spaceProvider.setSelectedBlock(block);
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary 
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    block,
                    style: TextStyle(
                      color: isSelected 
                          ? Theme.of(context).colorScheme.onPrimary 
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
