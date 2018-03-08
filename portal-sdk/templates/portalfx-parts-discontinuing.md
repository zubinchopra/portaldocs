
### Permanently discontinue a part 

Developers occasionally build and ship parts, and later  discontinue their functionality. However, there may be cases where these parts were pinned and  incorporated into the layout of a user's dashboard.

Azure customers have informed the Azure team that parts disappearing automatically from their startboards is an extremely dissatisfactory experience. To address this customer request, Azure has created a process that allows developers to permanently discontinue a part while providing a good user experience that uses customizations.

To discontinue a part, developers delete the majority of the code, but leave enough in place so that the tile still loads.  Then use the `container.noDataMessage()` api to inform the user that the part is no longer supported.

This ensures that customers are informed that this part is no longer supported, and that parts that fail will not be displayed on their dashboards.
