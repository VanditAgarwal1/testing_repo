function out = srcFile_while_dc1(count) %#codegen
% Verify decision coverage (DC) for a "while" expression in a MATLAB
% Function

%   Copyright 2022-2023 The MathWorks, Inc.

% While expression that is fully covered
while (count<5)
    count = count+1;
end
out = count;