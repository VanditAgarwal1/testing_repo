classdef printColorGenCodeCovTest < matlabtest.coder.TestCase

    % Copyright 2023 The MathWorks, Inc.

    properties(ClassSetupParameter)
        BuildMode = {'lib'};
        VerificationMode = {'SIL', 'PIL'};
        TargetLang = {'C', 'C++'}
    end

    properties
         Config;
     end

    methods(TestClassSetup)
        function setConfig(testCase, TargetLang, VerificationMode, BuildMode)
            cfg = coder.config(BuildMode);
            cfg.TargetLang = TargetLang;
            cfg.VerificationMode = VerificationMode;
            testCase.Config = cfg;
         end
     end

    properties (TestParameter)
        Input = {{1,1}, {0,1}, {1,0}, {0,0}};
    end

    methods(Test)
        function basicTest(testCase, Input)
            buildResults = testCase.build('printColor.m', Inputs=Input, Configuration=testCase.Config);
            testCase.execute(buildResults);
        end
    end
end
