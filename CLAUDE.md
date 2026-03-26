# Tempo — Flutter App — Guide Agent Senior

---

## 🤖 Commandes Agents — Pipeline de Développement

### Vue d'ensemble

Le projet utilise un pipeline structuré de 5 commandes slash qui simulent une équipe produit complète. Chaque agent a un rôle précis et produit un livrable formaté.

### Pipeline complet : `/studio`

🎬 **Orchestrateur principal** — Lance les 4 phases séquentiellement avec validation entre chaque étape :

```
/studio <description de la feature>
```

**Phase 1 → PO** → **Phase 2 → BA** → **Phase 3 → Architect** → **Phase 4 → Dev**

Chaque phase nécessite une validation utilisateur (`✅ Validé` / `🔄 Ajuster`) avant de passer à la suivante.

### Commandes individuelles

| Commande | Rôle | Input | Output |
|---|---|---|---|
| `/po` | 🎯 Product Owner | Description libre d'un besoin | User Stories, critères d'acceptation, MoSCoW, scope IN/OUT, risques |
| `/ba` | 📊 Business Analyst | User Stories validées (sortie PO) | Flux utilisateur, règles métier, modèle de données, états d'écran, cas limites, wireframes textuels, Gherkin |
| `/architect` | 🏗️ Architecte Flutter | Specs fonctionnelles (sortie BA) | Analyse d'impact, nouveaux fichiers, entités, providers, routes, widget tree, clés i18n |
| `/dev` | 👨‍💻 Développeur Flutter | Plan d'architecture (sortie Architect) | Code implémenté (Entities → Repos → Providers → i18n → Screens → Widgets → Routes) |

### Quand utiliser quoi

- **Feature complète (nouvelle fonctionnalité)** → `/studio` — pipeline complet de bout en bout
- **Cadrage rapide** → `/po` seul — pour valider l'idée et le périmètre avant d'aller plus loin
- **Spécification d'une feature déjà cadrée** → `/ba` — quand les user stories existent déjà
- **Design technique uniquement** → `/architect` — quand les specs fonctionnelles sont prêtes
- **Implémentation directe** → `/dev` — quand l'architecture est déjà définie ou pour un bug fix / petite modification

### Règles communes aux agents

- Tous respectent la stack du projet (Riverpod v3, GoRouter, AppTheme, sérialisation manuelle)
- Tous lisent le codebase existant avant de produire leur livrable
- Le `/dev` exécute `flutter gen-l10n` et `flutter analyze` en fin d'implémentation
- Le paramètre `$ARGUMENTS` reçoit la description utilisateur

---

## 🎯 Vision Produit

**Tempo** est un jeu de soirée inspiré du Time's Up, en version application mobile. Les joueurs forment des équipes et doivent faire deviner des mots à travers plusieurs manches avec des règles différentes (description libre, un seul mot, mime). L'app permet de choisir parmi plusieurs catégories de mots, de définir le nombre de mots et d'équipes, ou de jouer avec ses propres mots personnalisés. Simple, ludique et accessible à tous, disponible en 7 langues.

**Philosophie UX** : 🎉 Fun & dynamique — couleurs vives, emojis dans l'UI, animations fluides, design plat avec coins arrondis généreux et ombres légères. L'expérience doit être festive et intuitive, comme un bon jeu de soirée.

---

## ⚙️ Stack Technique

| Concern | Solution | Version |
|---|---|---|
| Flutter SDK | stable | ^3.6.0 |
| State management | Riverpod | ^3.0.0 |
| Navigation | GoRouter | ^14.6.0 |
| Stockage | SharedPreferences (JSON manuel) | ^2.0.0 |
| Fonts | Google Fonts (Nunito) | ^6.2.1 |
| i18n | Flutter ARB + `flutter_localizations` | SDK |
| UUID | `uuid` package | ^4.0.0 |
| Animations | `flutter_animate` | ^4.0.0 |
| Audio | `audioplayers` | ^6.0.0 |
| Vibration | `vibration` | ^2.0.0 |
| Lottie | `lottie` | ^3.0.0 |
| Responsive | `AppResponsive` (natif MediaQuery) | — |
| Code gen | **Aucun** — pas de build_runner | — |

**100% offline-first** — Pas de backend. Toutes les données (mots, catégories, scores, paramètres) sont stockées localement via SharedPreferences. Les packs de mots sont embarqués dans l'app pour chaque langue.

---

## 🏗️ Architecture

