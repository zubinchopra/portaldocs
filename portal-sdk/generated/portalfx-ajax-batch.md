<a name="batch-api"></a>
# Batch API

If you're calling ARM you should always batch your request.
This reduces an extra 'options' calls compared to invoke. It will also reduce the number of concurrent network requests at any given time as you can batch upto 20 calls into a single request.

To batch multiple requests as one, you need a batch call not an api/invoke. The batch helpers are in the 'Fx/Ajax' module.

There are two ways to batch requests:

 1. If you already have the list of URLs and you need to make a call, use the `batchMultiple()` method. Response will be in the format that ARM returns.
 2. If you are unsure of how many requests you have and you want the framework to automatically batch multiple requests into a batch call, use the `batch()` method.

Here is a sample:

```typescript
import Batch = require("Fx/Ajax");

// In the supplyData method
return Batch.batch({
    uri: "https://management.azure.com/subscriptions/test/resourcegroups?api-version=2014-04-01-preview",
    type: "GET",
    // Add other properties as appropriate
}).then((batchResponse) => {
    return batchResponse.content;
});
```

A few points to note however:

 - The URI passed to the batch call must be an absolute URI
 - The response from a batch call is slightly different from the regular ajax call. The response will be of the form:

```typescript
export interface BatchResponseItem<T> {
    /**
    * The response content. Can be success or failure.
    */
    content: T;

    /**
    * The response headers.
    */
    headers: StringMap<string>;

    /**
    * The response status code.
    */
    httpStatusCode: number;
}
```