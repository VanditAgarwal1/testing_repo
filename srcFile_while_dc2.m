function out = srcFile_while_dc2(notexecuted) %#codegen
% never executed (no coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
if notexecuted>2
    while notexecuted < 6
        notexecuted = notexecuted+1;
        out = 2;
    end
end