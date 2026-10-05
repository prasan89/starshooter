# Flutter + Flame ProGuard Rules
# Keep Flutter wrapper classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Flutter embedding classes
-keep class io.flutter.embedding.** { *; }

# Flame engine (dart2java bridge objects)
-keep class com.google.** { *; }

# Keep application entry point
-keep class com.starshooter.game.** { *; }

# Suppress warnings for missing classes in release builds
-dontwarn io.flutter.embedding.**
-dontwarn io.flutter.plugin.**

# Keep annotations
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable

# For native methods
-keepclasseswithmembernames class * {
    native <methods>;
}
