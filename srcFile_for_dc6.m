function out = srcFile_for_dc6(input) %#codegen
% unexecuted statements due to continue statement
% for loop completes normally

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
for i = input:4        % full coverage
    if i > 0        % partial coverage, never false
        continue;
    end
    out = 2;        % never executed
end
