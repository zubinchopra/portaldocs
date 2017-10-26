
<a name="portalfxExtensionsBladeHelloWorldOverview"></a>

<!-- link to this document is [portalfx-extensions-blade-helloWorld-overview.md]()
-->

## Conceptual Overview

Use the following steps to develop a blade.
1.	 You and your team will determine the types of blades that can be grouped together.  Decide on a name for this group, or area.  In this example, the area for blades is named ```Greetings```, and the blade that is being developed is named ```Aloha```. Remember to remove the angle brackets when substituting the name of the group for the parameter name <AreaName>.
1.	Add a folder for the group of blades within the ```Client``` folder of the project. It should be named the same as the area.

    ![alt-text](../media/portalfx-extensions-AreaFolder.png "Azure Portal Marketplace")

1.	Add a file for the blade you are developing to the folder. The file should be named the same as the blade.

    ![alt-text](../media/portalfx-extensions-AreaBladeFile.png "Azure Portal Marketplace")

1.	Also add a file that describes the area to the area folder.  The name of the file should be the name of the group, concatenated with the word ‘Area’. 

    ![alt-text](../media/portalfx-extensions-AreaGroupFile.png "Azure Portal Marketplace")

1.	Within the file that was just created, add the following code.

    ```
    export class DataContext {
    }
    ```

1. There are some basic parts that are required in the blade file.  The first part is the import statements, as in the following example.

    ```
    import * as TemplateBlade from "Fx/Composition/TemplateBlade";
    import { DataContext } from "./<AreaName>Area"; // todo – substitute the name of the area, and remove the angle brackets 
    ```

1.	The second code part is the template blade decorator. This lets the framework discover your blade. It is also where the html template is defined.

    The following  example shows the first part of a simple text data-binding. The corresponding data-binding code is in the next example.

    ```
    @TemplateBlade.Decorator({
        htmlTemplate: `<div data-bind='text: helloWrldMsg'></div>`
    })

    export class <BladeName> // todo – substitute the name of the blade, and remove the angle brackets 
    {

    }
    ```

1.	The following code implements the class for the new blade. In this instance the code sets the title, subtitle, and binds the string 'Hello world!' to the UI. This code should be added to the class in the TemplateBlade decorator from the preceding step.

    NOTE: the text from the data-bind statement is named the same as the message, thereby completing the binding.

    ```
        public title = "My blade title";
        public subtitle = "My blade subtitle";
        public context: TemplateBlade.Context<void, DataContext>; // there are useful framework APIs that hang off of here
        public helloWrldMsg = ko.observable("Hello world!"); // this is bound in the div statement in the previous example 

        public onInitialize()
        {
        // run any initialization code you need here
        return Q();   // if you load data then return a loading promise here
        }
    ```

1.	 The blade can now be compiled. 

1.	Test the new blade by using a link in the following format in the address bar of the browser.

    ```
    <PORTAL URI>#blade/<ExtensionName>/<BladeName>
    ```
  
    where

    ```#blade ``` is a literal

    ```ExtensionName ```
    is the name of the extension that contains the blade

    ```BladeName``` is the name of the blade that is being developed


    One example is as follows.
    ```
    https://portal.azure.com#blade/HelloWorld6/Aloha 
    ```

    Keep in mind that there may be parameters to pass to Azure that affect the loading of the portal.  In the following case, the parameters are included in the URL previous to the name of the blade.

    ```
    https://portal.azure.com/?feature.customportal=false&feature.canmodifyextensions=true#blade/HelloWorld6/Aloha
    ```

    Also, test extensions may be added to the URI after the name of the blade that was just added, as in the following example.

    ```
    https://portal.azure.com/?feature.customportal=false&feature.canmodifyextensions=true#blade/HelloWorld6/Aloha?testExtensions={"HelloWorld6":"https://localhost:44300/"}
    ```

    When the site is properly accessed, the blade from this example should resemble the following inmage.

    ![alt-text](../media/portalfx-extensions-HelloWorldExtensionAlohaBlade.png "Azure Portal Marketplace")

