<a name="accessibility-planning"></a>
## Accessibility Planning

Ibiza has streamlined the process of handling accessibility issues. When we resolve bugs, we send out updates for folks to be aware of progress, in addition to regressing testing updates from vendor teams. Please reach out to  <a href="mailto:ibiza-accessibility@microsoft.com?subject=Accessibility">ibiza-accessibility@microsoft.com</a> if there are any other questions or concerns. 

1. If a scenario results in multiple issues, you should  separate those issues in separate bugs. Bugs with multiple issues cannot be resolved reliably.

1.   Ensure that attachments, like .img, and .png files, contain screenshots with highlighted problem areas. Videos alone have not been helpful.

1.   Screen reader issues, like `alt-text` and `aria-attr` labels, should be reported from testing with **Edge** using **Narrator**, or **Firefox** using **NVDA**. Other combinations will be deferred.

1.   Screen reader fixes will be done for **Edge** using **Narrator** on **Windows 10** Creators Update, and **Firefox** with **NVDA**. Regression testing should take those consideration into account.

1.   Iframes are outside of  the scope of the Framework, and  do not have any dependencies on the Framework. Developers are responsible for  testing and fixing these scenarios.

1.  Legacy controls are being  deprecated, and extensions should  move to the updated version of the control in order to meet accessibility standards. A list of legacy controls is located at [top-extensions-samples-controls-deprecated.md](top-extensions-samples-controls-deprecated.md).

1. Use this [bug template](http://vstfrd:8080/Azure/RD/_workItems#_a=new&witd=RDBug&%5BSystem.AssignedTo%5D=Paymon%20Parsadmehr%20%3CNORTHAMERICA%5Cpaparsad%3E&%5BSystem.Description%5D=%3Cp%3E%3Cb%3EUpdate%26nbsp%3Bthe%20following%20fields%20and%20erase%20these%20instructions%3A%3C%2Fb%3E%3C%2Fp%3E%3Cp%3E1-%20Change%20TITLE%3C%2Fp%3E%3Cp%3E2-%20Add%20proper%20TAGS%20%28see%20email%29%3C%2Fp%3E%3Cp%3E3-%20Ensure%20FILE%20ATTACHMENTS%20include%20a%20screenshot%20circling%20the%20issue%20area%20with%20brief%20text.%20Videos%20aren%27t%20sufficient.%20Please%20don%27t%20use%20zip%20files.%3C%2Fp%3E%3Cp%3E4-%20Update%20DESCRIPTION%20with%20repro%20to%20problem%20area%20and%20expected%20behavior.%20No%20MAS%20description%2C%20no%20sample.%20Just%20repro%20and%20expectation.%3C%2Fp%3E&%5BMicrosoft.Rd.HowFound%5D=Acceptance&%5BMicrosoft.Azure.IssueType%5D=Code%20Defect&%5BSystem.AreaPath%5D=RD%5CAzure%20App%20Plat%5CAzurePortal%5CFx&%5BSystem.IterationPath%5D=RD%5CAzure%20App%20Plat%5CIbiza%5CNext) to file bugs with the Azure team.

<a name="accessibility-planning-bug-tagging"></a>
### Bug Tagging

About 95% of issues can be separated into eight categories. All bugs that you feel are framework issues are assigned to Paymon Parsadmehr. If you feel that a bug falls into more than one category, please add all corresponding tags to the bug. If the bug does not fit any category, reach out to <a href="mailto:ibiza-accessibility@microsoft.com?subject=Accessibility">Paymon Parsadmehr</a> to assess the issue. 

The following is a description of the eight tags and their categories.  There are also  examples of each bug class to help you determine what tags to use if you still need to file a bug.

1. Alternate Text

    ERROR:  Screen reader reads the text content, but the output is not helpful, or the output needs to be more descriptive, or no output is read except the control type.

    TAG: AltText

    *   Example: Screen reader cursor is on a part and all the part content is read instead of expected text.
    *   Example: Screen reader cursor is on an option picker control and all the options are read instead of a label.
    *   Bug example: [RDBug 8105335](http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=8105335): Azure API Management Service: More Services: Name Property is Empty for "Search the Market Place" edit box
 
      **NOTE**: Fixing bugs in this category may require downstream code changes. This is a top priority for the Ibiza team. We will send updates as we release SDK’s with updated controls. 

1.  Aria-attribute

    ERROR:  Functionality not exposed to screen readers. Examples: expandable, multi-selectable, item position and index, etc.

    TAG: Aria-attr

    *  Bug example: [RDBug 8259873](http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=8259873): Accessibility: MAS40B: Inspect: "Name" property is empty for 'Create' group.[Scenario: Creating NameSpace]
    
1. Contrast-Ratio 

    ERROR:  Contrast ratio of text color against background is insufficient (high contrast is a different issue).

    TAG: Contrastratio

    *   Example: Text does not have a contrast ratio of at least 7:1 on button in the “Azure” theme.

    *   Bug example: [RDBug 8091694](http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=8091694): [Accessibility] Luminosity contrast ratio is less than 4.5:1 for "Support" link in feedback pane under "Blue Alt" theme
 
1. High Contrast

    ERROR:  All issues related to High Contrast mode.

    TAG: Highcontrast

    *   Example: Focus not visible while using High Contrast Black-on-White mode in **Edge** on buttons.
    * Bug example: [RDBug 8133287](http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=8133287): Ibiza Portal: Accessibility: High Contrast - Black: Data Lake: All Resources: Previous Page button is not visible in High Contrast - Black Theme
  
1. Focus-management

    ERROR:  Focus set at an unexpected place, or focus is lost, or focus is trapped.

    TAG: Focus-management

    *   Example: Focus lost when switching value in dropdown via keyboard.
    *   Example: Cannot focus away from button once it captures focus.
    *  Bug example: [RDBug 8679020](http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=8679020): [Keyboard Navigation - KeyVault -Select Principle ] Focus order is not logical on the "Select Principle" blade.
  
1. Keyboard Accessibility 

    ERROR:  Activation and interaction via keyboard not working as expected or is inconsistent, or the item cannot be accessed via keyboard.

    TAG: KeyboardAccess

    * Example: Cannot tab to button.
    * Example: Cannot activate button with spacebar key.
    *  Bug example: [RDBug 8220516](http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=8220516): [Ibiza Portal]: Accessibility: MAS36: KB: Unable to access the Add to Favorites button (star button) for (Service Bus, Event Hubs, Relays) when navigated from "More Services -> Search Filter -> Service Bus/Event Hubs/Relays".
 
1. All issues related to Grid, regardless of the previous issues mentioned.

    ERROR:  
    TAG:
    * Example: Grid does not expose the column header on the cell (would be Aria-attr, yet triages as Grid).
    * Bug example: [RDBug 8882413](http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=8882413): Ibiza Portal:[B2A][E2A][E2E][V2A]Accessibility: Inspect :MAS40B: Name property is Inappropriate for column header items in 'Jobs' page of Azure Portal.
 
1. ListView

    ERROR:  All issues related to ListView, regardless of the previous issues mentioned.

    TAG: ListView
    * Example: ListView does not read any content when focus is set on an element (would be AltText, yet triage as ListView).
    * Bug example: [RDBug 8133284](http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=8133284): Ibiza Portal: Usability: **Narrator**: Intune Data Lake: New: **Narrator** announces Contains 0 items for a list of 3 or more items
 