### Structure des dossiers

```
lib/
├── core/
│   ├── constants/app_constants.dart       # Clés SharedPreferences, nom de l'app
│   ├── providers/global_providers.dart    # Providers globaux (SharedPrefs, Locale, Theme)
│   ├── router/app_router.dart             # GoRouter — routes + redirects
│   ├── theme/app_theme.dart               # SOURCE UNIQUE du style (couleurs, spacing, thème)
│   └── widgets/                           # Widgets partagés (scaffold, navbar...)
│
├── features/
│   ├── home/
│   │   └── presentation/
│   │       ├── screens/home_screen.dart           # Écran d'accueil (logo + actions)
│   │       └── widgets/
│   │
│   ├── game_setup/
│   │   ├── domain/entities/
│   │   ├── data/repositories/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/game_setup_screen.dart      # Config partie (équipes, mots, catégories)
│   │       └── widgets/
│   │
│   ├── categories/
│   │   ├── domain/entities/
│   │   ├── data/repositories/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/categories_screen.dart      # Sélection des catégories
│   │       └── widgets/
│   │
│   ├── custom_words/
│   │   ├── domain/entities/
│   │   ├── data/repositories/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/custom_words_screen.dart    # Saisie mots personnalisés
│   │       └── widgets/
│   │
│   ├── gameplay/
│   │   ├── domain/entities/
│   │   ├── data/repositories/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/gameplay_screen.dart        # Écran de jeu (timer + mot)
│   │       └── widgets/
│   │
│   ├── scores/
│   │   ├── domain/entities/
│   │   ├── data/repositories/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       │   ├── round_score_screen.dart         # Score entre les manches
│   │       │   └── final_results_screen.dart       # Résultats finaux
│   │       └── widgets/
│   │
│   ├── rules/
│   │   └── presentation/
│   │       ├── screens/rules_screen.dart           # Règles du jeu
│   │       └── widgets/
│   │
│   ├── onboarding/
│   │   └── presentation/
│   │       ├── screens/onboarding_screen.dart      # Tuto premier lancement
│   │       └── widgets/
│   │
│   └── settings/
│       ├── data/repositories/
│       └── presentation/
│           ├── providers/
│           ├── screens/settings_screen.dart        # Paramètres (langue, son, vibration)
│           └── widgets/
│
├── l10n/                                  # Fichiers ARB (app_fr.arb, app_en.arb, app_it.arb, app_es.arb, app_de.arb, app_pt.arb, app_nl.arb)
└── main.dart
```

### Règles d'architecture Clean (à respecter strictement)

- **Entités** → `domain/entities/` — pures Dart, aucune dépendance Flutter
- **Repositories** → `data/repositories/` — accès aux données uniquement (SharedPreferences)
- **Providers globaux** → `core/providers/global_providers.dart`
- **Providers locaux** → `features/<feature>/presentation/providers/`
- **Pas de logique métier dans les widgets** — déléguer aux providers/entités
- **Pas de repository dans la couche presentation** — passer par un provider

---

## 🔵 Riverpod — Règles et Patterns

### Toujours utiliser Riverpod v3 (Notifier/AsyncNotifier)

```dart
// ✅ CORRECT — Notifier v3
class MyNotifier extends Notifier<MyState> {
  @override
  MyState build() => initialState;

  void update(MyState newState) {
    state = newState;
  }
}

final myProvider = NotifierProvider<MyNotifier, MyState>(MyNotifier.new);

// ✅ CORRECT — AsyncNotifier v3 pour les opérations async
class MyListNotifier extends AsyncNotifier<List<MyEntity>> {
  @override
  Future<List<MyEntity>> build() async {
    final repo = ref.read(myRepositoryProvider);
    return repo.getAll();
  }

  Future<void> add(MyEntity item) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(myRepositoryProvider);
      await repo.save(item);
      return repo.getAll();
    });
  }
}

// ❌ INTERDIT — StateNotifier est déprécié
class MyNotifier extends StateNotifier<List<Item>> { ... }
```

### Providers simples

```dart
// Dépendance injectée (override dans main.dart)
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize in ProviderScope');
});

// Provider dérivé
final themeDataProvider = Provider<ThemeData>((ref) => AppTheme.lightTheme);

// FutureProvider pour lecture one-shot
final myItemProvider = FutureProvider.autoDispose<MyEntity?>((ref) async {
  final repo = ref.read(myRepositoryProvider);
  return repo.getById(id);
});
```

