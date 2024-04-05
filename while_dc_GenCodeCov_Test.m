classdef while_dc_GenCodeCov_Test < matlabtest.coder.TestCase

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

    methods(Test)
        function tc1(testCase)
            verifyExecution(testCase, 'srcFile_while_dc1.m', {3});
        end

        function tc2(testCase)
            verifyExecution(testCase, 'srcFile_while_dc2.m', {1});
        end

        function tc3(testCase)
            verifyExecution(testCase, 'srcFile_while_dc3.m', {3});
        end

        function tc4(testCase)
            verifyExecution(testCase, 'srcFile_while_dc4.m', {1});           
        end

        function tc5(testCase)
            verifyExecution(testCase, 'srcFile_while_dc5.m', {3});            
        end

        function tc6(testCase)
            verifyExecution(testCase, 'srcFile_while_dc6.m', {3});            
        end
    end
end

function verifyExecution(testCase, srcFile, input)
buildResults = testCase.build(srcFile, Inputs=input, Configuration=testCase.Config);
testCase.execute(buildResults);
end