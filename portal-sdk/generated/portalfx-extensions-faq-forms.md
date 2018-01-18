<a name="frequently-asked-questions"></a>
## Frequently asked questions

<a name="frequently-asked-questions-should-i-use-an-action-bar-or-a-commands-toolbar-on-my-form"></a>
### Should I use an action bar or a commands toolbar on my form?

It depends on the  scenario that drives the UX that is being built.

* If the form will capture some data from the user and expect the blade to be closed after submitting the changes, then use an action bar, as specified in [portalfx-ux-create-forms.md#action-bar-+-blue-buttons](portalfx-ux-create-forms.md#action-bar-+-blue-buttons). 
* If the form will edit/update some data and expect the user to make multiple changes before the blade is closed, then use commands, as specified in . 

Action Bar
The action bar will have one button that says something like "OK", "Create", or "Submit". The blade should be immediately closed automatically once the action bar button is clicked. Users can abandon the form by manually closing it by clicking the close button (the top-right 'x' button). You probably want to use a parameter provider to simplify your code; it takes care of provisioning the edit scope and closing the blade based on action bar clicks. Also alternatively, you can use an action bar with two buttons (like "OK/Cancel"), but that requires further configuration of the action bar. That's not recommended though because all the "Cancel" button will do is already there in close button, which makes it redundant.

Commands
You would normally have two commands at the top of the blade: "Save" and "Discard". The user can make edits and click "Save" to commit their changes. The blade should show the appropriate UX for saving the data and will stay on the screen after the data has been saved. The user can make further changes and click "Save" again. The user can also discard their changes by clicking "Discard". Once the user is satisfied with the changes, they can close theblade manually.

