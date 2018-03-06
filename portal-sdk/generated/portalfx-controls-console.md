
<a name="console"></a>
## Console

The console control provides a REPL-like experience which provides an environment similar to the command line, `bash`, or **PowerShell**.
<!--TODO:  Locate a better definition for the console control. -->

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.


The `console` control is displayed in the following image.

![alt-text](../media/portalfx-controls/console-large.png "Console")

1. The `console` control is used by importing the module, as in the following code.  Insert the `console` control as a member of a Section, or include it in an HTML template by using a 'pcControl' binding. The sample is located at 
`<dir>\Client\V1\Controls\Console2\Templates\Console2SimpleInstructions.html`. This code is also included in the following working copy.

    ```html
    <div data-bind='pcConsole: consoleViewModel'></div>
    ```

1. Then, create the ViewModel. The sample is located at `<dir>\Client\V1\Controls\Console2\ViewModels\Console2ViewModels.ts`
 This code is also included in the following working copy.

    ```ts
    public consoleViewModel: MsPortalFx.ViewModels.Controls.Console.Contract;

    constructor(container: MsPortalFx.ViewModels.PartContainerContract,
                initialState: any,
                dataContext: ControlsArea.DataContext) {

        // Initialize the console ViewModel.
        this.consoleViewModel = new MsPortalFx.ViewModels.Controls.Console.ViewModel();

        // To get input from the user, subscribe to the command observable.
        // This is where you would parse the incomming command.
        // To show output, you can set the info, warning, success and error properties.
        this.consoleViewModel.command.subscribe(container, (s) => {
            // In this example, we are just piping back the input as an info, warning, success or error message based off of what you type in.
            switch (s) {
                case ClientResources.consoleInfo:
                    this.consoleViewModel.info(s);
                    break;
                case ClientResources.consoleWarning:
                    this.consoleViewModel.warning(s);
                    break;
                case ClientResources.consoleSuccess:
                    this.consoleViewModel.success(s);
                    break;
                case ClientResources.consoleError:
                    this.consoleViewModel.error(s);
                    break;
                default:
                    this.consoleViewModel.error(s);
            }
        });

        // You can also observably set the prompt which is displayed above the > in the console.
        this.consoleViewModel.prompt = ko.observable(ClientResources.consolePrompt);
    }
    ```
