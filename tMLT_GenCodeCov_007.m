classdef MLT_GenCodeCov_007 < matlab.unittest.TestCase
    %
    % TEST CASE DESCRIPTION:
    % MATLAB Test provides the capability to collect MC/DC coverage for
    % if statement and both condition and MC/DC coverage for assignment
    % involving C/C++ code generated from MATLAB code with 
    % verification mode SIL or PIL.
    %
    % EXPECTED RESULTS:
    % Test steps 1-2 PASS
    %
    % SUPPORTING FILES:
    % srcFile_if_mcdc1.m
    % srcFile_if_mcdc2.m
    % srcFile_if_mcdc3.m
    % srcFile_if_mcdc4.m
    % srcFile_if_mcdc5.m
    % if_mcdc_GenCodeCovTest.m
    % srcFile_assignment1.m
    % srcFile_assignment2.m
    % srcFile_assignment3.m
    % srcFile_assignment4.m
    % srcFile_assignment5.m
    % srcFile_assignment6.m
    % srcFile_assignment7.m
    % assignment_mcdc_GenCodeCovTest.m


    % Copyright 2023 The MathWorks, Inc.

    properties(TestParameter)
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
	end

    methods(Test)
        function testIfMCDCCoverage(testCase, TargetLang, VerificationMode, BuildMode)
            ifCodeCovR = getCodeCoverageResult('if_mcdc_GenCodeCovTest.m', TargetLang, VerificationMode, BuildMode);
            mcdcCC = ifCodeCovR.coverageSummary('mcdc');
            expMetric = [3/3; 2/3; 0/2; 12/12; 6/12];
            testCase.verifyEqual(mcdcCC(:,1)./mcdcCC(:,2), expMetric);
        end

        function testAssignmentConditionAndMCDCCoverage(testCase, TargetLang, VerificationMode, BuildMode)
            assignmentCodeCovR = getCodeCoverageResult('assignment_mcdc_GenCodeCovTest.m', TargetLang, VerificationMode, BuildMode);
            conditionCC = assignmentCodeCovR.coverageSummary('condition');
            expConditionMetric = [4/4; 1/6; 3/6; 24/24; 18/24; 128/128; 68/128];
            testCase.verifyEqual(conditionCC(:,1)./conditionCC(:,2), expConditionMetric);

            mcdcCC = assignmentCodeCovR.coverageSummary('mcdc');
            expMCDCMetric = [2/2; 0/3; 0/3; 12/12; 6/12; 64/64; 4/64];
            testCase.verifyEqual(mcdcCC(:,1)./mcdcCC(:,2), expMCDCMetric);

        end
    end
end

function result = getCodeCoverageResult(inputTests, TargetLang, VerificationMode, BuildMode)
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageResult
import matlab.unittest.TestRunner

runner = TestRunner.withNoPlugins;
suite = testsuite(inputTests);
suite = suite.selectIf("ParameterName",TargetLang);
suite = suite.selectIf("ParameterName",VerificationMode);
suite = suite.selectIf("ParameterName",BuildMode);
format = CoverageResult();
plugin = matlabtest.coder.plugins.GeneratedCodeCoveragePlugin(Producing=format, MetricLevel="mcdc");
runner.addPlugin(plugin);
runner.run(suite);
result = getCoverageResult(format.Result);
end

function coverageResult = getCoverageResult(result)
coverageResult = [];
for id = 1:length(result)
    if ~(contains(result(id).Filename,'initialize') || contains(result(id).Filename,'terminate'))
    coverageResult = [result(id), coverageResult];
    end
end
% sort('/', '0') and sort('\', '0') give different results(g3171178)
[~, id] = sort(replace([coverageResult.Filename], filesep, '\'));
coverageResult = coverageResult(id);
end
