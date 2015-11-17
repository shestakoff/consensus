function str = strarray2str(strarray, str_separator)
% Concantenate sring array into one string like that 'a,b,c,d' = strarray2args({'a','b','c','d')
%
% Input
% strarray {cell array of strings}
% str_separator [string] separator of strarray elements in result string
%
% Output
% str [string]
%
% Example
% str = strarray2str({'a','b','c','d'}, ',')
% Result: str = 'a,b,c,d'

str = '';
for s = strarray(:)'
    str = strcat(str, s{:},str_separator);
end
str(end) = [];

% TODO find the standard string for that operation