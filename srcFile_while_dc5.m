function out = srcFile_while_dc5(EarlyBr) %#codegen
% early break within 'if' (partial coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;
while EarlyBr >=3
    out = 5;
    EarlyBr = EarlyBr +1;
    if ( EarlyBr == 5)
        out = 6;
        break;
    end
end
