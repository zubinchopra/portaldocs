
<a name="removing-a-part-from-a-blade-s-default-layout"></a>
### Removing a part from a blade&#39;s default layout

Your unlocked blade's default layout should be reflective of tiles you think provide the most out of the box value to users while meeting your performance goals.  That layout may change over time, and you may decide that a part that included in a blade's default layout at one point in time should not be included going forward.  

If you find yourself in that position this is what you should do.

If the part was defined inline as a `<Part/>` or `<CustomPart>` element within a `<Blade/>` and `<Lens/>` then you have the pre-step of moving that part out of the blade and into your extension's global part catalog (Best practice is to use no-pdl parts).

Otherwise, if the  part is already defined in the global part catalog or is defined in another extension then you currently have a `<PartReference/>` tag in your blade rather than a `<Part/>` tag.

Next, you should remove your `<Part/>` or `<PartReference/>` tag and define globally within your extension a `<RedirectPart/>` tag.

At this point we need to keep in mind that our goal is to remove the part from the default layout, but we still want to continue supporting instances of the part that users have pinned to their startboards.  You may also choose to allow new users to  find the part in the tile gallery.  If your goal was to permanently discontinue a part, including removing support for pinned instances and the tile gallery then read [Discontinuing portal parts](portalfx-parts-discontinuing.md).

```xml
<RedirectPart Name="SAME EXACT PART NAME THAT IS BEING REDIRECTED FROM" 
              Blade="EXACT BLADE NAME THAT THE PART WAS DEFINED IN"
              Lens="OPTIONAL - EXACT LENS NAME THE PART WAS DEFINED IN"
              Extension="OPTIONAL - ONLY APPLICABLE IF THE PART IS DEFINED IN A DIFFERENT EXTENSION">
    <NewPart Name="NAME OF THE NEW GLOBAL PART THAT DEFINES THE PART BEHAVIOR" />
</RedirectPart>
```