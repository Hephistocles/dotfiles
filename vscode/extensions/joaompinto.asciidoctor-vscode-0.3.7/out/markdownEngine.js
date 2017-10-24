/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/
'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
var FrontMatterRegex = /^---\s*[^]*?(-{3}|\.{3})\s*/;
var MarkdownEngine = (function () {
    function MarkdownEngine() {
        this.plugins = [];
    }
    MarkdownEngine.prototype.addPlugin = function (factory) {
        if (this.md) {
            this.usePlugin(factory);
        }
        else {
            this.plugins.push(factory);
        }
    };
    MarkdownEngine.prototype.usePlugin = function (factory) {
        try {
            this.md = factory(this.md);
        }
        catch (e) {
            // noop
        }
    };
    Object.defineProperty(MarkdownEngine.prototype, "engine", {
        get: function () {
            return null;
        },
        enumerable: true,
        configurable: true
    });
    MarkdownEngine.prototype.stripFrontmatter = function (text) {
        var offset = 0;
        var frontMatterMatch = FrontMatterRegex.exec(text);
        if (frontMatterMatch) {
            var frontMatter = frontMatterMatch[0];
            offset = frontMatter.split(/\r\n|\n|\r/g).length - 1;
            text = text.substr(frontMatter.length);
        }
        return { text: text, offset: offset };
    };
    MarkdownEngine.prototype.render = function (document, stripFrontmatter, text) {
        var offset = 0;
        if (stripFrontmatter) {
            var markdownContent = this.stripFrontmatter(text);
            offset = markdownContent.offset;
            text = markdownContent.text;
        }
        this.currentDocument = document;
        this.firstLine = offset;
        return (text);
        //return this.engine.render(text);
    };
    return MarkdownEngine;
}());
exports.MarkdownEngine = MarkdownEngine;
//# sourceMappingURL=markdownEngine.js.map