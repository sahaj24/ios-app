# Speakwell

A speaking-practice iOS app. We go in a very structured way, keep the code
simple, and avoid complex logic. Everything lives in clear folders so you can
open a single component and read it on its own. No clever abstractions, no
over-engineering.

## Tech stack

- Swift 5 / SwiftUI, iOS 16.0+
- `ObservableObject` + `@Published` for state (no `@Observable`)
- No third-party packages. Score rings are SwiftUI shapes; the laurels on the
  Congratulations screen are Apple's `laurel.leading` / `laurel.trailing`
  SF Symbols, matching the Figma design.
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) generates the `.xcodeproj`
  from `project.yml`. The project file is generated and gitignored.
- XCTest for unit tests

## Appearance (dark mode only)

The app is dark mode only. This is enforced by `UIUserInterfaceStyle: Dark`
in `project.yml` and `.preferredColorScheme(.dark)` in `SpeakwellApp`.
Every screen uses the same near-black background with a soft purple glow at
the top. Cards are translucent with thin borders (an approximation of Liquid
Glass using fills and borders, so it works on iOS 16).

## Motion

Animations are calm and subtle, never flashy. Shared timing lives in
`Sources/Core/DesignSystem/Animations`:

- `Animation+Speakwell.swift`: named curves (`speakwellQuick`,
  `speakwellStandard`, `speakwellGentle`, `speakwellSpring`, `speakwellPulse`).
- `Motion.swift`: `Motion.gated(_:reduceMotion:)`, the one place that drops an
  animation when Reduce Motion is on.
- `AppearModifier.swift`: `.appearRise(index:)`, a staggered fade-and-rise on
  first appear.

Where motion is used: button press scale (`PressableButtonStyle`), the
sliding selection pill on the segmented control and tab bar
(`matchedGeometryEffect`), score rings filling and the score counting up on
Congratulations, the record button's pulsing halo, the shuffle crossfade, and
the staggered History rows. Every effect respects Reduce Motion through
`Motion.gated` or the shared appear modifier.

## Project structure

```
ios-app/
├── project.yml                  # XcodeGen definition (source of truth)
├── Design/
│   ├── Speakwell.fig            # Figma source file
│   └── Reference/               # 7 reference PNGs (see "Design" below)
├── Resources/                   # Info.plist, Assets.xcassets
├── Sources/
│   ├── App/                     # @main, RootTabView, TabBar/
│   ├── Core/
│   │   ├── Components/          # One folder per reusable view (with #Preview)
│   │   │   ├── ActionButtonRow  ├── GlassCard        ├── GlassCircleButton
│   │   │   ├── ListRow          ├── NavigationRowCard├── PrimaryButton
│   │   │   ├── ScoreRings       ├── ScreenHeading    ├── ScreenNavBar
│   │   │   └── SearchField, SecondaryButton, SegmentedToggle, SpeakwellDivider
│   │   ├── Constants/           # Fixed control sizes
│   │   ├── DesignSystem/        # Colors/, Typography/, Spacing/, Radius/, Backgrounds/, Animations/
│   │   ├── Extensions/          # Color(hex:), hidden nav bar helper
│   │   ├── Models/              # Small plain structs
│   │   ├── Services/            # Providers; DebateTopics/ holds the 2000 topics
│   │   └── Utilities/           # TimeFormatter
│   └── Features/
│       ├── Practice/
│       │   ├── ChooseTopic/     # View + ViewModel + Components/ (TopicCard, TopicPickerSheet, ...)
│       │   ├── GatherThoughts/  # Editable outline (sheet editors)
│       │   ├── ReadyToSpeak/
│       │   ├── Congratulations/
│       │   └── Performance/
│       ├── History/             # Sessions list and Streak page
│       └── Profile/             # Profile + Display & Accessibility
└── Tests/                       # Mirrors Sources
```

Structure rules:

- One type per file. The file name is the type name.
- Every reusable component sits in its own folder, for example
  `Core/Components/PrimaryButton/PrimaryButton.swift`.
- A component used by one screen goes in that screen's `Components/` folder.
  A component used by several screens goes in `Core/Components`.
- Every screen and component has a `#Preview`.
- Features do not depend on each other. Shared code goes through `Core`.
- Views render state and forward taps. View models hold `@Published` state
  and small pure functions. No business logic in views.

## Design tokens

All values live in `Sources/Core/DesignSystem`. Views use tokens and do not
hard-code hex values.

- `Colors/Color+Speakwell.swift`: `swBackground`, `swSurface`, `swRaised`,
  `swSelected`, `swText`, `swMuted`, `swAccent`, `swLavender`, ring colors, ...
- `Typography/Font+Speakwell.swift`: `swLargeTitle`, `swTitle2`, `swHeadline`,
  `swBody`, `swFootnote`, `swCaption`, ...
- `Spacing/Spacing.swift` and `Radius/Radius.swift`
- `Backgrounds/ScreenBackground.swift`: the top purple gradient, applied with
  `.screenBackground()`
- `Core/Constants/Constants.swift`: fixed control sizes

## Design

`Design/Speakwell.fig` is the Figma source. The screens come from the Figma
page **New Design** (canvas node `682:22311`) of file
`usTqZArxosNPRdZz6P1c5X`. `Design/Reference/` holds the 402x874 PNGs used as
the visual source of truth:

| PNG | Figma node | Screen |
| --- | --- | --- |
| `01-choose-topic.png` | `830:23312` | Choose Your Topic |
| `02-gather-thoughts.png` | `830:23351` | Gather your thoughts |
| `03-ready-to-speak.png` | `830:23410` | Ready to speak |
| `04-congratulations.png` | `830:23495` | Congratulations |
| `05-performance.png` | `830:23433` | Your performance |
| `06-history.png` | `830:23817` | History |
| `07-profile.png` | `830:24236` | Profile |

