classdef switch_dc_GenCodeCov_Test < matlabtest.coder.TestCase

    % Copyright 2023 The MathWorks, Inc.

    properties
        BuildResultsTc1;
        BuildResultsTc2;
        BuildResultsTc3;
        BuildResultsTc4;
        BuildResultsTc5;
        BuildResultsTc6;
        BuildResultsTc7;
        BuildResultsTc8;
    end

    properties(ClassSetupParameter)
        BuildMode = {'lib'};
        VerificationMode = {'SIL', 'PIL'};
        TargetLang = {'C', 'C++'}
    end

    methods (TestClassSetup)
        function generateBuildResults(testCase, TargetLang, VerificationMode, BuildMode)
            cfg = coder.config(BuildMode);
            cfg.TargetLang = TargetLang;
            cfg.VerificationMode = VerificationMode;

            testCase.BuildResultsTc1 = testCase.build('srcFile_switch_dc1.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc2 = testCase.build('srcFile_switch_dc2.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc3 = testCase.build('srcFile_switch_dc3.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc4 = testCase.build('srcFile_switch_dc4.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc5 = testCase.build('srcFile_switch_dc5.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc6 = testCase.build('srcFile_switch_dc6.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc7 = testCase.build('srcFile_switch_dc7.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc8 = testCase.build('srcFile_switch_dc8.m',Inputs={coder.typeof(0)}, Configuration=cfg);
        end
    end

    properties (TestParameter)
        Input = {{-1}, {0}, {1}, {2}};
        InputTc2 = {{0}, {1}, {2}};
        InputTc3 = {{-1}, {0}, {1}};
    end


    methods(Test)
        function tc1(testCase, Input)
            testCase.execute(testCase.BuildResultsTc1, Inputs=Input);
        end

        function tc2(testCase, InputTc2)
            testCase.execute(testCase.BuildResultsTc2, Inputs=InputTc2);
        end

        function tc3(testCase, InputTc3)
            testCase.execute(testCase.BuildResultsTc3, Inputs=InputTc3);
        end

        function tc4(testCase, Input)
            testCase.execute(testCase.BuildResultsTc4, Inputs=Input);
        end

        function tc5(testCase, Input)
            testCase.execute(testCase.BuildResultsTc5, Inputs=Input);
        end

        function tc6(testCase,  Input)
            testCase.execute(testCase.BuildResultsTc6, Inputs=Input);
        end

        function tc7(testCase)
            for idx = 1:65
                testCase.execute(testCase.BuildResultsTc7, Inputs={idx});
            end
        end

        function tc8(testCase)
            for idx = 1:65
                if idx == 32
                    continue;
                end
                testCase.execute(testCase.BuildResultsTc8, Inputs={idx});
            end
        end
    end
end