from lesscpy.lessc import lexer
import re
import StringIO

lt = StringIO.StringIO()
statemap = {
'parn' : 'StateParn',
'escapequotes' : 'StateEscapeQuotes',
'escapeapostrophe' : 'StateEscapeApostrophe',
'istringquotes' : 'StateStringQuotes',
'istringapostrophe' : 'StateStringApostrophe',
'iselector' : 'StateSelector',
'mediaquery' : 'StateMediaQuery',
'import' : 'StateImport'
}
tokenmap = {}
states = []
statere = 't_(%s)_' % '|'.join(statemap.keys())
for token in lexer.LessLexer.tokens:    
    ntoken = "Token%s" % re.sub(r't?(_|^)(\w)', lambda x: x.group(2).upper(), token).replace('FonFace', 'FontFace')
    tokenmap[token] = ntoken
tokenrepre = '(t_)?(%s)' % str('|'.join(tokenmap.keys()))
#for token in lexer.LessLexer.literals:     
for n, f in lexer.LessLexer.__dict__.items():
    if n.startswith('t_'):
        if hasattr(f, 'regex'):
            tokenre = f.regex
        else:
            tokenre = repr(f.__doc__)[1:-1].replace('\\\\', '\\') 
        name = re.sub(statere, lambda x: '[%s]' % statemap[x.group(1)], n)
        name = re.sub(tokenrepre, lambda x: '[%s]' % (x.groups() and tokenmap[x.group(2)] or x.group(0)), name)


lt = open('walkless.go', 'w')
lt.write("""// Copyright 2012 The Gorilla Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package scanner

import (
	"fmt"
	"regexp"
	"strings"
	"unicode"
	"unicode/utf8"
)
// tokenType identifies the type of lexical tokens.
type stateType int

// tokenType identifies the type of lexical tokens.
type tokenType int

// String returns a string representation of the token type.
func (t tokenType) String() string {
	return tokenNames[t]
}

// Token represents a token and the corresponding string.
type Token struct {
	Type   tokenType
	Value  string
	Line   int
	Column int
}

const (
    %s stateType = iota
    %s
)

const (
    %s tokenType = iota
    %s
)
""" % (statemap.values()[0], '\n    '.join(statemap.values()[1:]), tokenmap.values()[0], '\n    '.join(tokenmap.values()[1:])))
lt.close()