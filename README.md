# Provider Architecture

This package contains base widgets that can be used to implement the MvvmStyle provider architecture as laid out by [FilledStacks](https://www.youtube.com/filledstacks). 

## ViewModelProvider

The `ViewModelProvider` was first built in the [Provider Architecture Tutorial](https://youtu.be/kDEflMYTFlk) where it was titled BaseView. The `ViewModelProvider` is used to create the "binding" between a ViewModel and the View. There is no two-way binding in this architecture, which is why I don't want to say it's an Mvvm implementation. The `ViewModelProvider` wraps up all the `ChangeNotifierProvider` code which allows us to trigger a rebuild of a widget when calling `notifyListeners` within the ViewModel. A ViewModel is simply a dart class that extends `ChangeNotifier`. The `ViewModelProvider` has 2 constructors, one with a builder and one without a builder. The tutorial mentioned above emulates the default implementation which has been put into the `.withBuilder` named constructor. The `.withoutBuilder` constructor is for UI that does not require the model at the constructor level for it's UI. The constructor for this Model was born in this tutorial where we wanted to reduce the boiler plate when the same data to multiple widgets. 

### With Builder



The ProviderWidget was first