classdef for_dc_GenCodeCov_Test < matlabtest.coder.TestCase
    %

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
            verifyExecution(testCase, 'srcFile_for_dc1', {1});
        end

        function tc2(testCase)
            verifyExecution(testCase, 'srcFile_for_dc2', {4});
        end

        function tc3(testCase)
            verifyExecution(testCase, 'srcFile_for_dc3', {3,4});
        end

        function tc4(testCase)
            verifyExecution(testCase, 'srcFile_for_dc4', {1});
        end

        function tc5(testCase)
            verifyExecution(testCase, 'srcFile_for_dc5', {4});
        end

        function tc6(testCase)
            verifyExecution(testCase, 'srcFile_for_dc6', {4});
        end

        function tc7(testCase)
            verifyExecution(testCase, 'srcFile_for_dc7', {0});
        end

        function tc8(testCase)
            verifyExecution(testCase, 'srcFile_for_dc8', {0});
        end

        function tc9(testCase)
            verifyExecution(testCase, 'srcFile_for_dc9', {1,2,2,2,2,3,3,3,3,4});
        end

        function tc10(testCase)
            verifyExecution(testCase, 'srcFile_for_dc10', {1,2,2,2,2,3,3,3,3,4});
        end

    end
end

function verifyExecution(testCase, srcFile, input)
buildResults = testCase.build(srcFile, Inputs=input, Configuration=testCase.Config);
testCase.execute(buildResults);
end
