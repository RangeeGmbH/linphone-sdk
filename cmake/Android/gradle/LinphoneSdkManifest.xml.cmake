<?xml version="1.0" encoding="utf-8"?>
<manifest
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:installLocation="auto">

    <!-- SDK required permissions -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
	<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <!-- Needed to be able to use WifiManager.MulticastLock -->
    <uses-permission android:name="android.permission.CHANGE_WIFI_MULTICAST_STATE" />
    <uses-permission android:name="android.permission.CAMERA" />
    <!-- Needed to allow Linphone to install on tablets, since android.permission.CAMERA implies android.hardware.camera and android.hardware.camera.autofocus are required -->
    <uses-feature android:name="android.hardware.camera" android:required="false" />
    <!-- Needed for bluetooth -->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <!-- Needed for bluetooth headset -->
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <!-- To vibrate while incoming call -->
    <uses-permission android:name="android.permission.VIBRATE" />
    <!-- Needed to check current do not disturb policy -->
    <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY" />
    <!-- Required to be able to monitor WiFi signal strength -->
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <!-- End of SDK required permissions -->
	
</manifest>
