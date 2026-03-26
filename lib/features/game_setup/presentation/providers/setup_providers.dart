import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';

/// Default team colors (hex) — 8 colors for max 8 teams.
const defaultTeamColors = [
  '#FF4B4B',
  '#FFE600',
  '#00E5FF',
  '#B554FF',
  '#00E676',
  '#FF8A65',
  '#4DB6AC',
  '#90A4AE',
];

/// Setup state for game configuration.
class SetupState {
  final int numberOfTeams;
  final List<String> teamNames;
  final int wordCount;
  final int timerDuration;
  final int numberOfRounds;
  final int passPenalty;
  final List<String> selectedCategoryIds;
  final bool isCustomWordsMode;
  final List<String> customWords;

  const SetupState({
    this.numberOfTeams = 2,
    this.teamNames = const ['Team 1', 'Team 2'],
    this.wordCount = 40,
    this.timerDuration = 30,
    this.numberOfRounds = 3,
    this.passPenalty = 0,
    this.selectedCategoryIds = const [],
    this.isCustomWordsMode = false,
    this.customWords = const [],
  });

  SetupState copyWith({
    int? numberOfTeams,
    List<String>? teamNames,
    int? wordCount,
    int? timerDuration,
    int? numberOfRounds,
    int? passPenalty,
    List<String>? selectedCategoryIds,
    bool? isCustomWordsMode,
    List<String>? customWords,
  }) =>
      SetupState(
        numberOfTeams: numberOfTeams ?? this.numberOfTeams,
        teamNames: teamNames ?? this.teamNames,
        wordCount: wordCount ?? this.wordCount,
        timerDuration: timerDuration ?? this.timerDuration,
        numberOfRounds: numberOfRounds ?? this.numberOfRounds,
        passPenalty: passPenalty ?? this.passPenalty,
        selectedCategoryIds:
            selectedCategoryIds ?? this.selectedCategoryIds,
        isCustomWordsMode: isCustomWordsMode ?? this.isCustomWordsMode,
        customWords: customWords ?? this.customWords,
      );
}

/// Setup provider for game configuration.
final setupProvider = NotifierProvider<SetupNotifier, SetupState>(
  SetupNotifier.new,
);

class SetupNotifier extends Notifier<SetupState> {
  @override
  SetupState build() => const SetupState();

  /// Add a new team (max 8).
  void addTeam() {
    if (state.numberOfTeams >= AppConstants.maxTeams) return;

    final newCount = state.numberOfTeams + 1;
    final names = [...state.teamNames, 'Team $newCount'];

    state = state.copyWith(
      numberOfTeams: newCount,
      teamNames: names,
    );
  }

  /// Remove a team at a specific index (min 2).
  void removeTeamAt(int index) {
    if (state.numberOfTeams <= AppConstants.minTeams) return;
    if (index < 0 || index >= state.teamNames.length) return;

    final names = List<String>.from(state.teamNames)..removeAt(index);

    state = state.copyWith(
      numberOfTeams: names.length,
      teamNames: names,
    );
  }

  /// Update the name of a specific team by index.
  void updateTeamName(int index, String name) {
    if (index < 0 || index >= state.teamNames.length) return;

    final names = List<String>.from(state.teamNames);
    names[index] = name;

    state = state.copyWith(teamNames: names);
  }

  /// Set the word count.
  void setWordCount(int count) {
    if (!AppConstants.wordCountOptions.contains(count)) return;
    state = state.copyWith(wordCount: count);
  }

  /// Set the pass penalty in seconds.
  void setPassPenalty(int penalty) {
    if (!AppConstants.passPenaltyOptions.contains(penalty)) return;
    state = state.copyWith(passPenalty: penalty);
  }

  /// Set the timer duration in seconds.
  void setTimerDuration(int duration) {
    if (!AppConstants.timerOptions.contains(duration)) return;
    state = state.copyWith(timerDuration: duration);
  }

  /// Set the number of rounds.
  void setNumberOfRounds(int rounds) {
    if (!AppConstants.roundOptions.contains(rounds)) return;
    state = state.copyWith(numberOfRounds: rounds);
  }

  /// Toggle a category ID in the selected list.
  void toggleCategory(String categoryId) {
    final categories = List<String>.from(state.selectedCategoryIds);

    if (categories.contains(categoryId)) {
      categories.remove(categoryId);
    } else {
      categories.add(categoryId);
    }

    state = state.copyWith(selectedCategoryIds: categories);
  }

  /// Enable or disable custom words mode.
  void setCustomWordsMode(bool enabled) {
    state = state.copyWith(isCustomWordsMode: enabled);
  }

  /// Add a custom word to the list.
  void addCustomWord(String word) {
    if (word.trim().isEmpty) return;

    final words = [...state.customWords, word.trim()];
    state = state.copyWith(customWords: words);
  }

  /// Remove a custom word by index.
  void removeCustomWord(int index) {
    if (index < 0 || index >= state.customWords.length) return;

    final words = List<String>.from(state.customWords)..removeAt(index);
    state = state.copyWith(customWords: words);
  }

  /// Reset the entire setup to defaults.
  void resetSetup() {
    state = const SetupState();
  }
}
