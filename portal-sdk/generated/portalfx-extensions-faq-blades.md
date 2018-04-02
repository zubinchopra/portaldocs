<a name="frequently-asked-questions"></a>
## Frequently asked questions

<a name="frequently-asked-questions-when-to-make-properties-observable"></a>
### When to make properties observable

*** Wwhy not make every property observable just in case you want to update it later?***

SOLUTION: The reason is performance. Using an observable string instead of a string increases the size of the `ViewModel`.  It also means that the proxied observable layer has to do extra work to connect listeners to the observable if it is ever updated. Both these factors will reduce the blade reveal performance, for literally no benefit if the observable is  never updated. Extensions should use non-observable values wherever possible. However, there are still many framework `Viewmodels` that accept only observable values, therefore the extension provides an observable even though it will never be updated.

* * *
