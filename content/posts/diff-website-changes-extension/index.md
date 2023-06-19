---
title: "Diff Website Changes - Chrome and Firefox Extension"
date: 2023-05-16T19:04:24+02:00
draft: false
resources:
- name: "featured-image"
  src: "diff-website-changes.png"

tags: ["JavaScript", "Automation"]
categories: ["Browser Extensions"]
---

## Diff Website Changes Guide

The `Diff Website Changes` extension allows users to customize the domains to monitor and elements to check for changes. Here's how users can use the extension:

[Chrome - Diff Website Changes](https://chrome.google.com/webstore/detail/diff-website-changes/bnhlfbacpohcncjlmcpcfkhplnjklcic?hl=en)

[Firefox - Diff Website Changes](https://addons.mozilla.org/de/firefox/addon/diff-website-changes/)

### How to use
First, ensure that the tab containing the desired website is active. Then, locate the extension icon in the browser toolbar and click on it. This action grants the extension the necessary permission to access and read the data of the website.

When the website is reloaded or visited again after changes have taken place, the extension automatically saves two versions: the current version and the previous version. Upon subsequent visits, the extension compares these two saved versions when you click the extension icon.

By clicking the extension button, the extension compares the two last saved versions of the website. It analyzes the content of each version and identifies any variations or modifications that have taken place.

The resulting differences, commonly referred to as a "diff," are then displayed within the actual tab where the website is loaded. The extension highlights the specific changes, allowing you to easily discern and assess the alterations made to the website.

This provides you with a convenient way to review the modifications that have occurred between the two versions of the website, enabling you to stay updated and informed about any changes on the web pages you monitor.

### Settings

#### Opening the Options Page
Users can access the options page by clicking on the extension's icon in their browser's toolbar and selecting the "Options" or "Settings" option.

#### Customizing Domains to Monitor
On the options page, there is a text area with domains to monitor labeled "URLs to check". Users can enter the domains they want to monitor, with each domain on a separate line.

#### Customizing Elements to Check
Similarly, there should be a text area labeled "Element to Check". Users can enter the element they want to check for changes.

## Development

During the development of the "Diff Website Changes" extension, my approach involved a combination of online research, utilizing code snippets, and exploring the capabilities of ChatGPT. While each of these resources played a role in reaching my goal, the process was not without its challenges and limitations.

## Use the same code for a Firefox and Chrome extension

The Chrome version uses a service worker for the background script and includes the tabs permission. In contrast, the second snippet uses an array of scripts for the background, and grants permission to access all URLs. These are specified by the [Manifest V3 Firefox](https://extensionworkshop.com/documentation/develop/manifest-v3-migration-guide/) and [Manifest V3 Chrome](https://developer.chrome.com/docs/extensions/mv3/intro/). Both specify the strict_min_version for Firefox. This is no problem as Chrome ignores these settings. These differences in the background script configuration do not allow using the same code for Firefox and Chrome extensions.


### Browser Object Compatibility

```
if (typeof browser === "undefined") {
    var browser = browser || chrome;
}

```

In Firefox, the `browser` object is available globally, and you can directly access its APIs using the `browser` keyword. However, in Chrome, the `browser` object is not available, and you need to use the `chrome` keyword instead to access Chrome's APIs.

To address this difference, the code snippet checks if the `browser` object is undefined. If it is undefined, it assigns the `chrome` object to the `browser` variable. This way, the extension code can use the `browser` object to interact with the browser's APIs, regardless of whether it is running in Firefox or Chrome.

By using this code, you can write code that is compatible with both Firefox and Chrome, allowing your extension to work seamlessly across multiple browsers without having to write separate code for each browser.


### Import (Third-Party) Libraries
Firefox Import
```
// import htmldiff library
var script = document.createElement("script");
script.src = "scripts/htmldiff.min.js";
document.head.appendChild(script);
```

Chrome Import
```
// import htmldiff library
import "./scripts/htmldiff.min.js";
```

The difference in the import syntax between Firefox and Chrome extensions is due to variations in their underlying JavaScript engines and module systems.

Firefox uses the older CommonJS module system, which is commonly found in Node.js environments. In this system, modules are loaded dynamically using script injection. To import a third-party library in Firefox, you need to create a new `<script>` element and append it to the `<head>` or `<body>` of the webpage to load the library dynamically.

On the other hand, Chrome uses the newer ECMAScript modules (ES modules) system, which is widely supported in modern browsers. ES modules use the import statement to import modules and dependencies directly in the JavaScript code.

So, the difference in the import syntax arises from the different module systems and mechanisms supported by each browser. Firefox extensions typically require dynamic script loading using the createElement and appendChild methods, while Chrome extensions can directly use the import statement to import and use libraries.

You can find the full source code [on GitHub](https://github.com/MartinRenze/diff-website-changes-extension).

## Need Help?

For questions or feature requests please fill in an issue: [Diff Website Changes Extension Support](https://github.com/MartinRenze/diff-website-changes-extension)

<img src="https://vg04.met.vgwort.de/na/8e08a6738d194c4098adf4eeab1fe56e" width="1" height="1" alt="">