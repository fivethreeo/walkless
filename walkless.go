// Copyright 2012 The Gorilla Authors. All rights reserved.
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
    StateImport stateType = iota
    StateStringApostrophe
    StateEscapeApostrophe
    StateSelector
    StateParn
    StateEscapeQuotes
    StateStringQuotes
    StateMediaQuery
)

const (
    TokenComma tokenType = iota
    TokenSemicolon
    TokenIsopen
    TokenBopen
    TokenCssPage
    TokenEopen
    TokenCssVendorProperty
    TokenLessAnd
    TokenCssUri
    TokenPclose
    TokenCssComment
    TokenCssIdent
    TokenCssNumber
    TokenPopen
    TokenCssDom
    TokenLessVariable
    TokenCssFontFace
    TokenCssString
    TokenCssKeyframes
    TokenAnd
    TokenLessOpenFormat
    TokenCssVendorHack
    TokenTilde
    TokenCssMsFilter
    TokenCssImport
    TokenColon
    TokenLessArguments
    TokenCssCharset
    TokenLessComment
    TokenWs
    TokenBclose
    TokenCssNamespace
    TokenCssViewport
    TokenEclose
    TokenIsclose
    TokenOnly
    TokenCssMediaFeature
    TokenCssImportant
    TokenCssId
    TokenCssClass
    TokenLessWhen
    TokenCssMedia
    TokenCssMediaType
    TokenCssProperty
    TokenCssFilter
    TokenCssColor
    TokenLessNot
    TokenNot
)
