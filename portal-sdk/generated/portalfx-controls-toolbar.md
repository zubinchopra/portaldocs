
<a name="toolbar"></a>
## Toolbar

The toolbar control provides an easy way to connect user-initiated commands with other controls. A toolbar is displayed in the following image.

![alt-text](../media/portalfx-ui-concepts/toolbar.png "Toolbar")

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

Toolbars can be added to custom part templates with the following html.

```html
<div data-bind="pcToolbar: toolbarVM" >
```

<a name="toolbar-toolbar-items"></a>
### Toolbar items

Toolbars are comprised of toolbar items. Most toolbar items are buttons. Toolbar button types can perform the following actions.

* Perform a command
* Open a link
* Open a blade
* Open a list
* Open a dialog
* Toggle on and off

All toolbar buttons have icons and labels, as in the example located at `<dir>Client\V1\Controls\Toolbar`. This code is also included in the following working example.

```ts
var commandButtonViewModel: FxToolbars.CommandButton<string> = new FxToolbars.CommandButton<string>();
commandButtonViewModel.label(ClientResources.toolbarCommitCommand);
commandButtonViewModel.icon(Image.Commit());
```

A simple command button also requires a command context and a command, as in the following code.

```ts
commandButtonViewModel.commandContext(ClientResources.toolbarCommitCommand);
commandButtonViewModel.command = new TestCommand({ resultTextBox: this.textBoxVM, itemViewModel: commandViewModel });
```

Items can then be bulk added to the toolbar, as in the following code.

```ts
var items: FxToolbars.ToolbarItemContract[] = [];
items.push(commandButtonViewModel);
...

this.toolbarVM = new MsPortalFx.ViewModels.Toolbars.Toolbar();
this.toolbarVM.setItems(items);
```

A full sample of a toolbar is located at `<dir>\Client\V1\Controls\Toolbar\ViewModels\ToolbarViewModels.ts`.
