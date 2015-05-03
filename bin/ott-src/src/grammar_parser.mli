type token =
  | STRING of (string*string)
  | BLANKS of (string)
  | LINE of (string*string)
  | LINELINE of (string*string*string)
  | BLANKLINE of (string)
  | COMMENTLINE of (string)
  | INTERSTITIAL of (string)
  | EOF
  | COMMA
  | CCE
  | BAR
  | DOUBLELEFTBRACKET
  | DOUBLERIGHTBRACKET
  | DOUBLELEFTBRACE
  | DOUBLERIGHTBRACE
  | COLONCOLON
  | LTCOLONCOLON
  | UNDERSCORECOLONCOLON
  | DOTDOT
  | DOTDOTDOT
  | DOTDOTDOTDOT
  | EMBED
  | METAVAR
  | INDEXVAR
  | RULES
  | SUBRULES
  | CONTEXTRULES
  | SUBSTITUTIONS
  | FREEVARS
  | DEFNCLASS
  | DEFN
  | FUNDEFNCLASS
  | FUNDEFN
  | DEFNCOM
  | BY
  | SINGLE
  | MULTIPLE
  | HOMS
  | PARSING
  | LTEQ
  | LEFT
  | RIGHT
  | NON
  | BIND_LEFT_DELIM
  | BIND_RIGHT_DELIM
  | BIND
  | IN
  | EQ
  | HASH
  | NAMES
  | DISTINCTNAMES
  | LPAREN
  | RPAREN
  | UNION
  | EMPTY
  | COQSECTIONBEGIN
  | COQSECTIONEND
  | COQVARIABLE
  | COMP_LEFT
  | COMP_MIDDLE
  | COMP_RIGHT
  | COMP_IN

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Types.raw_item list
val drule_line_annot :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Types.raw_drule_line_annot
val unfiltered_spec_el_list :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Types.embed_spec_el list
val embed_spec_el_list :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Types.embed_spec_el list
