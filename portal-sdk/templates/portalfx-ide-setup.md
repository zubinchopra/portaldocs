# Settup up the development environment

## Pre-requisite

1. Azure portal SDK is supported on the Microsoft Windows 8, Windows Server 2012 R2, and Windows 10

* :bulb: **Productivity Tip**

* Install Chrome http://google.com/dir so that you can levrage the debugger tools while developing your extension.

## IDE Installation

### **Visual Studio**

* Install Visual Studio
    Microsoft employees can install Visual Studio from [Network Share]( \\products\public\PRODUCTS\Developers\Visual Studio 2015\Enterprise 2015.3)

* Install [Node tools](https://github.com/Microsoft/nodejstools#readme)

* Install [Typescript 2.3.0](https://marketplace.visualstudio.com/items?itemName=TypeScriptTeam.TypeScript203forVisualStudio2015)

* **Productivity Tip**

* Set-up Compile on Save for typescript files

Make sure you have typescript 2.0.3 installed on your machine. You can verify the tpescript version by executing following command:

```bash
$>tsc -version
```

Verify that when you save a typescript file you can can see the following text in the bottom left hand corner of your visual studio

![CompileOnSaveVisualStudio][../media/portalfx-ide-setup/ide-setup.png]

