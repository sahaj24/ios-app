# MyApp

A professional iOS app boilerplate. The goal of this project is simplicity:
we go in a very structured way, keep the code simple, avoid complex logic,
and keep everything organized in clear folders. No clever abstractions,
no over-engineering — just a clean, predictable structure to build on.

## Tech stack

- Swift 5 / SwiftUI
- iOS 16.0+ minimum deployment target
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) to generate the
  `.xcodeproj` from `project.yml` (the project file itself is not committed,
  so there are no merge conflicts on it)
- XCTest for unit tests

## Project structure

```
ios-app/
├── project.yml              # XcodeGen project definition (source of truth)
├── Sources/
│   ├── App/
│   │   └── MyAppApp.swift   # App entry point (@main)
│   ├── Core/
│   │   └── Constants.swift  # Shared constants, no business logic
│   └── Features/
│       └── Home/
│           ├── HomeView.swift        # SwiftUI view
│           └── HomeViewModel.swift   # View model (state only)
├── Design/
│   └── Speakwell.fig        # Figma design source file
├── Resources/
│   ├── Info.plist
│   └── Assets.xcassets      # App icon, colors, images
└── Tests/
    └── HomeViewModelTests.swift
```

Structure rules we follow as the app grows:

- **`Sources/App`** — app lifecycle only (the `@main` entry point). Nothing
  else lives here.
- **`Sources/Core`** — shared code used across features: constants,
  extensions, networking, persistence. Keep it small and dependency-free
  where possible.
- **`Sources/Features/<FeatureName>`** — one folder per feature. Each
  feature folder holds its own `View` + `ViewModel` (and `Model` if the
  feature needs one). Features should not depend on each other directly;
  share code through `Core` instead.
- **`Design`** — design source files (Figma). Reference only, not part of
  the app target, so nothing in here is bundled into the build.
- **`Resources`** — assets, Info.plist, anything non-code.
- **`Tests`** — mirrors the `Sources` structure as it grows.

Keep view models simple: they hold `@Published` state for their view and
expose simple functions. Avoid putting networking, persistence, or complex
business logic directly in a view model — put that in `Core` and call into
it. If a view model starts getting large, that's a signal to split the
feature, not to add more abstraction layers.

## Getting started

1. Install XcodeGen (one-time, if not already installed):
   ```bash
   brew install xcodegen
   ```
2. Generate the Xcode project:
   ```bash
   xcodegen generate
   ```
3. Open `MyApp.xcodeproj` in Xcode and run on a simulator.

Whenever you add/remove files or change build settings, edit `project.yml`
and re-run `xcodegen generate`. Do not edit `MyApp.xcodeproj` by hand — it's
generated and gitignored.

## Running tests

From Xcode: `Cmd+U`.

From the command line:
```bash
xcodebuild test \
  -project MyApp.xcodeproj \
  -scheme MyApp \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Renaming the app

The placeholder name is `MyApp` and bundle id is `com.yourcompany.myapp`.
To rename:

1. Update `name`, `PRODUCT_BUNDLE_IDENTIFIER`, and `bundleIdPrefix` in
   `project.yml`.
2. Rename `Sources/App/MyAppApp.swift` and the struct inside it.
3. Re-run `xcodegen generate`.

## Appearance

The app is **dark mode only** for now. This is enforced with
`UIUserInterfaceStyle: Dark` in `project.yml`. We only design and build the
dark theme; light mode is out of scope until the design calls for it.

## Conventions

- One type per file, file name matches the type name.
- Keep features isolated under `Sources/Features/<FeatureName>`.
- No business logic in views — views only render state and forward user
  actions to the view model.
- Prefer simple, explicit code over generic/abstract solutions until there's
  a real, repeated need for the abstraction.
