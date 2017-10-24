/*
Activation Trigger:
    Keybindings the the adoc.preview and adoc.previewToSide commands (wehn editorTextFocus)

On Activation:
    Create a provider for the adoc-preview uri scheme
    Register the adoc.preview and adoc.previewToSide command functions

On adoc.preview command execution:
    Call CreateHTMLWindow() targetting the active editor view column

On adoc.previewToSide execution:
    Call CreateHTMLWindow() targetting the next editor view column

*/
// https://code.visualstudio.com/Docs/extensionAPI/vscode-api
'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const AsciiDocProvider_1 = require("./AsciiDocProvider");
const AsciiDocSymbolProvider_1 = require("./AsciiDocSymbolProvider");
function activate(context) {
    const provider = new AsciiDocProvider_1.default();
    const providerRegistrations = vscode_1.Disposable.from(vscode_1.workspace.registerTextDocumentContentProvider(AsciiDocProvider_1.default.scheme, provider));
    // When the active document is changed set the provider for rebuild
    //this only occurs after an edit in a document
    vscode_1.workspace.onDidChangeTextDocument((e) => {
        if (e.document === vscode_1.window.activeTextEditor.document) {
            provider.setNeedsRebuild(true);
            //provider.update(MakePreviewUri(e.document));
        }
    });
    // This occurs whenever the selected document changes, its useful to keep the
    vscode_1.window.onDidChangeTextEditorSelection((e) => {
        if (!!e && !!e.textEditor && (e.textEditor === vscode_1.window.activeTextEditor)) {
            provider.setNeedsRebuild(true);
            //  provider.update(MakePreviewUri(e.textEditor.document));
        }
    });
    vscode_1.workspace.onDidSaveTextDocument((e) => {
        if (e === vscode_1.window.activeTextEditor.document) {
            provider.update(AsciiDocProvider_1.MakePreviewUri(e));
        }
    });
    let previewToSide = vscode_1.commands.registerCommand("adoc.previewToSide", () => {
        let displayColumn;
        switch (vscode_1.window.activeTextEditor.viewColumn) {
            case vscode_1.ViewColumn.One:
                displayColumn = vscode_1.ViewColumn.Two;
                break;
            case vscode_1.ViewColumn.Two:
            case vscode_1.ViewColumn.Three:
                displayColumn = vscode_1.ViewColumn.Three;
                break;
        }
        return AsciiDocProvider_1.CreateHTMLWindow(provider, displayColumn);
    });
    let preview = vscode_1.commands.registerCommand("adoc.preview", () => {
        return AsciiDocProvider_1.CreateHTMLWindow(provider, vscode_1.window.activeTextEditor.viewColumn);
    });
    const registration = AsciiDocSymbolProvider_1.default();
    context.subscriptions.push(previewToSide, preview, providerRegistrations, registration);
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map