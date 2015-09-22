%union{
	val int
}

%s parn
%s escapequotes
%s escapeapostrophe
%s istringquotes
%s istringapostrophe
%s iselector
%s mediaquery
%s import

t_css_number -?(\d*\.\d+|\d+)(s|%|in|ex|[ecm]m|p[txc]|deg|g?rad|ms?|k?hz|dpi|dpcm|dppx)?
t_iselector_css_class [_a-z0-9\-]+
t_mediaquery_t_bopen \{
t_css_string "[^"@]*"|\\'[^\\'@]*\\'
t_css_important !\s*important
t_istringquotes_css_string [^"@]+
t_css_color \#[0-9]([0-9a-f]{5}|[0-9a-f]{2})
t_istringquotes_t_isclose "
t_t_isopen "|\\'
t_css_comment (/\*(.|\n|\r)*?\*/)
t_escapeapostrophe_less_variable @\{[^@\'\}]+\}
t_t_ws [ \t\f\v]+
t_mediaquery_t_only only
t_mediaquery_t_popen \(
t_mediaquery_t_semicolon ;
t_iselector_t_eclose "|\\'
t_t_colon :
t_less_comment //.*
t_istringapostrophe_t_isclose \'
t_parn_t_pclose \)
t_istringquotes_less_variable @\{[^@"\}]+\}
t_import_css_media_type all|aural|braille|handheld|print|projection|screen|tty|tv|embossed|speech
t_mediaquery_t_and and
t_parn_css_uri data:[^\)]+|(([a-z]+://)?((/?[\.a-z:]+[\w\.:]*[\/][\/]?)+|([a-z][\w\.\-]+(\.[a-z0-9]+))(\#[a-z]+)?))+
t_iselector_t_colon :
t_import_t_semicolon ;
t_t_pclose \)
t_iselector_t_ws [ \t\f\v]+
t_t_eopen ~"|~\\'
t_t_bclose \}
t_iselector_t_bopen \{
t_istringapostrophe_less_variable @\{[^@\'\}]+\}
t_parn_css_ident (([_a-z]|[\x80-\xff]|\\[0-9a-f]{1,6}|\\[^\r\n\s0-9a-f])([_a-z0-9\-]|[\x80-\xff]|\\[0-9a-f]{1,6}|\\[^\r\n\s0-9a-f])*)
t_istringapostrophe_css_string [^\'@]+
t_mediaquery_css_media_type all|aural|braille|handheld|print|projection|screen|tty|tv|embossed|speech
t_mediaquery_css_media_feature width|min-width|max-width|height|min-height|max-height|device-width|min-device-width|max-device-width|device-height|min-device-height|max-device-height|orientation|aspect-ratio|min-aspect-ratio|max-aspect-ratio|device-aspect-ratio|min-device-aspect-ratio|max-device-aspect-ratio|color|min-color|max-color|color-index|min-color-index|max-color-index|monochrome|min-monochrome|max-monochrome|resolution|min-resolution|max-resolution|scan|grid|-webkit-min-device-pixel-ratio|min--moz-device-pixel-ratio|-o-min-device-pixel-ratio|min-device-pixel-ratio
t_newline [\n\r]+
t_escapequotes_t_eclose "
t_less_open_format %\(
t_css_ms_filter (?:progid:|DX\.)[^;\(]*
t_css_ident ([\-\.\#]?([_a-z]|[\x80-\xff]|\\[0-9a-f]{1,6}|\\[^\s\r\n0-9a-f])([_a-z0-9\-]|[\x80-\xff]|\\[0-9a-f]{1,6}|\\[^\s\r\n0-9a-f])*)|\.
t_t_comma ,
t_t_tilde ~
t_iselector_css_filter \[[^\]]*\]|(not|lang|nth-[a-z\-]+)\(.+\)|and[ \t]\([^><\{]+\)
t_t_popen \(
t_t_semicolon ;
t_escapequotes_less_variable @\{[^@"\}]+\}
t_iselector_less_variable @\{[^@\}]+\}
t_t_bopen \{
t_less_variable @@?[\w-]+|@\{[^@\}]+\}
t_css_filter \[[^\]]*\]|(not|lang|nth-[a-z\-]+)\(.+\)|and[ \t]\([^><\{]+\)
t_mediaquery_t_not not
t_escapeapostrophe_t_eclose \'