## Navigation

The Practice tab is a `NavigationStack` driven by `PracticeRoute`:
Choose Your Topic -> Gather your thoughts -> Ready to speak -> Congratulations
-> Performance.

- Retry on Performance goes back to Ready to speak.
- Done pops to Choose Your Topic.
- Rows on Performance have no destination yet.
- `RootTabView` owns the selected tab and the Practice/Profile paths. The
  floating tab bar is hidden while a sub-screen is pushed.

The Profile tab is a `NavigationStack` driven by `ProfileRoute`: Profile ->
Display & Accessibility.

On Gather your thoughts, each outline card (Opening / Key points / Closing)
opens an editor sheet (`OutlineEditSheet`) where the text is editable; Save
writes it back.

History has two segments. **Sessions** is the list of past speeches.
**Streak** shows the current and longest streak, a swipeable week pager
(four weeks, seven day-circles each, with page dots you can also tap), the
"This month" and "Last four weeks" totals, and the next milestone (a new
personal record). Each piece is its own folder under
`Features/History/Components` (`StreakStatsHeader`, `StreakWeekPager`,
`StreakWeekPage`, `StreakDayColumn`, `StreakPageDots`, `StreakTotals`,
`StreakMilestone`). The data is mock (`StreakProvider`); totals and the
milestone text are computed from it.

## Session times

The Choose Your Topic screen has a Preparation time and a Speaking time chip.
Each opens a menu of presets plus a **Custom** option that presents a bottom
sheet with minute and second wheels (`CustomTimeSheet`). The chosen value
flows into the Gather countdown and the Speaking timer.

- Presets: Preparation 2 / 3 / 5 / 10 min; Speaking 1 / 2 / 3 / 5 min.
- Limits (custom values are clamped): Preparation 2:00 to 10:00, Speaking
  0:30 to 15:00. Limits live in `Core/Constants/Constants.swift` and the
  clamping is unit-tested.

## Topics

Topics come from `Core/Services/DebateTopics/DebateTopics.swift`: 20
categories with 100 topics each (2000 in total). `TopicProvider` turns them
into `TopicCategory` and `Topic` models and offers `randomTopic`, search and
per-category lookups.

On Choose Your Topic (Random topic tab):

- **Shuffle** button: a roulette. The card text rolls through 14 topics,
  fast first and slower at the end, then lands on the final one
  (`RouletteSpin` builds the plan; `ChooseTopicViewModel` plays it). It never
  lands on the topic already shown. With Reduce Motion on, the topic simply
  changes.
- **Pick a topic** link: opens a sheet (`TopicPickerSheet`) with a search
  box and the 20 categories. Tap a category to see its 100 topics, tap a
  topic to use it. The bottom button is **Random from all topics** (or
  **Random from this category** once a category is open) and runs the same
  roulette.
- After "Random from this category", the shuffle button keeps drawing from
  that category and the card label shows the category name. After a manually
  picked topic, shuffle goes back to all topics.
- Search matches the start of any word ("nato" finds "NATO expansion", not
  "Pollinator").

Folders: `ChooseTopic/Components/TopicCard`, `TopicPickerSheet`,
`TopicPickerRow`; the shared search box is `Core/Components/SearchField`.

## Mock data

Scores, history, streak and profile data are hard-coded in `Core/Services`.
There is no audio, networking or AI yet.

## How to add a new screen

1. Create `Sources/Features/<Feature>/<Screen>/`.
2. Add `<Screen>View.swift` and `<Screen>ViewModel.swift` (`ObservableObject`
   with `@Published` state).
3. Put screen-only pieces in `<Screen>/Components/<Piece>/<Piece>.swift`.
4. Use tokens from `DesignSystem` and apply `.screenBackground()`.
5. Add a case to `PracticeRoute` (for Practice screens) and handle it in
   `PracticeFlowView`.
6. Add `Tests/Features/<Feature>/<Screen>/<Screen>ViewModelTests.swift`.
7. Run `xcodegen generate`.

## How to add a new component

1. Create `Sources/Core/Components/<Name>/<Name>.swift` (or the screen's
   `Components/` folder if only one screen uses it).
2. One type per file, take plain values and closures, add a `#Preview`.
3. Use tokens only, no raw hex or magic numbers.
4. Run `xcodegen generate`.

## Getting started

```bash
brew install xcodegen      # one time
xcodegen generate
open Speakwell.xcodeproj
```

Re-run `xcodegen generate` whenever files are added or removed. Do not edit
`Speakwell.xcodeproj` by hand.

## Running tests

```bash
xcodebuild test \
  -project Speakwell.xcodeproj \
  -scheme Speakwell \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Bundle id

`com.yourcompany.speakwell` is a placeholder. Replace the `com.yourcompany`
prefix in `project.yml` before shipping.

## Next up

- Custom topic (`830:23521`), typing (`830:24924`), dictating (`830:24982`)
- Recording states: On topic, Drifting, Off topic (`830:23576`, `830:23599`,
  `830:23622`) and Another random topic (`830:23645`)
- Performance and Take complete "Below goal" (`830:23684`, `830:24735`)
- Your points popup and preview (`830:24685`, `830:24699`)
- Coaching detail screens (`830:25777` to `830:25937`)
- Transcript and suggested version (`830:26074` to `830:26214`)
- Profile appearance menu (`830:26009`)
- Session score history detail (`830:26248`)
- Real audio recording and analysis
