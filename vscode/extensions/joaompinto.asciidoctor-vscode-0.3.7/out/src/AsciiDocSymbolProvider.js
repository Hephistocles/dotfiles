"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
function registerDocumentSymbolProvider() {
    const _atxPattern = /^(=|#){1,6}\s+.+/;
    return vscode_1.languages.registerDocumentSymbolProvider('asciidoc', {
        provideDocumentSymbols(document, token) {
            const result = [];
            const lineCount = Math.min(document.lineCount, 10000);
            for (let line = 0; line < lineCount; line++) {
                const { text } = document.lineAt(line);
                if (_atxPattern.test(text)) {
                    // atx-style, 1-6 = characters
                    result.push(new vscode_1.SymbolInformation(text, vscode_1.SymbolKind.File, '', new vscode_1.Location(document.uri, new vscode_1.Position(line, 0))));
                }
            }
            return result;
        }
    });
}
exports.default = registerDocumentSymbolProvider;
//# sourceMappingURL=AsciiDocSymbolProvider.js.map