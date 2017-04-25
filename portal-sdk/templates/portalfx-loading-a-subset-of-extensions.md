
## Loading a Subset of Extensions
There are some instances during test where you may want to only load your
extension or a subset of extensions within the portal. You can do this using the
feature.DisableExtensions feature flag. 

Usage: 

```
?feature.DisableExtensions=true&HubsExtension=true&Microsoft_Azure_Support=true&MyOtherExtension=true
```

- This will make every extension disabled by default.
- This will enable hubs (which almost everyone needs).
- This will enable the particular extension you want to test. 
- You can add multiple like the HubsExtension=true and MyOtherExtension=true if
you want to test other extensions.

## Disabling a specific extension

If you want to disable a single extension, you can use the canmodifyextensions
feature flag like below.

```
?feature.canmodifyextensions=true&ExtensionNameToDisable=false
```

An example of this is when you want to turn off an old extension and turn on a
new one. You can do this as follows: -

```
?feature.canmodifyextensions=true&MyOldExtension=false&MyNewExtension=true
```
