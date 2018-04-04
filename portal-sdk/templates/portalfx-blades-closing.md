
## Closing blades programatically


Code that closes the current blade can be called from either a blade or part container. The extension can optionally return untyped data to the parent blade when the child blade is  closed.

The blade opening sample is located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi). The 'Close' button on the child blades that open is implemented using the blade closing APIs.

The following methods are now available on the  template blade container.

```typescript

import { Container as BladeContainer } from "Fx/Composition/Blade";
   
// closes the current blade now, optionally passing data back to the parent
closeCurrentBlade(data?: any): Promise<boolean>; 
// closes the current child blade now, if one is present
closeChildBlade(): Promise<boolean>; 
// closes the current child context blade now, if one is present
closeContextBlade(): Promise<boolean>; 
```

The following methods are  available on the  part container contract.

```typescript
// closes the current child blade now, if one is present
closeChildBlade(): Promise<boolean>; 
// closes the current child context blade now, if one is present
closeContextBlade(): Promise<boolean>; 
```

Each of these methods returns a `promise` that typically returns `true`.  If a blade on the screen contains  unsaved edits to a form, the Framework will issue a prompt that allows the user to keep the unsaved blade open.  If the user chooses to continue working on their unsaved edits, then the `promise` that is returned when the blade closes will return `false`.

## Responding to blade closing

When an extension opens a child blade, it can register the optional `onClosed` callback to be notified when the child blade closes.  The child blade can send untyped data that can be used in the  callback, as in the following example.
 
```typescript
import { BladeClosedReason } from "Fx/Composition";
...
container.openBlade(new SomeBladeReference({ … }, (reason: BladeClosedReason, data?: any) => {
        // Code that runs when the blade closes - Data will only be there if the child blade returned it.
        // It  lets you differentiate between things like the user closing the blade via the close button vs. a parent blade programatically closing it
});
```

