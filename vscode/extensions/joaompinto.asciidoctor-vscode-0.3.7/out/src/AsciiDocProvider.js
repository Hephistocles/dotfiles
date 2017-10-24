"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const child_process_1 = require("child_process");
const fs = require("fs");
const path = require("path");
let fileUrl = require("file-url");
let tmp = require("tmp");
class AsciiDocProvider {
    constructor() {
        this._onDidChange = new vscode_1.EventEmitter();
        this.resultText = "";
        this.lastPreviewHTML = null;
        this.lastPreviewTime = new Date();
        this.needsRebuild = true;
        this.editorDocument = null;
        this.refreshInterval = 1000;
    }
    resolveDocument(uri) {
        const matches = vscode_1.workspace.textDocuments.filter(d => {
            return MakePreviewUri(d).toString() == uri.toString();
        });
        if (matches.length > 0) {
            return matches[0];
        }
        else {
            return null;
        }
    }
    provideTextDocumentContent(uri) {
        const doc = this.resolveDocument(uri);
        return this.createAsciiDocHTML(doc);
    }
    get onDidChange() {
        return this._onDidChange.event;
    }
    update(uri) {
        this._onDidChange.fire(uri);
    }
    createAsciiDocHTML(doc) {
        let editor = vscode_1.window.activeTextEditor;
        if (!doc || !(doc.languageId === "asciidoc")) {
            return this.errorSnippet("Active editor doesn't show an AsciiDoc document - no properties to preview.");
        }
        if (this.needsRebuild) {
            this.lastPreviewHTML = this.preview(doc);
            this.needsRebuild = false;
        }
        return this.lastPreviewHTML;
    }
    errorSnippet(error) {
        return `
                <body>
                    ${error}
                </body>`;
    }
    buildPage(document) {
        return document;
    }
    createStylesheet(file) {
        let href = fileUrl(path.join(__dirname, "..", "..", "src", "static", file));
        return `<link href="${href}" rel="stylesheet" />`;
    }
    fixLinks(document, documentPath) {
        //console.log(document);
        let result = document.replace(new RegExp("((?:src|href)=[\'\"])(?!(?:http:|https:|ftp:|#))(.*?)([\'\"])", "gmi"), (subString, p1, p2, p3) => {
            return [
                p1,
                fileUrl(path.join(path.dirname(documentPath), p2)),
                p3
            ].join("");
        });
        //console.log(result)
        return result;
    }
    setNeedsRebuild(value) {
        this.needsRebuild = true;
    }
    preview(doc) {
        return new Promise((resolve, reject) => {
            let text = doc.getText();
            let documentPath = path.dirname(doc.fileName);
            let tmpobj = tmp.fileSync({ postfix: '.adoc', dir: documentPath });
            let html_generator = vscode_1.workspace.getConfiguration('AsciiDoc').get('html_generator');
            let cmd = `${html_generator} "${tmpobj.name}"`;
            fs.write(tmpobj.fd, text, 0);
            let maxBuff = parseInt(vscode_1.workspace.getConfiguration('AsciiDoc').get('buffer_size_kB'));
            child_process_1.exec(cmd, { maxBuffer: 1024 * maxBuff }, (error, stdout, stderr) => {
                tmpobj.removeCallback();
                if (error) {
                    let errorMessage = [
                        error.name,
                        error.message,
                        error.stack,
                        "",
                        stderr.toString()
                    ].join("\n");
                    console.error(errorMessage);
                    errorMessage = errorMessage.replace("\n", '<br><br>');
                    errorMessage += "<br><br>";
                    errorMessage += "<b>If the asciidoctor binary is not in your PATH, you can set the full path.<br>";
                    errorMessage += "Go to `File -> Preferences -> User settings` and adjust the AsciiDoc.html_generator config option.</b>";
                    errorMessage += "<br><br><b>Alternatively if you get a stdout maxBuffer exceeded error, Go to `File -> Preferences -> User settings and adjust the AsciiDoc.buffer_size_kB to a larger number (default is 200 kB).</b>";
                    resolve(this.errorSnippet(errorMessage));
                }
                else {
                    let result = this.fixLinks(stdout.toString(), doc.fileName);
                    resolve(this.buildPage(result));
                }
            });
        });
    }
}
AsciiDocProvider.scheme = 'adoc-preview';
exports.default = AsciiDocProvider;
function TimerCallback(timer, provider, editor, previewUri) {
    provider._onDidChange.fire(previewUri);
}
function CreateRefreshTimer(provider, editor, previewUri) {
    var timer = setInterval(() => {
        // This function gets called when the timer goes off.
        TimerCallback(timer, provider, editor, previewUri);
    }, 
    // The periodicity of the timer.
    provider.refreshInterval);
}
exports.CreateRefreshTimer = CreateRefreshTimer;
function MakePreviewUri(doc) {
    return vscode_1.Uri.parse(`adoc-preview://preview/${doc.fileName}`);
}
exports.MakePreviewUri = MakePreviewUri;
function CreateHTMLWindow(provider, displayColumn) {
    let previewTitle = `Preview: '${path.basename(vscode_1.window.activeTextEditor.document.fileName)}'`;
    let previewUri = MakePreviewUri(vscode_1.window.activeTextEditor.document);
    CreateRefreshTimer(provider, vscode_1.window.activeTextEditor, previewUri);
    return vscode_1.commands.executeCommand("vscode.previewHtml", previewUri, displayColumn).then((success) => {
    }, (reason) => {
        console.warn(reason);
        vscode_1.window.showErrorMessage(reason);
    });
}
exports.CreateHTMLWindow = CreateHTMLWindow;
//# sourceMappingURL=AsciiDocProvider.js.map