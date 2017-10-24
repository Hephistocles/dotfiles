/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/
'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
var vscode = require("vscode");
function isMarkdownFile(document) {
    return document.languageId === 'asciidoc'
        && document.uri.scheme !== 'asciidoc'; // prevent processing of own documents
}
exports.isMarkdownFile = isMarkdownFile;
function getMarkdownUri(uri) {
    if (uri.scheme === 'asciidoc') {
        return uri;
    }
    return uri.with({
        scheme: 'asciidoc',
        path: uri.path + '.rendered',
        query: uri.toString()
    });
}
exports.getMarkdownUri = getMarkdownUri;
var MarkdownPreviewConfig = (function () {
    function MarkdownPreviewConfig() {
        var editorConfig = vscode.workspace.getConfiguration('editor');
        //const markdownConfig = vscode.workspace.getConfiguration('asciidoc');
        this.scrollBeyondLastLine = editorConfig.get('scrollBeyondLastLine', false);
        this.wordWrap = editorConfig.get('wordWrap', 'off') !== 'off';
    }
    MarkdownPreviewConfig.getCurrentConfig = function () {
        return new MarkdownPreviewConfig();
    };
    MarkdownPreviewConfig.prototype.isEqualTo = function (otherConfig) {
        for (var key in this) {
            if (this.hasOwnProperty(key) && key !== 'styles') {
                if (this[key] !== otherConfig[key]) {
                    return false;
                }
            }
        }
        // Check styles
        if (this.styles.length !== otherConfig.styles.length) {
            return false;
        }
        for (var i = 0; i < this.styles.length; ++i) {
            if (this.styles[i] !== otherConfig.styles[i]) {
                return false;
            }
        }
        return true;
    };
    return MarkdownPreviewConfig;
}());
var MDDocumentContentProvider = (function () {
    function MDDocumentContentProvider(engine, logger) {
        this.engine = engine;
        this.logger = logger;
        this._onDidChange = new vscode.EventEmitter();
        this._waiting = false;
        this.extraStyles = [];
        this.extraScripts = [];
        this.config = MarkdownPreviewConfig.getCurrentConfig();
    }
    MDDocumentContentProvider.prototype.addScript = function (resource) {
        this.extraScripts.push(resource);
    };
    MDDocumentContentProvider.prototype.addStyle = function (resource) {
        this.extraStyles.push(resource);
    };
    MDDocumentContentProvider.prototype.provideTextDocumentContent = function (uri) {
        var _this = this;
        var sourceUri = vscode.Uri.parse(uri.query);
        var initialLine = undefined;
        var editor = vscode.window.activeTextEditor;
        if (editor && editor.document.uri.fsPath === sourceUri.fsPath) {
            initialLine = editor.selection.active.line;
        }
        return vscode.workspace.openTextDocument(sourceUri).then(function (document) {
            _this.config = MarkdownPreviewConfig.getCurrentConfig();
            var initialData = {
                previewUri: uri.toString(),
                source: sourceUri.toString(),
                line: initialLine,
            };
            _this.logger.log('provideTextDocumentContent', initialData);
            var body = _this.engine.render(sourceUri, _this.config.previewFrontMatter === 'hide', document.getText());
            return "<!DOCTYPE html>\n\t\t\t\t<html>\n\t\t\t\t<head>\n\t\t\t\t\t<meta http-equiv=\"Content-type\" content=\"text/html;charset=UTF-8\">\n\t\t\t\t\t<base href=\"" + document.uri.toString() + "\">\n\t\t\t\t</head>\n\t\t\t\t<body class=\"vscode-body " + (_this.config.scrollBeyondLastLine ? 'scrollBeyondLastLine' : '') + " " + (_this.config.wordWrap ? 'wordWrap' : '') + " " + (_this.config.markEditorSelection ? 'showEditorSelection' : '') + "\">\n\t\t\t\t\t" + body + "\n\t\t\t\t\t<div class=\"code-line\" data-line=\"" + document.lineCount + "\"></div>\n\t\t\t\t</body>\n\t\t\t\t</html>";
        });
    };
    MDDocumentContentProvider.prototype.updateConfiguration = function () {
        var _this = this;
        var newConfig = MarkdownPreviewConfig.getCurrentConfig();
        if (!this.config.isEqualTo(newConfig)) {
            this.config = newConfig;
            // update all generated md documents
            vscode.workspace.textDocuments.forEach(function (document) {
                if (document.uri.scheme === 'asciidoc') {
                    _this.update(document.uri);
                }
            });
        }
    };
    Object.defineProperty(MDDocumentContentProvider.prototype, "onDidChange", {
        get: function () {
            return this._onDidChange.event;
        },
        enumerable: true,
        configurable: true
    });
    MDDocumentContentProvider.prototype.update = function (uri) {
        var _this = this;
        if (!this._waiting) {
            this._waiting = true;
            setTimeout(function () {
                _this._waiting = false;
                _this._onDidChange.fire(uri);
            }, 300);
        }
    };
    return MDDocumentContentProvider;
}());
exports.MDDocumentContentProvider = MDDocumentContentProvider;
//# sourceMappingURL=previewContentProvider.js.map