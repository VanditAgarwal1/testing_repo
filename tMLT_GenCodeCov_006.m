classdef MLT_GenCodeCov_006 < matlab.unittest.TestCase
    %
    % TEST CASE DESCRIPTION:
    % MATLAB Test provides the capability to collect condition coverage for
    % if statement for C/C++ code generated from MATLAB code with 
    % verification mode SIL or PIL.
    %
    % EXPECTED RESULTS:
    % Test step 1 PASS
    %
    % SUPPORTING FILES:
    % srcFile_if_cc1.m
    % srcFile_if_cc2.m
    % srcFile_if_cc3.m
    % srcFile_if_cc4.m
    % srcFile_if_cc5.m
    % if_cc_GenCodeCov_Test.m


    % Copyright 2023 The MathWorks, Inc.

    properties
        CodeCoverageResult;
    end

    properties(ClassSetupParameter)
        BuildMode = {'lib'};
        VerificationMode = {'SIL', 'PIL'};
        TargetLang = {'C', 'C++'}
    end

    methods (TestClassSetup)

        function suppressCompilerWarnings(testCase)
            %Added this to suppress C4083 MSVC warning (g3041111). 
            import matlab.unittest.fixtures.SuppressedWarningsFixture

            testCase.applyFixture(SuppressedWarningsFixture('Coder:buildProcess:targetCompilerWarnings'));
        end

        function generateCodeCoverage(testCase, TargetLang, VerificationMode, BuildMode)
            import matlab.unittest.plugins.codecoverage.CoverageResult
            import matlab.unittest.TestRunner

            runner = TestRunner.withNoPlugins;
            suite = testsuite('if_cc_GenCodeCov_Test.m');
            suite = suite.selectIf("ParameterName",TargetLang);
            suite = suite.selectIf("ParameterName",VerificationMode);
            suite = suite.selectIf("ParameterName",BuildMode);
            format = CoverageResult();
            plugin = matlabtest.coder.plugins.GeneratedCodeCoveragePlugin(Producing=format, MetricLevel="mcdc");
            runner.addPlugin(plugin);
            runner.run(suite);           
            testCase.CodeCoverageResult = getCoverageResult(format.Result);
        end
    end

    methods(Test)
        function testIfConditionCoverage(testCase)
            conditionCC = testCase.CodeCoverageResult.coverageSummary('condition');
            expConditionMetric = [4/4; 1/4; 2/4; 128/128; 126/128];
            testCase.verifyEqual(conditionCC(:,1)./conditionCC(:,2), expConditionMetric);
        end
    end
end

function coverageResult = getCoverageResult(result)
coverageResult = [];
for id = 1:length(result)
    if ~(contains(result(id).Filename,'initialize') || contains(result(id).Filename,'terminate'))
    coverageResult = [result(id), coverageResult];
    end
end
%  sort('/', '0') and sort('\', '0') give different results(g3171178)
[~, id] = sort(replace([coverageResult.Filename], filesep, '\'));
coverageResult = coverageResult(id);
end

