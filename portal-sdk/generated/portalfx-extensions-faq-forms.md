<a name="frequently-asked-questions"></a>
## Frequently asked questions

<a name="frequently-asked-questions-should-i-use-an-action-bar-or-a-commands-toolbar-on-my-form"></a>
### Should I use an action bar or a commands toolbar on my form?

It depends on the scenario that drives the UX. If the form will capture some data from the user and expect the blade to be closed after submitting the changes, then use an action bar, as specified in [portalfx-ux-create-forms.md#action-bar-+-blue-buttons](portalfx-ux-create-forms.md#action-bar-+-blue-buttons).  However, if the form will edit/update some data and expect the user to make multiple changes before the blade is closed, then use commands, as specified in . 

* Action Bar

  The action bar will have one button whose label is something like "OK", "Create", or "Submit". The blade should be automatically close immediately after the action bar button is clicked. Users can abandon the form by clicking the close button (the top-right 'x' button). Developers can use a `ParameterProvider` to simplify the code, because it provisions the `editScope` and implicitly closes the blade based on action bar clicks. 

  Alternatively, the action bar can contain two buttons, like "OK" and "Cancel", but that requires further configuration of the action bar. The two-button methos is not recommended because all the "Cancel" button is made redundant by the close button.

* Commands

  There are  typically two commands at the top of the blade: "Save" and "Discard". The user can make edits and click "Save" to commit the changes. The blade should show the appropriate UX for saving the data and will stay on the screen after the data has been saved. The user can make further changes and click "Save" again. The user can also discard their changes by clicking "Discard". Once the user is satisfied with the changes, they can close the blade manually.

