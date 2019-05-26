# netshEnableDisable
Script that runs at startup that enables then disables auto configuration logic for a wlan interface. Begins with enabling since
Windows wont connect to the saved network when auto configuration is turned off.

Disableing auto configuration logic means Windows wont scan for nearby networks which fixes weird Windows 10 ping issues when on WiFi.
