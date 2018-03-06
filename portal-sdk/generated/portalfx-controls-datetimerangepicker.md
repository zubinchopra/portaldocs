<a name="datetimerangepicker"></a>
## DateTimeRangePicker

The DateTimeRangePicker control provides an easy way select a date/time range, for example, "Start: 6/5/2017 00:00:00 AM, End: 7/9/2018 00:00:00 AM". 

The `DateTimeRangePicker` control is the recommended control for date/time range selection.

**NOTE**:  All previous controls that provided this functionality are obsolete.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

1. The DateTimeRangePicker control is used by importing the module, as in the following code.
    ```
    import * as DateTimeRangePicker from "Fx/Controls/DateTimeRangePicker";
    ```

1. Then, create the ViewModel.
    ```
    public dateTimeRangePicker: DateTimeRangePicker.Contract;

    this.DateTimeRangePicker = DateTimeRangePicker.create(container, {
        label: "someLabel"
        //Other options...
    });
    ```

1. Insert the `DateTimeRangePicker` control as a member of a Section, or include it in an HTML template by using a 'pcControl' binding. The sample is located at 
`<dir>\Client\V2\Controls\DateTimeRangePicker\DateTimeRangePickerBlade.ts`. This code is also included in the working copy located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions).

<a name="migrating-from-previous-datetimecombo-or-datetimecombobox"></a>
## Migrating from previous DateTimeCombo or DateTimeComboBox

1. Update the namespace with DateTimeRangePicker

     * Old code

        ```
        var startDateTimeViewModel = new MsPortalFx.ViewModels.Obsolete.Forms.DateTimeComboBox.ViewModel(container, {...});
        var endDateTimeViewModel = new MsPortalFx.ViewModels.Obsolete.Forms.DateTimeComboBox.ViewModel(container, {...});

        ```
  
     * New code

        ```
        import * as DateTimeRangePicker from "Fx/Controls/DateTimeRangePicker";

        var dateTimeRangePickerVM = DateTimeRangePicker.create(container, {
            value: new MsPortalFx.DateUtil.DateTimeRange(new Date(2014, 5, 13, 13, 45, 0), new Date(2014, 5, 20, 13, 45, 0)),
            startDateTimeEnabledRange: new MsPortalFx.DateUtil.DateTimeRange(new Date(2016, 1, 1, 0, 0, 0), new Date(2017, 1, 1, 0, 0, 0)),
            endDateTimeEnabledRange: new MsPortalFx.DateUtil.DateTimeRange(new Date(2017, 1, 1, 0, 0, 0), new Date(2018, 1, 1, 0, 0, 0)),
            validations: [
                new MsPortalFx.ViewModels.CustomValidation("", <any>((value: MsPortalFx.DateUtil.DateTimeRange): MsPortalFx.Base.PromiseV<MsPortalFx.ViewModels.ValidationResult> => {
                    return Q({
                        valid: value.startDateTime() <= value.endDateTime(),
                        message: "Start date/time has to be before end date/time"
                    });
                }))
            ],
        });
        ```

1. If the `DateTimeComboBox.formatString` was set, it should be removed from the extension. The new `DateTimePicker` does not support formatting the datetime value now. The values are presented in general long date/time pattern  by default, for example, "6/7/2017 4:20:00 PM". An example of the code that should be removed is as follows.

    ```
    startDateTimeViewModel.formatString("G");
    endDateTimeViewModel.formatString("G");
    ```

