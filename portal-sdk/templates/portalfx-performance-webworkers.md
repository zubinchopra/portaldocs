## Web workers

As you are already aware performance of the Portal is one of the bigger customer pain points and a major driver for dissatisfaction with NPS (Net promoter score).
 
We’ve been actively working with different teams on a one-on-one basis, whilst also trying to improve performance from the framework side.
 
One of the bigger opportunities we’ve been working towards is moving extensions into their own web workers. This will give extension’s their own separate thread to run which won’t be blocking or blocked on the main thread. As we move more and more extensions over to this model performance across the board should increase.

To read more about web workers see https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API.
 
### How to test/opt into web workers: 

You can opt into this experience today via the below methods;
1.	Test locally using [https://ms.portal.azure.com?feature.webworker=true,<your_extension_name>](https://ms.portal.azure.com?feature.webworker=true,<your_extension_name>)
1.	Flight this functionality in https://ms.portal.azure.com (internal @microsoft.com users only)
1.	Enable it for all users
    
#### To flight this functionality;
    
1.	File a work item (https://aka.ms/portalfx/task) 
1.	Choose what percentage you want to flight at ( ‘flightWebWorkers’ is on a 0-1 scale where 0.5 = 50%)
1.	Update your entry in `extensions.prod.json` (https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx?path=%2Fsrc%2FRDPackages%2FOneCloud%2FExtensions.prod.json&version=GBdev)
1.	Submit a pull request for that change
 
Change to be made:

```json
{
    name: "<Your_Extension_Name>",
    features: {
       flightWebWorkers: 0.5
    },
},
```
 
#### To enable this functionality;

1.	File a work item (https://aka.ms/portalfx/task)
1.	Update your entry in `extensions.prod.json` (https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx?path=%2Fsrc%2FRDPackages%2FOneCloud%2FExtensions.prod.json&version=GBdev)
1.	Submit a pull request for that change
 
Change to be made:

```json
{
    name: "<Your_Extension_Name>",
    features: {
        supportsWebWorkers: "true"
    },
},
```
 

### Known gotachas:

- DOM manipulation
- Utilising local/session storage
- Utilising cookies