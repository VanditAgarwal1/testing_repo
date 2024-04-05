classdef MLT_GenCodeCov_002 < matlab.unittest.TestCase
    %
    % TEST CASE DESCRIPTION:
    % MATLAB Test provide the capability to collect
    % Function/Statement/Decision/Condition/MCDC coverage metrics for C/C++
    % code generated from MATLAB code with verification mode SIL or PIL.
    %
    % EXPECTED RESULTS:
    % Test steps 1-5 PASS: Full Coverage
    %
    % SUPPORTING FILES:
    % printColorGenCodeCovTest.m
    % printColor.m

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
            suite = testsuite('printColorGenCodeCovTest.m');
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

    methods (Test)
        function testFunctionCodeCoverage(testCase)
            functionCoverage = testCase.CodeCoverageResult.coverageSummary('function');
            testCase.verifyEqual(functionCoverage(1)/functionCoverage(2)*100, 100, 'function coverage should be 100%');
        end

        function testStatementCodeCoverage(testCase)
            statementCoverage = testCase.CodeCoverageResult.coverageSummary('statement');
            testCase.verifyEqual(statementCoverage(1)/statementCoverage(2)*100, 100, 'statement coverage should be 100%');
        end

        function testDecisionCodeCoverage(testCase)
            decisionCoverage = testCase.CodeCoverageResult.coverageSummary('decision');
            testCase.verifyEqual(decisionCoverage(1)/decisionCoverage(2)*100, 100, 'decision coverage should be 100%');
        end

        function testConditionCodeCoverage(testCase)
            conditionCoverage = testCase.CodeCoverageResult.coverageSummary('condition');
            testCase.verifyEqual(conditionCoverage(1)/conditionCoverage(2)*100, 100, 'condition coverage should be 100%');
        end

        function testMCDCCodeCoverage(testCase)
            mcdcCoverage = testCase.CodeCoverageResult.coverageSummary('mcdc');
            testCase.verifyEqual(mcdcCoverage(1)/mcdcCoverage(2)*100, 100, 'mcdc coverage should be 100%');
        end
    end
end

function codeCoverageResult = getCoverageResult(result)
for id = 1:length(result)
    if ~(contains(result(id).Filename,'initialize') || contains(result(id).Filename,'terminate'))
        codeCoverageResult = result(id);
    end
end
end