### Consommer dans les widgets

```dart
// ✅ ConsumerWidget — widget sans état local
class MyCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(myListProvider);
    return items.when(
      data: (list) => _build(list),
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => Text('Erreur: $e'),
    );
  }
}

// ✅ ConsumerStatefulWidget — quand un état local est nécessaire (animations, controllers, timers)
class MyScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends ConsumerState<MyScreen> {
  late Timer _timer;
  @override
  Widget build(BuildContext context) { ... }
}

// ✅ StatelessWidget — aucun besoin de Riverpod (widget purement présentationnel)
class PureWidget extends StatelessWidget { ... }
```

**Règle** : Préférer `ConsumerWidget` par défaut. N'utiliser `ConsumerStatefulWidget` que si un `State` local est nécessaire (timers, `AnimationController`, `TextEditingController`, `PageController`...).

---

## 🧭 Navigation — GoRouter

### Configuration

Navigation en **flow linéaire** sans bottom bar. Pas de `StatefulShellRoute`.

### Routes

| Route | Écran | Description |
|---|---|---|
| `/` | `HomeScreen` | Accueil — logo Tempo, "Nouvelle partie", "Règles", "Paramètres" |
| `/onboarding` | `OnboardingScreen` | Tutoriel au premier lancement |
| `/rules` | `RulesScreen` | Règles du jeu |
| `/settings` | `SettingsScreen` | Langue, son, vibration |
| `/setup` | `GameSetupScreen` | Config partie : nb équipes, noms, nb mots |
| `/setup/categories` | `CategoriesScreen` | Choix des catégories de mots |
| `/setup/custom-words` | `CustomWordsScreen` | Saisie de mots personnalisés |
| `/game` | `GameplayScreen` | Écran de jeu : timer + mot à deviner |
| `/game/round-score` | `RoundScoreScreen` | Score entre les manches |
| `/game/results` | `FinalResultsScreen` | Résultats finaux + classement |

### Patterns

```dart
// Naviguer (remplace la pile)
context.go('/');

// Pousser (empile)
context.push('/setup');

// Redirect guard — onboarding au premier lancement
redirect: (context, state) {
  final hasSeenOnboarding = ref.read(onboardingProvider);
  if (!hasSeenOnboarding && state.matchedLocation != '/onboarding') {
    return '/onboarding';
  }
  return null;
},
```

**Ne pas utiliser `Navigator.push()`** — toujours passer par GoRouter.

---

## 🎨 Thème — Règle Absolue

**`lib/core/theme/app_theme.dart` est la source unique de vérité.**

### Ce qu'il contient (tout doit rester là)

- `AppColors` — palette complète
- `AppTheme.lightTheme` — ThemeData Material 3
- `AppSpacing` — constantes d'espacement (xs/sm/md/lg/xl/xxl) + EdgeInsets pré-construits
- `AppRadius` — rayons de bordure (sm:8, md:12, lg:16, xl:24)
- `TextStyleContext` — extension `context.textStyles`
- `TextStyleExtensions` — `.bold`, `.semiBold`, `.withColor()`, `.withSize()`

### Utilisation

```dart
// ✅ CORRECT
Container(
  padding: AppSpacing.paddingMd,
  decoration: BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(AppRadius.lg),
  ),
  child: Text('Hello', style: context.textStyles.bodyLarge?.bold),
);

// ❌ INTERDIT — valeurs magiques
Container(padding: EdgeInsets.all(16), color: Color(0xFFFF8A65))
```

### Palette de couleurs

```
Primary         #2979FF → primaryLight: #75A7FF / primaryDark: #0D47A1
Secondary       #FF6E40 → secondaryLight: #FFA270
Accent          #FFD740
Success         #81C784
Warning         #FFB74D
Error           #E57373
Background      #F5F7FA   surface: #FFFFFF   surfaceVariant: #EEF2F7
Text primary    #1A1A2E   secondary: #5A5A72   light: #9E9EB8
```

**Ne jamais créer d'autres fichiers thème.** Si un utilitaire de style manque, l'ajouter dans `app_theme.dart`.

---

## 📱 Responsivité Mobile

### Principes

L'app est **mobile-first**. Toutes les dimensions fixes doivent être mises à l'échelle via `AppResponsive`.

**Référence de design** : iPhone 14 — 390×844 px logiques.
**Pas de package supplémentaire** — tout est dans `app_theme.dart`.

### Utilitaires disponibles (dans `app_theme.dart`)

