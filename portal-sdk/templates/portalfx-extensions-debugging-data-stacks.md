
## Debugging the data stack

The data stack contains all the information that the browser associates with the current testing session.  If, for example, edit scope changes are not displayed in the query cache,  or if  a row in the grid is updated without immediately apparent cause, the data stack may provide some answers to the debugging process.  Here are tips on how to debug using the data stack.

* When working with a cache object from the DataCache class, the ```dump()``` method can be used to inspect the contents of the cache at any point. By default, the ```dump()``` method  will print the data to the console, but the data can be returned as objects using `dump(true)`.  Having the data accessible as objects enables the use of methods like  `queryCache.dump(true)[0].name()`.

* When the edited data is contained in an `EditScope` object, it is accessible via the root property on the `EditScope` object. If `EditScopeView` object is being used, then the edited data is available at `editScopeView.editScope().root` after the `editScope()` observable is populated. The original data can be viewed using the `getOriginal()` method, so to view the original root object, the code can perform the  `editScope.getOriginal(editScope.root)` method.
