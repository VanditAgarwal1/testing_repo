function out = printColor(a,b) %#codegen

% Copyright 2023 The MathWorks, Inc.

% a for red
% b for Yellow
% c for Blue
if a == 1 && b == 1
    out = 'white';
else
    out = 'failed';
end

end