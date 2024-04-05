function out = srcFile_while_dc4(AlwaysTrue) %#codegen
% always true, force break (partial coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
while AlwaysTrue
    if out > 4
        break
    end
    out = out + 1;
end
