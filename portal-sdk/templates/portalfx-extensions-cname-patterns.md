<a name="portalfxExtensionsCnamePatterns"></a>

<!-- link to this document is [portalfx-extensions-cname-patterns.md]()
-->
## CNAME Patterns
 Extension URLs must use a standard CNAME pattern. Create CNAMEs using Microsoft's DNS that is located at    , and use any Azure property as the identity.

| Environment	| URL |
| --- | ---|
| DOGFOOD	| df.{extension}.onecloud-ext.azure-test.net |
| PROD	| 	main.{extension}.ext.azure.com |
| BLACKFOREST	| main.{extension}.ext.microsoftazure.de |
| FAIRFAX		| main.{extension}.ext.azure.us |
|  MOONCAKE		| main.{extension}.ext.azure.cn |

## Creating CNAMES

Create DOGFOOD/PROD CNAMEs using Microsoft's DNS that is located at    , and use any Azure property as the identity.

The PROD CNAME will be used for RC, MPAC, Preview and PROD environments.

Create National Cloud CNAMEs using the process specified in each cloud.
 For more information, search for "DNS" on their wiki pages.
 | CLOUD | LOCATION |
 | --- | --- |
 |Fairfax | [http://aka.ms/fairfax](http://aka.ms/fairfax) |
 | 	Blackforest  | [http://aka.ms/blackforest](http://aka.ms/blackforest)  |
 | Mooncake | [http://aka.ms/mooncake](http://aka.ms/mooncake) |

### Fairfax	

  Open TFS item requesting adding a CNAME using the template located at [http://vstfrd:8080/Azure/Fairfax/_workitems?_a=new&witd=RDTask&%5BSystem.Title%5D=Manage%20DNS%20record%20in%20static%20zones%20in%20FF%20-%20%7Brequestor%7D%20-%20%7Bdomain%7D&%5BSystem.AssignedTo%5D=Windows%20Azure%20DNSOps&%5BSystem.Description%5D=%3Cp%3EComplete%20after%20%28date%29%3A%3C%2Fp%3E%3Cp%3EComplete%20before%20%28date%29%3A%3C%2Fp%3E%3Cp%3ERequestor%3A%3C%2Fp%3E%3Cp%3ERequesting%20team%3A%3C%2Fp%3E%3Cp%3EBusiness%20justification%3A%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DChange%201%3D%3C%2Fp%3E%3Cp%3EDomain%20name%3A%20%3C%2Fp%3E%3Cp%3EAction%3A%20%5BAdd%7CModify%7CDelete%5D%3C%2Fp%3E%3Cp%3EOld%20Values%3A%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%203600%20127.0.0.1%3C%2Fp%3E%3Cp%3ENew%20Values%3A%26nbsp%3B%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%20300%20127.0.0.1%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DInstructions%3D%3C%2Fp%3E%3Cp%3EPlease%20email%20rdnet-dns-azdns%20for%20normal%20triage%2Fexecution.%20Please%20engage%20CloudNet%5CDNS%20on%20call%20for%20sev%200-2%20breakfix%20changes%3C%2Fp%3E&%5BMicrosoft.RD.KeywordSearch%5D=ADNSServiceMgmt&%5BMicrosoft.Azure.IssueType%5D=Other&%5BSystem.AreaPath%5D=Fairfax%5CNetworking%5CDNS%5CAzDNS](http://vstfrd:8080/Azure/Fairfax/_workitems?_a=new&witd=RDTask&%5BSystem.Title%5D=Manage%20DNS%20record%20in%20static%20zones%20in%20FF%20-%20%7Brequestor%7D%20-%20%7Bdomain%7D&%5BSystem.AssignedTo%5D=Windows%20Azure%20DNSOps&%5BSystem.Description%5D=%3Cp%3EComplete%20after%20%28date%29%3A%3C%2Fp%3E%3Cp%3EComplete%20before%20%28date%29%3A%3C%2Fp%3E%3Cp%3ERequestor%3A%3C%2Fp%3E%3Cp%3ERequesting%20team%3A%3C%2Fp%3E%3Cp%3EBusiness%20justification%3A%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DChange%201%3D%3C%2Fp%3E%3Cp%3EDomain%20name%3A%20%3C%2Fp%3E%3Cp%3EAction%3A%20%5BAdd%7CModify%7CDelete%5D%3C%2Fp%3E%3Cp%3EOld%20Values%3A%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%203600%20127.0.0.1%3C%2Fp%3E%3Cp%3ENew%20Values%3A%26nbsp%3B%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%20300%20127.0.0.1%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DInstructions%3D%3C%2Fp%3E%3Cp%3EPlease%20email%20rdnet-dns-azdns%20for%20normal%20triage%2Fexecution.%20Please%20engage%20CloudNet%5CDNS%20on%20call%20for%20sev%200-2%20breakfix%20changes%3C%2Fp%3E&%5BMicrosoft.RD.KeywordSearch%5D=ADNSServiceMgmt&%5BMicrosoft.Azure.IssueType%5D=Other&%5BSystem.AreaPath%5D=Fairfax%5CNetworking%5CDNS%5CAzDNS).  

  Another example of a TFS item requesting another hosting service extension is located at [http://vstfrd:8080/Azure/Fairfax/_workitems?_a=edit&id=8798254&fullScreen=false](http://vstfrd:8080/Azure/Fairfax/_workitems?_a=edit&id=8798254&fullScreen=false).

### Blackforest
  Open TFS item requesting adding a CNAME using the template located at [http://vstfrd:8080/Azure/BlackForest/_workitems?_a=new&witd=RDTask&%5BSystem.Title%5D=Manage%20DNS%20record%20in%20static%20zones%20in%20BF%20-%20%7Brequestor%7D%20-%20%7Bdomain%7D&%5BSystem.AssignedTo%5D=Windows%20Azure%20DNSOps&%5BSystem.Description%5D=%3Cp%3EComplete%20after%20%28date%29%3A%3C%2Fp%3E%3Cp%3EComplete%20before%20%28date%29%3A%3C%2Fp%3E%3Cp%3ERequestor%3A%3C%2Fp%3E%3Cp%3ERequesting%20team%3A%3C%2Fp%3E%3Cp%3EBusiness%20justification%3A%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DChange%201%3D%3C%2Fp%3E%3Cp%3EDomain%20name%3A%20%3C%2Fp%3E%3Cp%3EAction%3A%20%5BAdd%7CModify%7CDelete%5D%3C%2Fp%3E%3Cp%3EOld%20Values%3A%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%203600%20127.0.0.1%3C%2Fp%3E%3Cp%3ENew%20Values%3A%26nbsp%3B%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%20300%20127.0.0.1%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DInstructions%3D%3C%2Fp%3E%3Cp%3EPlease%20email%20rdnet-dns-azdns%20for%20normal%20triage%2Fexecution.%20Please%20engage%20CloudNet%5CDNS%20on%20call%20for%20sev%200-2%20breakfix%20changes%3C%2Fp%3E&%5BMicrosoft.RD.KeywordSearch%5D=ADNSServiceMgmt&%5BMicrosoft.Azure.IssueType%5D=Other&%5BSystem.AreaPath%5D=BlackForest%5CNetworking%5CDNS%5CAzDNS](http://vstfrd:8080/Azure/BlackForest/_workitems?_a=new&witd=RDTask&%5BSystem.Title%5D=Manage%20DNS%20record%20in%20static%20zones%20in%20BF%20-%20%7Brequestor%7D%20-%20%7Bdomain%7D&%5BSystem.AssignedTo%5D=Windows%20Azure%20DNSOps&%5BSystem.Description%5D=%3Cp%3EComplete%20after%20%28date%29%3A%3C%2Fp%3E%3Cp%3EComplete%20before%20%28date%29%3A%3C%2Fp%3E%3Cp%3ERequestor%3A%3C%2Fp%3E%3Cp%3ERequesting%20team%3A%3C%2Fp%3E%3Cp%3EBusiness%20justification%3A%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DChange%201%3D%3C%2Fp%3E%3Cp%3EDomain%20name%3A%20%3C%2Fp%3E%3Cp%3EAction%3A%20%5BAdd%7CModify%7CDelete%5D%3C%2Fp%3E%3Cp%3EOld%20Values%3A%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%203600%20127.0.0.1%3C%2Fp%3E%3Cp%3ENew%20Values%3A%26nbsp%3B%3C%2Fp%3E%3Cp%3E%26nbsp%3B%26nbsp%3B%20sample%20IN%20A%20300%20127.0.0.1%3C%2Fp%3E%3Cp%3E%3Cbr%3E%3C%2Fp%3E%3Cp%3E%3DInstructions%3D%3C%2Fp%3E%3Cp%3EPlease%20email%20rdnet-dns-azdns%20for%20normal%20triage%2Fexecution.%20Please%20engage%20CloudNet%5CDNS%20on%20call%20for%20sev%200-2%20breakfix%20changes%3C%2Fp%3E&%5BMicrosoft.RD.KeywordSearch%5D=ADNSServiceMgmt&%5BMicrosoft.Azure.IssueType%5D=Other&%5BSystem.AreaPath%5D=BlackForest%5CNetworking%5CDNS%5CAzDNS).

  Another example of a TFS item requesting another hosting service extension is located at [http://vstfrd:8080/Azure/BlackForest/_workItems?id=8798256&fullScreen=false&_a=edit](http://vstfrd:8080/Azure/BlackForest/_workItems?id=8798256&fullScreen=false&_a=edit).

### Mooncake	
Follow the specification located at [http://sharepoint/sites/CIS/waps/WAPO/Creating%20CName%20DNS%20Entry%20in%20Mooncake.aspx](http://sharepoint/sites/CIS/waps/WAPO/Creating%20CName%20DNS%20Entry%20in%20Mooncake.aspx).

Another example of a TFS item requesting another hosting service extension is located at [http://vstfrd:8080/Azure/Mooncake/_workitems?_a=edit&id=8798258&fullScreen=false](http://vstfrd:8080/Azure/Mooncake/_workitems?_a=edit&id=8798258&fullScreen=false).

