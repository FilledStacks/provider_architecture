# Provider Architecture

## [1.0.0] - Initial Release

Added the widgets required to implement the FilledStacks architectures using Provider and the responsive_builder UI package.

## [1.0.1] - Readme Updates

Fixed the readme mistakes.

## [1.0.2] - Update Dependencies

Replaced deprecated `builder` param with `create` in ChangeNotifierProvider

## [1.0.3] - Added listen configuration to Provider widget

We can now supply a listen parameter to the super class of the `ProviderWidget` to ensure it's not rebuilt when notifyListeners is called.

## [1.0.4] - Bumped provider version to ^4.0.1

## [1.0.5] - Use widgets.dart instead of material.dart

## [1.0.6] - Reusable Singleton ViewModels

We can now supply a reuseExisting parameter that will indicate to the provider setup to not dispose the viewmodel in use and reuse the same one whenever required.