| Classe | Rôle |
|---|---|
| `AppBreakpoints` | Seuils : `small < 360`, `large ≥ 430` |
| `AppResponsive` | Calcul des facteurs d'échelle |
| `ResponsiveContext` | Extension `context.r` pour accès rapide |

### Usage

```dart
// ✅ CORRECT — tailles scalées
Text(
  'Mon texte',
  style: TextStyle(fontSize: context.r.sp(16)),
);
SizedBox(height: context.r.h(24));
Container(width: context.r.w(200));
BorderRadius.circular(context.r.r(16));

// Breakpoints
if (context.r.isSmallPhone) {
  // layout compact
}

// ❌ INTERDIT — tailles fixes dans les widgets
Text('...', style: TextStyle(fontSize: 16))
SizedBox(height: 24)
```

### Règles

- **Polices** → toujours `context.r.sp(size)` dans les widgets
- **Hauteurs/largeurs fixes** → `context.r.h()` / `context.r.w()`
- **Rayons & espacements en widget** → `context.r.r()` si la valeur est critique
- **`AppSpacing.*` constants** restent utilisables pour les contextes `const` (ThemeData, constructeurs const). Préférer `context.r` en dehors des `const`.
- **`SafeArea`** → obligatoire sur tous les écrans root
- **`Flexible` / `Expanded`** → préférer aux largeurs fixes dans les `Row` / `Column`

### Méthodes de l'extension `context.r`

```dart
context.r.sp(14)         // → fontSize adaptée (clamp ±15%)
context.r.w(200)         // → largeur adaptée à l'écran
context.r.h(100)         // → hauteur adaptée à l'écran
context.r.r(16)          // → rayon / dimension symétrique
context.r.isSmallPhone   // → true si width < 360
context.r.isMediumPhone  // → true si 360 ≤ width < 430
context.r.isLargePhone   // → true si width ≥ 430
```

---

## 📦 Modèles de Données

### Word

```dart
class Word {
  final String id;
  final String text;
  final String categoryId;
  final String language;       // Code langue : 'fr', 'en', 'it', 'es', 'de', 'pt', 'nl'
  final WordDifficulty difficulty;

  const Word({
    required this.id,
    required this.text,
    required this.categoryId,
    required this.language,
    required this.difficulty,
  });

  Word copyWith({
    String? id,
    String? text,
    String? categoryId,
    String? language,
    WordDifficulty? difficulty,
  }) => Word(
    id: id ?? this.id,
    text: text ?? this.text,
    categoryId: categoryId ?? this.categoryId,
    language: language ?? this.language,
    difficulty: difficulty ?? this.difficulty,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'text': text,
    'categoryId': categoryId,
    'language': language,
    'difficulty': difficulty.name,
  };

  factory Word.fromMap(Map<String, dynamic> map) => Word(
    id: map['id'] as String,
    text: map['text'] as String,
    categoryId: map['categoryId'] as String,
    language: map['language'] as String,
    difficulty: WordDifficulty.values.byName(map['difficulty'] as String),
  );
}

enum WordDifficulty { easy, medium, hard }
```

### Category

```dart
class Category {
  final String id;
  final String nameKey;        // Clé i18n pour le nom traduit
  final String emoji;          // Emoji représentant la catégorie
  final int wordCount;         // Nombre de mots dans cette catégorie

  const Category({
    required this.id,
    required this.nameKey,
    required this.emoji,
    required this.wordCount,
  });

  Category copyWith({
    String? id,
    String? nameKey,
    String? emoji,
    int? wordCount,
  }) => Category(
    id: id ?? this.id,
    nameKey: nameKey ?? this.nameKey,
    emoji: emoji ?? this.emoji,
    wordCount: wordCount ?? this.wordCount,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'nameKey': nameKey,
    'emoji': emoji,
    'wordCount': wordCount,
  };

  factory Category.fromMap(Map<String, dynamic> map) => Category(
    id: map['id'] as String,
    nameKey: map['nameKey'] as String,
    emoji: map['emoji'] as String,
    wordCount: map['wordCount'] as int,
  );
}
```

### Team

