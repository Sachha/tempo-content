import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../game_setup/domain/entities/team.dart';
import '../../domain/entities/word.dart';
import '../../domain/entities/game.dart';

/// Extended game state that includes fields not in the Game entity.
class GameState {
  final List<Team> teams;
  final int currentRound;
  final int totalRounds;
  final List<Word> allWords;
  final List<Word> remainingWords;
  final Word? currentWord;
  final int timerDuration;
  final int passPenalty;
  final int currentTeamIndex;
  final GameStatus status;
  final List<Word> wordsGuessedThisTurn;
  final bool isPaused;

  const GameState({
    this.teams = const [],
    this.currentRound = 0,
    this.totalRounds = 3,
    this.allWords = const [],
    this.remainingWords = const [],
    this.currentWord,
    this.timerDuration = 30,
    this.passPenalty = 0,
    this.currentTeamIndex = 0,
    this.status = GameStatus.setup,
    this.wordsGuessedThisTurn = const [],
    this.isPaused = false,
  });

  GameState copyWith({
    List<Team>? teams,
    int? currentRound,
    int? totalRounds,
    List<Word>? allWords,
    List<Word>? remainingWords,
    Word? currentWord,
    bool clearCurrentWord = false,
    int? timerDuration,
    int? passPenalty,
    int? currentTeamIndex,
    GameStatus? status,
    List<Word>? wordsGuessedThisTurn,
    bool? isPaused,
  }) =>
      GameState(
        teams: teams ?? this.teams,
        currentRound: currentRound ?? this.currentRound,
        totalRounds: totalRounds ?? this.totalRounds,
        allWords: allWords ?? this.allWords,
        remainingWords: remainingWords ?? this.remainingWords,
        currentWord:
            clearCurrentWord ? null : (currentWord ?? this.currentWord),
        timerDuration: timerDuration ?? this.timerDuration,
        passPenalty: passPenalty ?? this.passPenalty,
        currentTeamIndex: currentTeamIndex ?? this.currentTeamIndex,
        status: status ?? this.status,
        wordsGuessedThisTurn:
            wordsGuessedThisTurn ?? this.wordsGuessedThisTurn,
        isPaused: isPaused ?? this.isPaused,
      );
}

/// Main game state provider.
final gameProvider = NotifierProvider<GameNotifier, GameState>(
  GameNotifier.new,
);

class GameNotifier extends Notifier<GameState> {
  final _random = Random();

  @override
  GameState build() => const GameState();

  /// Initialize the game with teams, words, timer duration, and total rounds.
  void startGame({
    required List<Team> teams,
    required List<Word> words,
    required int timerDuration,
    int totalRounds = 3,
    int passPenalty = 0,
  }) {
    final shuffled = List<Word>.from(words)..shuffle(_random);
    state = GameState(
      teams: teams,
      currentRound: 0,
      totalRounds: totalRounds,
      passPenalty: passPenalty,
      allWords: words,
      remainingWords: shuffled,
      timerDuration: timerDuration,
      currentTeamIndex: 0,
      status: GameStatus.playing,
    );
  }

  /// Begin a team's turn: pick the first word from the remaining pile.
  void startTurn() {
    if (state.remainingWords.isEmpty) return;

    final remaining = List<Word>.from(state.remainingWords);
    final word = remaining.removeAt(0);

    state = state.copyWith(
      currentWord: word,
      remainingWords: remaining,
      wordsGuessedThisTurn: [],
      status: GameStatus.playing,
      isPaused: false,
    );
  }

  /// Pause the game.
  void pause() {
    state = state.copyWith(isPaused: true);
  }

  /// Resume the game.
  void resume() {
    state = state.copyWith(isPaused: false);
  }

  /// Mark the current word as correct and move to the next word.
  /// If no words remain, end the round.
  void correctWord() {
    if (state.currentWord == null) return;

    final guessed = [...state.wordsGuessedThisTurn, state.currentWord!];

    if (state.remainingWords.isEmpty) {
      // No more words — end the round.
      state = state.copyWith(
        wordsGuessedThisTurn: guessed,
        clearCurrentWord: true,
        status: GameStatus.roundEnd,
      );
      return;
    }

    final remaining = List<Word>.from(state.remainingWords);
    final nextWord = remaining.removeAt(0);

    state = state.copyWith(
      currentWord: nextWord,
      remainingWords: remaining,
      wordsGuessedThisTurn: guessed,
    );
  }

