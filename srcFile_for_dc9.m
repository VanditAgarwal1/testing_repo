function out = srcFile_for_dc9(in1, in2, in3, in4, in5, in6, in7, in8, in9, in10) %#codegen
% 10 nested loops (full coverage)

%   Copyright 2022-2023 The MathWorks, Inc.

out = 0;

for i=1:in1
    for j=1:in2
        for k=1:in3
            for l=1:in4
                for m=1:in5
                    for n=1:in6
                        for o=1:in7
                            for p=1:in8
                                for q=1:in9
                                    for r=1:in10
                                        out = 7;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
