
<a name="pinning-blades"></a>
## Pinning blades

By default, all blades and parts are 'pinnable'.  Pinning a blade creates a part on the currently active dashboard.

Every blade in the Portal has a default representation. The default part for a blade uses a button part as described in [top-legacy-parts.md](top-legacy-parts.md).  The title, subtitle, and icon provided in the blade `ViewModel` provide the data needed to create the default view.

<a name="pinning-blades-creating-a-custom-pinned-part"></a>
### Creating a custom pinned part

While the default pinned part is often sufficient, there are a few places where an extension can use a custom part representation.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. 

Developers can specify custom pinned parts in the file named `<dirParent>\Extension\Client\<extensionName>.pdl`, 

where

 `<extensionName>,` without the angle brackets, is  the unique name of the extension. An example of the .pdl file is as follows.

```xml
<!--
	Create a part in the <definition> element, making it available
	in the catalog.
-->
<Part Name="SDKPartType"
      ViewModel="SDKPartViewModel"
      PartKind="Button">
  <BladeAction Blade="SDKBlade"/>
</Part>

<Blade Name="SDKBlade"
  	   ViewModel="SDKBladeViewModel">
  <!--
  	The pinned part tag simply refers to a part already in the catalog.
  -->
  <PinnedPart PartType="SDKPartType" />
  ...
</Blade>
```

In the previous code, the part in the catalog does not require inputs.  If the part does require an input, the inputs must match the properties that are sent  into the blade `ViewModel`. For more  information about building pinnable parts, see [portalfx-parts-pinning.md](portalfx-parts-pinning.md).

<a name="pinning-blades-preventing-pinning"></a>
### Preventing pinning

Users typically expect blades to be pinnable.  However, there are some cases where a blade should not be pinned.  Those generally include create flows, editable forms, and steps in a wizard. To prevent a blade from being pinned, set `Pinnable="False"` in the blade definition, as in the file located at `<dirParent>\Extension\Client\V1\Security\Security.pdl`  and in the following code.

```xml
<Blade Name="SecuritySampleBlade"
       Pinnable="False">
  ...
```

**NOTE**:  Only use `Pinnable="False"` in places where the pinned blade truly adds no value.