  /// Skip the current word (put it back at a random position in the pile).
  void passWord() {
    if (state.currentWord == null) return;

    final remaining = List<Word>.from(state.remainingWords);

    // Put the current word back at a random position.
    if (remaining.isEmpty) {
      remaining.add(state.currentWord!);
    } else {
      final insertIndex = _random.nextInt(remaining.length + 1);
      remaining.insert(insertIndex, state.currentWord!);
    }

    // Pick the next word from the pile.
    final nextWord = remaining.removeAt(0);

    state = state.copyWith(
      currentWord: nextWord,
      remainingWords: remaining,
    );
  }

  /// End the current team's turn, update scores, and switch to the next team.
  void endTurn(int wordsGuessed) {
    final teams = List<Team>.from(state.teams);
    final currentTeam = teams[state.currentTeamIndex];

    // Update score for current round.
    final updatedScoreByRound =
        Map<int, int>.from(currentTeam.scoreByRound);
    updatedScoreByRound[state.currentRound] =
        (updatedScoreByRound[state.currentRound] ?? 0) + wordsGuessed;

    // Recalculate total score.
    final totalScore =
        updatedScoreByRound.values.fold<int>(0, (sum, v) => sum + v);

    teams[state.currentTeamIndex] = currentTeam.copyWith(
      scoreByRound: updatedScoreByRound,
      totalScore: totalScore,
    );

    // If the current word was being shown but the turn ended (timer ran out),
    // put it back into the remaining pile.
    var remaining = List<Word>.from(state.remainingWords);
    if (state.currentWord != null) {
      remaining.insert(0, state.currentWord!);
    }

    final nextTeamIndex =
        (state.currentTeamIndex + 1) % state.teams.length;

    state = state.copyWith(
      teams: teams,
      currentTeamIndex: nextTeamIndex,
      clearCurrentWord: true,
      remainingWords: remaining,
      wordsGuessedThisTurn: [],
      isPaused: false,
    );
  }

  /// Called when all words have been guessed in a round.
  /// Updates scores for the last team and prepares for next round transition.
  void endRound() {
    final wordsGuessed = state.wordsGuessedThisTurn.length;
    final teams = List<Team>.from(state.teams);
    final currentTeam = teams[state.currentTeamIndex];

    final updatedScoreByRound =
        Map<int, int>.from(currentTeam.scoreByRound);
    updatedScoreByRound[state.currentRound] =
        (updatedScoreByRound[state.currentRound] ?? 0) + wordsGuessed;

    final totalScore =
        updatedScoreByRound.values.fold<int>(0, (sum, v) => sum + v);

    teams[state.currentTeamIndex] = currentTeam.copyWith(
      scoreByRound: updatedScoreByRound,
      totalScore: totalScore,
    );

    state = state.copyWith(
      teams: teams,
      status: GameStatus.roundEnd,
      clearCurrentWord: true,
      wordsGuessedThisTurn: [],
      isPaused: false,
    );
  }

  /// Move to the next round. Reset the word pile (shuffled) for the new round.
  /// If all rounds are complete, mark the game as finished.
  void nextRound() {
    final nextRound = state.currentRound + 1;

    if (nextRound >= state.totalRounds) {
      state = state.copyWith(
        status: GameStatus.finished,
      );
      return;
    }

    final shuffled = List<Word>.from(state.allWords)..shuffle(_random);

    state = state.copyWith(
      currentRound: nextRound,
      remainingWords: shuffled,
      clearCurrentWord: true,
      wordsGuessedThisTurn: [],
      status: GameStatus.playing,
      isPaused: false,
    );
  }

  /// Return teams sorted by total score (descending).
  List<Team> getResults() {
    final sorted = List<Team>.from(state.teams)
      ..sort((a, b) => b.totalScore.compareTo(a.totalScore));
    return sorted;
  }
}
