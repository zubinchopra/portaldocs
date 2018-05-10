
<a name="localization-and-globalization"></a>
# Localization and Globalization

<a name="localization-and-globalization-overview"></a>
## Overview

Language and locale reflect the local conventions and language for a particular geographical region. For example, a specific language might be customary spoken in more than one country or region, or a region might have more than one official language. Some locale-dependent categories include the formatting of dates and the display format for monetary values.

The Azure Portal is localized in 18 languages. All extensions are required to support all 18 mandatory languages from the language code list.

| Language 				| Culture Code |
| -------- 				| ------------ |
| English	 			| en           |
| German   				| de           |
| Spanish  				| es           |
| French   				| fr           |
| Italian  				| it           |
| Japanese 				| ja           |
| Korean   				| ko           |
| Portuguese (Brazil) 	| pt-BR        |
| Russian 				| ru           |
| Chinese (Simplified) 	| zh-Hans      |
| Chinese (Traditional) | zh-Hant      |
| Czech                 | cs           |
| Dutch                 | nl           |
| Hungarian             | hu           |
| Portuguese (Portugal) | pt-PT        |
| Polish                | pl           |
| Swedish               | sv           |
| Turkish               | tr           |

For more information about Locales and Code Pages, see [https://msdn.microsoft.com/en-us/library/8w60z792.aspx](https://msdn.microsoft.com/en-us/library/8w60z792.aspx).

<a name="localization-and-globalization-overview-language-detection"></a>
### Language detection

Language detection in the Azure Portal works similarly to how most computers systems detect language. When the user makes a request to the Portal, the language and locale of the user's computer are specified in the request. The Portal performs all language detection by validating the language of the user computer against the list of 18 supported languages. 

If the language is supported by the Portal, then it is accepted and set as the user language. When the language of the user's computer is not supported by the Portal, then the Portal uses a fallback algorithm to specify the best matching language that the Portal supports. This heuristic is open to modifications if overrides are needed. 

The language that the Portal detects, or the best-match language, is sent to an extension when the extension is loaded. The display language and format culture parameters are saved to User Settings.

<a name="localization-and-globalization-overview-localization-for-an-extension"></a>
### Localization for an extension

Portal Azure localization and globalization use **.NET** localization as a foundation. Please ensure that your build is properly set up for .NET localization, as specified in [https://msdn.microsoft.com/en-us/library/h6270d0z(v=vs.110).aspx](https://msdn.microsoft.com/en-us/library/h6270d0z(v=vs.110).aspx) and [https://msdn.microsoft.com/en-us/library/c6zyy3s9%28v=vs.140%29.aspx](https://msdn.microsoft.com/en-us/library/c6zyy3s9%28v=vs.140%29.aspx).  Using these guidelines will assist in the process of exposing an extension to multiple languages and cultures.

For more information about localizing Azure extensions, see ["https://microsoft.sharepoint.com/teams/WAG/EngSys/Implement/OneBranch/Localization.aspx?a=1]("https://microsoft.sharepoint.com/teams/WAG/EngSys/Implement/OneBranch/Localization.aspx?a=1).

<a name="localization-and-globalization-overview-primary-localization-parameters"></a>
### Primary localization parameters

The following parameters are used in the language detection process.

**Display Language**: The locale string that specifies the language in which to display text in the UI. 

**Format Culture**: The locale string that is used for formatting. 

**Raw Locale** :  A string that specifies the user computer's display language and format culture.  It can be a single locale, or two locales delimited by a period.  If there is only one locale, the `Format Culture` string is identical to the `Display Language` string.  If two locales are specified, then the first one is the `Display Language`, and the second one is the `Format Culture`. Some examples are: "en-us", "fr", "en-us.fr-fr".

**Effective Locale**: A string that is used within a window or iFrame context to encode information about the display language and the format culture.  The value is encoded as two locale strings delimited by a period. The first locale string is the `Display Language` parameter, and the second one is the `Format Culture` parameter. The `Display Language` parameter  is one of the languages that is supported by the application. 
	

	The list of supported locales is specified in the extension as  *ApplicationContext.SupportedLocales*.  This is exposed internally as* fx.environment.effectiveLocale*.  This is exposed publicly through the module **"MsPortalFx/Globalization"** as  **displayLanguage** and  **formatCulture**.

<a name="localization-and-globalization-overview-setting-the-display-language-and-format-culture"></a>
### Setting the Display Language and Format Culture

The query string parameter 'l' is used to set the raw locale of the page. If the query string is not present, the `AcceptLanguage` header of the request is used as the raw locale. When the raw locale is specified in the request, the Framework maps it to the **effective locale** parameter, which is then used to set the thread culture of the server application. It is also sent to the client script context by using `fx.environment.effectiveLocale`. 

The `x-ms-effective-locale` header is set only by **AJAX** requests to specify the effective locale of the request. The `AcceptLanguage` header is ignored for **AJAX** requests.

It is good practice to allow the query string parameter to be set when the user is using the extension, instead of persisting a cookie that contains it. This is in alignment with detection of the raw locale and the user settings.

<a name="localization-and-globalization-overview-language-and-locale-parameters"></a>
### Language and locale parameters

The display language and format culture parameters that are saved to User Settings can be accessed with the following TypeScript code.

```ts

import Globalization = require("MsPortalFx/Globalization");
var displayLanguage = Globalization.displayLanguage;
var formatCulture = Globalization.formatCulture;

```


<a name="localization-and-globalization-overview-language-and-locale-parameters-localizing-strings"></a>
#### Localizing strings

There is an Azure sample that demonstrates building a localizable extension which is localizable.

All strings are placed inside of a standard [.NET RESX file](http://msdn.microsoft.com/en-us/library/ekyft91f.aspx), which can be found at `ClientResources.resx`. This file contains all localizable strings in the extension. You can also add multiple resx files if desired. In the csproj file, the resx is configured with a few additional properties:

```xml
<EmbeddedResource Include="Client\ClientResources.resx">
  <Generator>PublicResXFileCodeGenerator</Generator>
  <LastGenOutput>ClientResources.Designer.cs</LastGenOutput>
  <BundleId>SamplesExtension</BundleId>
  <SubType>Designer</SubType>
</EmbeddedResource>
```

`Microsoft.PortalDefinition.targets` includes the components required to generate TypeScript classes which contain typed contents of the resx file. After building the samples extension, you will find the generated TypeScript definitions for your strings in `\Client\ClientResources.d.ts`. You should not edit this file, as it is auto-generated by the build.

<a name="localization-and-globalization-overview-language-and-locale-parameters-using-localized-strings"></a>
#### Using localized strings

To refer to the string in TypeScript, the module for the resource must first be imported.  This allows for static typing to ensure the requested string exists at compile time:

```ts

import ClientResources = require("ClientResources");

...

this.subtitle(ClientResources.hubsLensTitle);
```

There are many cases where you will refer to a string directly from PDL. The compiler needs to understand which module contains the string, as well as the resource key:

```xml
<Lens Name="PartsLens"
      Title="{Resource partsLensTitle, Module=ClientResources}">
```


<a name="localization-and-globalization-overview-language-and-locale-parameters-formatting-strings-according-to-locale"></a>
#### Formatting strings according to locale

The Azure Portal Globalization API Formatters enable an extension to easily format numbers, currencies, and dates for different cultures.

This is exposed publicly by using the module `MsPortalFx/Globalization`.

```ts

import Globalization = require("MsPortalFx/Globalization");
var displayLanguage = Globalization.displayLanguage;
var formatCulture = Globalization.formatCulture;

```

<a name="localization-and-globalization-overview-number-formatter"></a>
### Number formatter
**Globalization.NumberFormat.create([options])**

```ts

import Globalization = require("MsPortalFx/Globalization");
var number = 123456.789;

// User locale is 'de-DE'
// German uses comma as decimal separator and period for thousands
console.log(Globalization.NumberFormat.create().format(number));
// → 123.456,789

```

<a name="localization-and-globalization-overview-date-formatter"></a>
### Date formatter
**Globalization.DateTimeFormat.create([options])**

```ts

import Globalization = require("MsPortalFx/Globalization");
var date = new Date(Date.UTC(2012, 11, 20, 3, 0, 0));

// British English uses day-month-year order
// User locale is 'en-GB'
console.log(Globalization.DateTimeFormat.create().format(date));
// → "20/12/2012"

```

<a name="localization-and-globalization-overview-date-formatter-testing-localization"></a>
#### Testing localization

The framework supports simple pseudo-localization of client side strings. This can be used to verify that your strings are coming from .resx files, but it doesn't verify that your localization process is setup correctly.

This can be enabled by adding the following query string parameter:

```
http://localhost:12000?l=qps-ploc
```

You can force the portal to run in a specific language. This can be used to verify that the end-to-end localization process is setup correctly for a given language. Note: you may have to clear user settings for the language to switch successfully.
```
http://localhost:12000?l=en-us
```

It may be helpful at development time to use pseudo-localization to ensure that new features are properly localized.

<a name="localization-and-globalization-overview-date-formatter-marketplace"></a>
#### Marketplace

Packages submitted to the Azure Marketplace must be localized as well.  For more information, read the [localization in the gallery](../../gallery-sdk/generated/index-gallery.md#gallery-item-specificiations-localization).


  [Gallery item specifications](/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations).

<a name="localization-and-globalization-overview-important-references"></a>
### Important references


<a href="https://microsoft.sharepoint.com/teams/WAG/EngSys/Implement/OneBranch/Localization.aspx?a=1">Azure Engineering - Localization in Corext based on Mlp and LBA</a>

<a name="localization-and-globalization-globalization"></a>
## Globalization

<a name="localization-and-globalization-globalization-implementation-details"></a>
### Implementation Details

This is exposed publicly through the module "MsPortalFx/Globalization"

```ts

import Globalization = require("MsPortalFx/Globalization");
var displayLanguage = Globalization.displayLanguage;
var formatCulture = Globalization.formatCulture;

```

The Globalization API is a wrapper for the native [Javascript library Intl](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl "Javascript library Intl").

<a name="localization-and-globalization-globalization-number-formatter"></a>
### Number Formatter
**Globalization.NumberFormat.create([options])**

<a name="localization-and-globalization-globalization-number-formatter-options"></a>
#### Options
Optional. An object with some or all of the following properties:

**style**

- The formatting style to use. Possible values are "decimal" for plain number formatting, "currency" for currency formatting, and "percent" for percent formatting; the default is "decimal".

**currency**

- The currency to use in currency formatting. Possible values are the ISO 4217 currency codes, such as "USD" for the US dollar, "EUR" for the euro, or "CNY" for the Chinese RMB — see the Current currency & funds code list. There is no default value; if the style is "currency", the currency property must be provided.

**currencyDisplay**

- How to display the currency in currency formatting. Possible values are "symbol" to use a localized currency symbol such as €, "code" to use the ISO currency code, "name" to use a localized currency name such as "dollar"; the default is "symbol".

**useGrouping**

- Whether to use grouping separators, such as thousands separators or thousand/lakh/crore separators. Possible values are true and false; the default is true.

> [WACOM.NOTE] The following properties fall into two groups: minimumIntegerDigits, minimumFractionDigits, and maximumFractionDigits in one group, minimumSignificantDigits and maximumSignificantDigits in the other. If at least one property from the second group is defined, then the first group is ignored.

**minimumIntegerDigits**

- The minimum number of integer digits to use. Possible values are from 1 to 21; the default is 1.

**minimumFractionDigits**

- The minimum number of fraction digits to use. Possible values are from 0 to 20; the default for plain number and percent formatting is 0; the default for currency formatting is the number of minor unit digits provided by the ISO 4217 currency code list (2 if the list doesn't provide that information).

**maximumFractionDigits**

> [WACOM.NOTE] The maximum number of fraction digits to use. Possible values are from 0 to 20; the default for plain number formatting is the larger of minimumFractionDigits and 3; the default for currency formatting is the larger of minimumFractionDigits and the number of minor unit digits provided by the ISO 4217 currency code list (2 if the list doesn't provide that information); the default for percent formatting is the larger of minimumFractionDigits and 0.

**minimumSignificantDigits**


- The minimum number of significant digits to use. Possible values are from 1 to 21; the default is 1.

**maximumSignificantDigits**

- The maximum number of significant digits to use. Possible values are from 1 to 21; the default is minimumSignificantDigits.

<a name="localization-and-globalization-globalization-number-formatter-examples"></a>
#### Examples

**Example: Basic usage**

```ts

import Globalization = require("MsPortalFx/Globalization");
var number = 123456.789;

// User locale is 'de-DE'
// German uses comma as decimal separator and period for thousands
console.log(Globalization.NumberFormat.create().format(number));
// → 123.456,789
// User locale is 'ar-EG'// Arabic in most Arabic speaking countries uses real Arabic digits
console.log(Globalization.NumberFormat.create().format(number));
// → ١٢٣٤٥٦٫٧٨٩
// User locale is 'en-IN'// India uses thousands/lakh/crore separators
console.log(Globalization.NumberFormat.create().format(number));
// → 1,23,456.789
// User locale is 'zh-Hans-CN-u-nu-hanidec' with Chinese decimal numbering system// the nu extension key requests a numbering system, e.g. Chinese decimal
console.log(Globalization.NumberFormat.create().format(number));
// → 一二三,四五六.七八九

````

**Example: Using options**

```ts

import Globalization = require("MsPortalFx/Globalization");
var number = 123456.789;

// request a currency format// User locale is 'de-DE'
console.log(Globalization.NumberFormat.create({ style: 'currency', currency: 'EUR' }).format(number));
// → 123.456,79 €
// the Japanese yen doesn't use a minor unit// User locale is 'ja-JP'
console.log(Globalization.NumberFormat.create({ style: 'currency', currency: 'JPY' }).format(number));
// → ￥123,457
// limit to three significant digits// User locale is 'en-IN'
console.log(Globalization.NumberFormat.create({ maximumSignificantDigits: 3 }).format(number));
// → 1,23,000

```


<a name="localization-and-globalization-globalization-number-formatter-date-formatter"></a>
#### Date Formatter

**Globalization.DateTimeFormat.create([options])**

<a name="localization-and-globalization-globalization-number-formatter-options"></a>
#### Options

Optional. An object with some or all of the following properties:

**localeMatcher**

- The locale matching algorithm to use. Possible values are "lookup" and "best fit"; the default is "best fit". For information about this option, see the Globalization page.

**timeZone**

- The time zone to use. The only value implementations must recognize is "UTC"; the default is the runtime's default time zone. Implementations may also revcognize the time zone names of the IANA time zone database, such as "Asia/Shanghai", "Asia/Kolkata", "America/New_York".

**hour12**

- Whether to use 12-hour time (as opposed to 24-hour time). Possible values are true and false; the default is locale dependent.

**formatMatcher**

- The format matching algorithm to use. Possible values are "basic" and "best fit"; the default is "best fit". See the following paragraphs for information about the use of this property.The following properties describe the date-time components to use in formatted output, and their desired representations. Implementations are required to support at least the following subsets:
	- weekday, year, month, day, hour, minute, second
	- weekday, year, month, day
	- year, month, day
	- year, month
	- month, day
	- hour, minute, second
	-  hour, minute
- Implementations may support other subsets, and requests will be negotiated against all available subset-representation combinations to find the best match. Two algorithms are available for this negotiation and selected by the formatMatcher property: A fully specified "basic" algorithm and an implementation dependent "best fit" algorithm.

	- **weekday** - The representation of the weekday. Possible values are "narrow", "short", "long".

	- **Era** - The representation of the era. Possible values are "narrow", "short", "long".

	- **Year** - The representation of the year. Possible values are "numeric", "2-digit".

	- **Month** - The representation of the month. Possible values are "numeric", "2-digit", "narrow", "short", "long".

	- **Day** - The representation of the day. Possible values are "numeric", "2-digit".

	- **Hour** - The representation of the hour. Possible values are "numeric", "2-digit".

	- **Minute** - The representation of the minute. Possible values are "numeric", "2-digit".

	- **Second** - The representation of the second. Possible values are "numeric", "2-digit".

	- **timeZoneName** - The representation of the time zone name. Possible values are "short", "long".

> [WACOM.NOTE] The default value for each date-time component property is undefined, but if all component properties are undefined, then year, month, and day are assumed to be "numeric".

<a name="localization-and-globalization-globalization-number-formatter-examples"></a>
#### Examples
**Example: Using DateTimeFormat**


```ts

import Globalization = require("MsPortalFx/Globalization");
var date = new Date(Date.UTC(2012, 11, 20, 3, 0, 0));

// formats below assume the local time zone of the locale;
// America/Los_Angeles for the US
// US English uses month-day-year order
// User locale is 'en-US'
console.log(Globalization.DateTimeFormat.create().format(date));
// → "12/19/2012"
// British English uses day-month-year order
// User locale is 'en-GB'
console.log(Globalization.DateTimeFormat.create().format(date));
// → "20/12/2012"
// Korean uses year-month-day order
// User locale is 'ko-KR'
console.log(Globalization.DateTimeFormat.create().format(date));
// → "2012. 12. 20."
// Arabic in most Arabic speaking countries uses real Arabic digits
// User locale is 'ar-EG'
console.log(Globalization.DateTimeFormat.create().format(date));
// → "٢٠‏/١٢‏/٢٠١٢"
// for Japanese, applications may want to use the Japanese calendar,
// where 2012 was the year 24 of the Heisei era
// User locale is 'ja-JP-u-ca-japanese' using the Japanese calendar
console.log(Globalization.DateTimeFormat.create().format(date));
// → "24/12/20"

```

**Example: Using options**

```ts

import Globalization = require("MsPortalFx/Globalization");
var date = new Date(Date.UTC(2012, 11, 20, 3, 0, 0));

// request a weekday along with a long date// User locale is 'de-DE'
var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
console.log(Globalization.DateTimeFormat.create(options).format(date));
// → "Donnerstag, 20. Dezember 2012"
// an application may want to use UTC and make that visible// User locale is 'en-US'options.timeZone = 'UTC';
options.timeZoneName = 'short';
console.log(Globalization.DateTimeFormat.create(options).format(date));
// → "Thursday, December 20, 2012, GMT"
// sometimes you want to be more precise// User locale is 'en-AU'
options = {
hour: 'numeric', minute: 'numeric', second: 'numeric',
timeZoneName: 'short'
};
console.log(Globalization.DateTimeFormat.create(options).format(date));
// → "2:00:00 pm AEDT"
// sometimes even the US needs 24-hour time// User locale is 'en-US'
options = {
year: 'numeric', month: 'numeric', day: 'numeric',
hour: 'numeric', minute: 'numeric', second: 'numeric',
hour12: false
};
console.log(date.toLocaleString(options));
// → "12/19/2012, 19:00:00"

```