```dart
class Team {
  final String id;
  final String name;
  final String color;              // Hex couleur de l'équipe
  final Map<int, int> scoreByRound; // round index → score
  final int totalScore;

  const Team({
    required this.id,
    required this.name,
    required this.color,
    this.scoreByRound = const {},
    this.totalScore = 0,
  });

  Team copyWith({
    String? id,
    String? name,
    String? color,
    Map<int, int>? scoreByRound,
    int? totalScore,
  }) => Team(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    scoreByRound: scoreByRound ?? this.scoreByRound,
    totalScore: totalScore ?? this.totalScore,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'color': color,
    'scoreByRound': scoreByRound.map((k, v) => MapEntry(k.toString(), v)),
    'totalScore': totalScore,
  };

  factory Team.fromMap(Map<String, dynamic> map) => Team(
    id: map['id'] as String,
    name: map['name'] as String,
    color: map['color'] as String,
    scoreByRound: (map['scoreByRound'] as Map<String, dynamic>)
        .map((k, v) => MapEntry(int.parse(k), v as int)),
    totalScore: map['totalScore'] as int,
  );
}
```

### Game

```dart
class Game {
  final String id;
  final List<Team> teams;
  final int currentRound;          // 0 = description, 1 = un mot, 2 = mime
  final int totalRounds;
  final int timerDuration;         // Durée du timer en secondes
  final List<Word> words;          // Mots sélectionnés pour la partie
  final int currentTeamIndex;
  final GameStatus status;

  const Game({
    required this.id,
    required this.teams,
    this.currentRound = 0,
    this.totalRounds = 3,
    this.timerDuration = 30,
    required this.words,
    this.currentTeamIndex = 0,
    this.status = GameStatus.setup,
  });

  Game copyWith({
    String? id,
    List<Team>? teams,
    int? currentRound,
    int? totalRounds,
    int? timerDuration,
    List<Word>? words,
    int? currentTeamIndex,
    GameStatus? status,
  }) => Game(
    id: id ?? this.id,
    teams: teams ?? this.teams,
    currentRound: currentRound ?? this.currentRound,
    totalRounds: totalRounds ?? this.totalRounds,
    timerDuration: timerDuration ?? this.timerDuration,
    words: words ?? this.words,
    currentTeamIndex: currentTeamIndex ?? this.currentTeamIndex,
    status: status ?? this.status,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'teams': teams.map((t) => t.toMap()).toList(),
    'currentRound': currentRound,
    'totalRounds': totalRounds,
    'timerDuration': timerDuration,
    'words': words.map((w) => w.toMap()).toList(),
    'currentTeamIndex': currentTeamIndex,
    'status': status.name,
  };

  factory Game.fromMap(Map<String, dynamic> map) => Game(
    id: map['id'] as String,
    teams: (map['teams'] as List).map((t) => Team.fromMap(t)).toList(),
    currentRound: map['currentRound'] as int,
    totalRounds: map['totalRounds'] as int,
    timerDuration: map['timerDuration'] as int,
    words: (map['words'] as List).map((w) => Word.fromMap(w)).toList(),
    currentTeamIndex: map['currentTeamIndex'] as int,
    status: GameStatus.values.byName(map['status'] as String),
  );
}

enum GameStatus { setup, playing, roundEnd, finished }
```

### GameResult

```dart
class GameResult {
  final String id;
  final List<Team> finalRanking;   // Équipes triées par score décroissant
  final DateTime playedAt;
  final int totalWords;

  const GameResult({
    required this.id,
    required this.finalRanking,
    required this.playedAt,
    required this.totalWords,
  });

  GameResult copyWith({
    String? id,
    List<Team>? finalRanking,
    DateTime? playedAt,
    int? totalWords,
  }) => GameResult(
    id: id ?? this.id,
    finalRanking: finalRanking ?? this.finalRanking,
    playedAt: playedAt ?? this.playedAt,
    totalWords: totalWords ?? this.totalWords,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'finalRanking': finalRanking.map((t) => t.toMap()).toList(),
    'playedAt': playedAt.toIso8601String(),
    'totalWords': totalWords,
  };

  factory GameResult.fromMap(Map<String, dynamic> map) => GameResult(
    id: map['id'] as String,
    finalRanking: (map['finalRanking'] as List).map((t) => Team.fromMap(t)).toList(),
    playedAt: DateTime.parse(map['playedAt'] as String),
    totalWords: map['totalWords'] as int,
  );
}
```

### Sérialisation

**Pas de code generation.** Toujours implémenter `toMap()` / `fromMap()` manuellement.

