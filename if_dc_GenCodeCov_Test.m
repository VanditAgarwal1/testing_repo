classdef if_dc_GenCodeCov_Test < matlabtest.coder.TestCase

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
        BuildResultsTc9;
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

            testCase.BuildResultsTc1 = testCase.build('srcFile_if_dc1.m',Inputs={coder.typeof(true)}, Configuration=cfg);
            testCase.BuildResultsTc2 = testCase.build('srcFile_if_dc2.m',Inputs={coder.typeof(true)}, Configuration=cfg);
            testCase.BuildResultsTc3 = testCase.build('srcFile_if_dc3.m',Inputs={coder.typeof(true)}, Configuration=cfg);
            testCase.BuildResultsTc4 = testCase.build('srcFile_if_dc4.m',Inputs={coder.typeof(true)}, Configuration=cfg);
            testCase.BuildResultsTc5 = testCase.build('srcFile_if_dc5.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc6 = testCase.build('srcFile_if_dc6.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc7 = testCase.build('srcFile_if_dc7.m',Inputs={coder.typeof(0)}, Configuration=cfg);
            testCase.BuildResultsTc8 = testCase.build('srcFile_if_dc8.m',Inputs={coder.typeof(zeros(1,64))}, Configuration=cfg);
            testCase.BuildResultsTc9 = testCase.build('srcFile_if_dc9.m',Inputs={coder.typeof(zeros(1,64))}, Configuration=cfg);
        end
    end

    properties (TestParameter)
        InputsTc1 = {{true}, {false}};
        InputsTc4 = {{true}, {false}};
        InputsTc5 = {{0}, {1}, {2}};
        InputsTc6 = {{0}, {1}, {2}};
        InputsTc7 = {{0}, {1}};
    end

    methods(Test)
        function tc1(testCase, InputsTc1)
            testCase.execute(testCase.BuildResultsTc1, Inputs=InputsTc1);
        end

        function tc2(testCase)            
            testCase.execute(testCase.BuildResultsTc2, Inputs={true});
        end

        function tc3(testCase)            
            testCase.execute(testCase.BuildResultsTc3, Inputs={false});
        end

        function tc4(testCase, InputsTc4)
            testCase.execute(testCase.BuildResultsTc4, Inputs=InputsTc4);
        end

        function tc5(testCase, InputsTc5)            
            testCase.execute(testCase.BuildResultsTc5, Inputs=InputsTc5);
        end

        function tc6(testCase, InputsTc6)            
            testCase.execute(testCase.BuildResultsTc6, Inputs=InputsTc6);
        end

        function tc7(testCase, InputsTc7)            
            testCase.execute(testCase.BuildResultsTc7, Inputs=InputsTc7);
        end

        function tc8(testCase)            
            for idx = 1:64
                input = [zeros(1, idx-1), 1, zeros(1,64-idx)];
                testCase.execute(testCase.BuildResultsTc8, Inputs={input});
            end 
            testCase.execute(testCase.BuildResultsTc8, Inputs={zeros(1,64)});
        end 

        function tc9(testCase)            
            for idx = 1:64
                if idx == 32 || idx == 54
                    continue;
                end
                input = [zeros(1, idx-1), 1, zeros(1,64-idx)];
                testCase.execute(testCase.BuildResultsTc9, Inputs={input});
            end 
            testCase.execute(testCase.BuildResultsTc9, Inputs={zeros(1,64)});
        end 
    end
end