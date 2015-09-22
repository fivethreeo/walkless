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
for state in statemap.values():  
    lt.write("%s\n" % state)
statere = 't_(%s)_' % '|'.join(statemap.keys())
for token in lexer.LessLexer.tokens:    
    ntoken = "Token%s" % re.sub(r't?(_|^)(\w)', lambda x: x.group(2).upper(), token)
    tokenmap[token] = ntoken
    lt.write("%s\n" % ntoken)
tokenmre = '(t_)?(%s)' % str('|'.join(tokenmap.keys()))
print tokenmre
for token in lexer.LessLexer.literals:       
    lt.write("%s %s\n" % ('%token', token))
for n, f in lexer.LessLexer.__dict__.items():
    if n.startswith('t_'):
        if hasattr(f, 'regex'):
            tokenre = f.regex
        else:
            tokenre = repr(f.__doc__)[1:-1].replace('\\\\', '\\') 
        name = re.sub(statere, lambda x: '[%s]' % statemap[x.group(1)], n)
        name = re.sub(tokenmre, lambda x: '[%s]' % (x.groups() and tokenmap[x.group(2)] or x.group(0)), name)
        lt.write("%s = '%s'\n" % (name, tokenre))

contents = lt.getvalue()

rlt = open('less.lt', 'w')
rlt.write(contents)

lt.close()