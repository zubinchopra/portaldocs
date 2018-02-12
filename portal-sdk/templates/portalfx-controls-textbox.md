## Textbox

The `Textbox` control provides an easy way to allow users to input data.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

1. The Textbox control is used by importing the module, as in the following code.

    ```c#
    import * as TextBox from "Fx/Controls/TextBox";
    ```

1. Then, create the ViewModel.

    ```c#
    public textBox: TextBox.Contract;

    this.textBox = TextBox.create(container, {
        label: "someLabel"
        //Other options...
    });
    ```

1. Insert the `Textbox` control as a member of a Section, or include it in an HTML template by using a 'pcControl' binding. The sample is located at `\Client\V2\Controls\TextBox\TextBoxBlade.ts`. This code is also included in the working copy located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/Textboxblade](http://aka.ms/portalfx/samples#blade/SamplesExtension/Textboxblade).

## Migrating from  `TextBox`

The `MsPortalFx.ViewModels.Controls.Forms.TextBox` control is being deprecated. When the Ibiza SDK is updated to a newer version,  compile-time errors will reflect this.

<!--TODO:  Determine what namespace contains the new one, if the old one is named MsPortalFx.ViewModels.Controls.Forms.TextBox -->

Use the following steps to replace the deprecated control with the new `TextBox` control in the `Fx/Controls/TextBox` module.

1. Update the `Textbox` with the new namespace.

    <details>
    <summary>Old code</summary>

    ```cs
    const textBoxVM = new MsPortalFx.ViewModels.Controls.Forms.TextBox.ViewModel(lifetimeManager, {...// Options goes here});
    ```
    </details>
    <details>
    <summary>New code</summary>

    ```cs
    import * as TextBox from "Fx/Controls/TextBox";
    const textBoxVM = TextBox.create(lifetimeManager, {...// Options goes here});
    ```
    </details>

1. Update the properties, especially `TextBox.ViewModel.placeholder` and `TextBox.ViewModel.events.enterPressed`, for `TextBox.ViewModel.placeholder`.
    <details>
    <summary>Old code</summary>

    ```cs
    textBoxVM.placeHolder("PlaceHolder text goes here");
    ```
    </details>
    <details>
    <summary>New code</summary>

    ```cs
    const textBoxVM = TextBox.create(lifetimeManager, {
        placeHolderText: "PlaceHolder text goes here",
        //other options goes here…
    });

    //or

    textBoxVM.placeHolderText("PlaceHolder text goes here");
    ```
    </details>
1. Move the `TextBox.ViewModel.events.enterPressed` method  to the `TextBox.ViewModel.onEnterPressed` method.

    <details>
    <summary>Old code</summary>
    <!--TODO:  Determine whether  enterPresseded is a typographical error. -->
    
    ```cs
    textBoxVM.events.enterPressed = (value: string): void => {
        // Functions goes here...
        let enterPresseded: boolean = true;
    };
    ```
    </details>
    <details>
    <summary>New code</summary>
    
    ```cs
    const textBoxVM = TextBox.create(lifetimeManager, {
        onEnterPressed: (value: string) => {
            // Functions goes here...
            let enterPresseded: boolean = true;
        }
    });
    ```
    </details>