```dart
// Pattern standard
Map<String, dynamic> toMap() => {
  'id': id,
  'date': date.toIso8601String(),
  'type': type.name, // enum → String via .name
};

factory Entity.fromMap(Map<String, dynamic> map) => Entity(
  id: map['id'] as String,
  date: DateTime.parse(map['date'] as String),
  type: MyEnum.values.byName(map['type'] as String),
);
```

---

## 🌍 Localisation

### Langues supportées

| Code | Langue |
|---|---|
| `fr` | Français |
| `en` | Anglais |
| `it` | Italien |
| `es` | Espagnol |
| `de` | Allemand |
| `pt` | Portugais |
| `nl` | Néerlandais |

La localisation couvre **l'UI**, **les noms de catégories** et **les mots à deviner**. Les mots sont embarqués dans l'app sous forme de données JSON par langue.

### Ajouter une nouvelle chaîne

1. Ajouter dans `lib/l10n/app_en.arb` :
```json
"myNewKey": "My new string",
"@myNewKey": { "description": "Description for translators" }
```
2. Ajouter la traduction dans les 6 autres fichiers ARB (`app_fr.arb`, `app_it.arb`, `app_es.arb`, `app_de.arb`, `app_pt.arb`, `app_nl.arb`)
3. Lancer `flutter gen-l10n`

### Utilisation dans les widgets

```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.myNewKey);
```

**Règle** : Aucune chaîne de texte visible par l'utilisateur en dur dans les widgets.

---

## ✅ Règles de Code — Senior Flutter

### Widgets

- `const` partout où c'est possible (constructeurs, widgets feuille)
- Extraire les widgets en méthodes privées (`_buildHeader()`) ou classes séparées dès qu'un `build()` dépasse ~80 lignes
- Utiliser `key:` sur les items de listes dynamiques
- Préférer `SizedBox` à `Container` pour l'espacement pur

### Performance

- Éviter les rebuilds inutiles : bien scoper les `ref.watch()` au niveau le plus bas possible
- Ne jamais appeler `ref.read()` dans `build()` pour de la réactivité — utiliser `ref.watch()`
- Utiliser `select()` pour ne s'abonner qu'à une partie d'un state : `ref.watch(provider.select((s) => s.name))`

### AsyncValue pattern

```dart
// Pattern complet
ref.watch(myAsyncProvider).when(
  data: (data) => MyWidget(data: data),
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, stack) => Center(child: Text('Erreur: $error')),
);

// Si on veut ignorer loading/error
ref.watch(myAsyncProvider).valueOrNull;
```

### Anti-patterns interdits

- ❌ `setState()` pour de la logique métier — utiliser Riverpod
- ❌ Logique de navigation dans les entités ou repositories
- ❌ `BuildContext` dans les providers
- ❌ Couleurs ou espacements hardcodés — toujours `AppColors.*` / `AppSpacing.*`
- ❌ `Navigator.of(context).push()` — toujours `context.go()` / `context.push()`
- ❌ Créer un nouveau fichier thème — tout va dans `app_theme.dart`
- ❌ `StateNotifier` — utiliser `Notifier` ou `AsyncNotifier`
- ❌ `TextStyle(fontSize: 16)` dans un widget — utiliser `context.r.sp(16)`
- ❌ `SizedBox(height: 24)` en dur dans un widget — utiliser `context.r.h(24)`
- ❌ Package `flutter_screenutil` — utiliser `AppResponsive` (dans `app_theme.dart`)

---

## 🎨 Direction Artistique

- **Police** : Nunito (Google Fonts) — titres semi-bold/bold, corps regular
- **Coins arrondis** : 16-24px (cards, boutons, inputs) — utiliser `AppRadius.*`
- **Ombres** : légères — design plat avec ombres subtiles pour la profondeur
- **Espacement** : généreux — utiliser `AppSpacing.*`
- **Animations** : 200-300ms, courbes `Curves.easeInOut` — utiliser `flutter_animate` et Lottie pour les transitions festives (score, victoire, timer)
- **Icônes** : Material Icons rounded, 20-24px
- **Emojis** : utilisés généreusement dans l'UI (catégories, titres, feedback)
- **Ambiance** : festive, colorée, dynamique — l'app doit donner envie de jouer

---

## 📦 Packages Clés

```yaml
flutter_riverpod: ^3.0.0
go_router: ^14.6.0
shared_preferences: ^2.0.0
google_fonts: ^6.2.1
intl: 0.20.2
uuid: ^4.0.0
flutter_animate: ^4.0.0
audioplayers: ^6.0.0
vibration: ^2.0.0
lottie: ^3.0.0
```
