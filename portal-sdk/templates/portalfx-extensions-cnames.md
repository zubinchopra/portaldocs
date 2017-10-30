<a name="portalfxExtensionsCnames"></a>

<!-- link to this document is [portalfx-extensions-cnames.md]()
-->
## Creating CNAMES
 Extension URLs use a standard CNAME pattern. The  CNAMEs can be created using DNS's that are specific to each environment, and use any Azure property as the identity.  The following table describes the URL's for each environment.

| Environment	| URL |
| --- | ---|
| DOGFOOD	| df.{extension}.onecloud-ext.azure-test.net |
| PROD	| 	main.{extension}.ext.azure.com |
| BLACKFOREST	| main.{extension}.ext.microsoftazure.de |
| FAIRFAX		| main.{extension}.ext.azure.us |
| MOONCAKE		| main.{extension}.ext.azure.cn |


## Dogfood and Production CNAMES
Create DOGFOOD/PROD CNAMEs using Microsoft's DNS that is located at
 [https://azure.microsoft.com/en-us/services/dns/](https://azure.microsoft.com/en-us/services/dns/) or [https://docs.microsoft.com/en-us/azure/dns/dns-getstarted-portal](https://docs.microsoft.com/en-us/azure/dns/dns-getstarted-portal). Use  any Azure property as the identity.

<!--TODO: Validate whether this was the site that was intended for the phrase " Microsoft's DNS"  -->

The PROD CNAME will be used for RC, MPAC, Preview and PROD environments.

## Other Environments
Create National Cloud CNAMEs using the process specified in each cloud.
 For more information, search for "DNS" on their wiki pages.
 | CLOUD | LOCATION |
 | --- | --- |
 |Fairfax | [http://aka.ms/fairfax](http://aka.ms/fairfax) |
 | 	Blackforest  | [http://aka.ms/blackforest](http://aka.ms/blackforest)  |
 | Mooncake | [http://aka.ms/mooncake](http://aka.ms/mooncake) |
 
 Then, send a request to add a CNAME for your extension to the appropriate environment, as specified in the following sections.

## Fairfax	

  A TFS item that requests adding a CNAME to the FairFax environment is desctribed in following image.
  
  ![alt-text](../media/portalfx-extensions/fairFaxCNameRequestTemplate.png
    "FairFax Request Template")

The parameters that the workitem contains are as follows:

```
_a=new

witd=RDTask

[System.Title]=Manage DNS record in static zones in FF - {requestor} - {domain}

[System.AssignedTo]=Windows Azure DNSOps

[System.Description]=<p>Complete after (date):</p>
<p>Complete before (date):</p>
<p>Requestor:</p>
<p>Requesting team:</p>
<p>Business justification:</p>
<p><br></p>
<p>=Change 1=</p>
<p>Domain name: </p>
<p>Action: [Add|Modify|Delete]</p>
<p>Old Values:</p>
<p>&nbsp;&nbsp; sample IN A 3600 127.0.0.1</p>
<p>New Values:&nbsp;</p>
<p>&nbsp;&nbsp; sample IN A 300 127.0.0.1</p>
<p><br></p>
<p>=Instructions=</p>
<p>Please email rdnet-dns-azdns for normal triage/execution. Please engage 
CloudNet\DNS on call for sev 0-2 breakfix changes</p>

[Microsoft.RD.KeywordSearch]=ADNSServiceMgmt

[Microsoft.Azure.IssueType]=Other

[System.AreaPath]=Fairfax\Networking\DNS\AzDNS. 
```


 To open the TFS item, use the template on the site located at
  [http://vstfrd:8080/Azure/Fairfax](http://vstfrd:8080/Azure/Fairfax/_workitems?_a=new&witd=RDTask&%5BSystem.Title%5D=Manage%20DNS%20record%20in%20static%20zones%20in%20FF%20-%20%7Brequestor%7D%20-%20%7Bdomain%7D&%5BSystem.AssignedTo%5D=Windows%20Azure%20DNSOps&%5BSystem.Description%5D=%3Cp%3EComplete%20after%20%28date%29%3A%3C%2Fp%3E%3Cp%3EComplete%20before%20%28date%29%3A%3C%2Fp%3E%3Cp%3ERequestor%3A%3C%2Fp%3E%3Cp%3ERequesting%20team%3A%3C%2Fp%3E%3Cp%3EBusiness%20justification%3A%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DChange%201%3D%3C%2Fp%3E%3Cp%3EDomain%20name%3A%20%3C%2Fp%3E%3Cp%3EAction%3A%20%5BAdd%7CModify%7CDelete%5D%3C%2Fp%3E%3Cp%3EOld%20Values%3A%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%203600%20127.0.0.1%3C%2Fp%3E%3Cp%3ENew%20Values%3A%26nbsp%3B%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%20300%20127.0.0.1%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DInstructions%3D%3C%2Fp%3E%3Cp%3EPlease%20email%20rdnet-dns-azdns%20for%20normal%20triage%2Fexecution.%20Please%20engage%20CloudNet%5CDNS%20on%20call%20for%20sev%200-2%20breakfix%20changes%3C%2Fp%3E&%5BMicrosoft.RD.KeywordSearch%5D=ADNSServiceMgmt&%5BMicrosoft.Azure.IssueType%5D=Other&%5BSystem.AreaPath%5D=Fairfax%5CNetworking%5CDNS%5CAzDNS).  

  Another example of a TFS item requesting a different hosting service extension is located at [http://vstfrd:8080/Azure/Fairfax/_workitems?_a=edit&id=8798254&fullScreen=false](http://vstfrd:8080/Azure/Fairfax/_workitems?_a=edit&id=8798254&fullScreen=false).

## Blackforest
A TFS item that requests adding a CNAME to the BlackForest environment is described in the following image.
  
  ![alt-text](../media/portalfx-extensions/blackForestCNameRequestTemplate.png
    "BlackForest Request Template")

The parameters that the workitem contains are as follows:

```
_a=new

witd=RDTask

[System.Title]=Manage DNS record in static zones in BF - {requestor} - {domain}

[System.AssignedTo]=Windows Azure DNSOps

[System.Description]=<p>Complete after (date):</p>
<p>Complete before (date):</p>
<p>Requestor:</p>
<p>Requesting team:</p>
<p>Business justification:</p>
<p><br></p>
<p>=Change 1=</p>
<p>Domain name: </p>
<p>Action: [Add|Modify|Delete]</p>
<p>Old Values:</p>
<p>&nbsp;&nbsp; sample IN A 3600 127.0.0.1</p>
<p>New Values:&nbsp;</p>
<p>&nbsp;&nbsp; sample IN A 300 127.0.0.1</p>
<p><br></p>
<p>=Instructions=</p>
<p>Please email rdnet-dns-azdns for normal triage/execution. Please engage
 CloudNet\DNS on call for sev 0-2 breakfix changes</p>

[Microsoft.RD.KeywordSearch]=ADNSServiceMgmt

[Microsoft.Azure.IssueType]=Other

[System.AreaPath]=BlackForest\Networking\DNS\AzDNS

```
  
 To open the TFS item, use the template on the site located at [http://vstfrd:8080/Azure/BlackForest](http://vstfrd:8080/Azure/BlackForest/_workitems?_a=new&witd=RDTask&%5BSystem.Title%5D=Manage%20DNS%20record%20in%20static%20zones%20in%20BF%20-%20%7Brequestor%7D%20-%20%7Bdomain%7D&%5BSystem.AssignedTo%5D=Windows%20Azure%20DNSOps&%5BSystem.Description%5D=%3Cp%3EComplete%20after%20%28date%29%3A%3C%2Fp%3E%3Cp%3EComplete%20before%20%28date%29%3A%3C%2Fp%3E%3Cp%3ERequestor%3A%3C%2Fp%3E%3Cp%3ERequesting%20team%3A%3C%2Fp%3E%3Cp%3EBusiness%20justification%3A%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DChange%201%3D%3C%2Fp%3E%3Cp%3EDomain%20name%3A%20%3C%2Fp%3E%3Cp%3EAction%3A%20%5BAdd%7CModify%7CDelete%5D%3C%2Fp%3E%3Cp%3EOld%20Values%3A%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%203600%20127.0.0.1%3C%2Fp%3E%3Cp%3ENew%20Values%3A%26nbsp%3B%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%20300%20127.0.0.1%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DInstructions%3D%3C%2Fp%3E%3Cp%3EPlease%20email%20rdnet-dns-azdns%20for%20normal%20triage%2Fexecution.%20Please%20engage%20CloudNet%5CDNS%20on%20call%20for%20sev%200-2%20breakfix%20changes%3C%2Fp%3E&%5BMicrosoft.RD.KeywordSearch%5D=ADNSServiceMgmt&%5BMicrosoft.Azure.IssueType%5D=Other&%5BSystem.AreaPath%5D=BlackForest%5CNetworking%5CDNS%5CAzDNS).

  Another example of a TFS item requesting another hosting service extension is located at [http://vstfrd:8080/Azure/BlackForest/_workItems?id=8798256&fullScreen=false&_a=edit](http://vstfrd:8080/Azure/BlackForest/_workItems?id=8798256&fullScreen=false&_a=edit).

## Mooncake	
Follow the specification located at [http://sharepoint/sites/CIS/waps/WAPO/Creating%20CName%20DNS%20Entry%20in%20Mooncake.aspx](http://sharepoint/sites/CIS/waps/WAPO/Creating%20CName%20DNS%20Entry%20in%20Mooncake.aspx).

Another example of a TFS item requesting another hosting service extension is located at [http://vstfrd:8080/Azure/Mooncake/_workitems?_a=edit&id=8798258&fullScreen=false](http://vstfrd:8080/Azure/Mooncake/_workitems?_a=edit&id=8798258&fullScreen=false).

## Glossary

 [portalfx-extensions-cnames-glossary.md](portalfx-extensions-cnames-glossary.md)