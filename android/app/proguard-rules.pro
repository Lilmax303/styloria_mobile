# Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Stripe Push Provisioning (fixes the missing class error)
-dontwarn com.stripe.android.pushProvisioning.**
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.reactnativestripesdk.**
-keep class com.reactnativestripesdk.** { *; }

# Keep all Stripe classes
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

# Google Play Services
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**