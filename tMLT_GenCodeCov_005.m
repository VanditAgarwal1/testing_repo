classdef MLT_GenCodeCov_005 < matlab.unittest.TestCase
    %
    % TEST CASE DESCRIPTION:
    % MATLAB Test provides the capability to collect statement and 
    % decision coverage for while loop, switch, if and for loop
    % MATLAB Test code coverage collection does not affected by
    % indentation.
    % Statement/Decision coverage metrics are collected for C/C++
    % code generated from MATLAB code with verification mode SIL or PIL.
    %
    % EXPECTED RESULTS:
    % Test steps 1-5 PASS
    %
    % SUPPORTING FILES:
    % srcFile_while_dc1.m
    % srcFile_while_dc2.m
    % srcFile_while_dc3.m
    % srcFile_while_dc4.m
    % srcFile_while_dc5.m
    % srcFile_while_dc6.m
    % while_dc_GenCodeCov_Test.m
    % srcFile_switch_dc1.m
    % srcFile_switch_dc2.m
    % srcFile_switch_dc3.m
    % srcFile_switch_dc4.m
    % srcFile_switch_dc5.m
    % srcFile_switch_dc6.m
    % srcFile_switch_dc7.m
    % srcFile_switch_dc8.m
    % switch_dc_GenCodeCov_Test.m
    % srcFile_if_dc1.m
    % srcFile_if_dc2.m
    % srcFile_if_dc3.m
    % srcFile_if_dc4.m
    % srcFile_if_dc5.m
    % srcFile_if_dc6.m
    % srcFile_if_dc7.m
    % srcFile_if_dc8.m
    % srcFile_if_dc9.m
    % if_dc_GenCodeCov_Test.m
    % srcFile_for_dc1.m
    % srcFile_for_dc2.m
    % srcFile_for_dc3.m
    % srcFile_for_dc4.m
    % srcFile_for_dc5.m
    % srcFile_for_dc6.m
    % srcFile_for_dc7.m
    % srcFile_for_dc8.m
    % srcFile_for_dc9.m
    % srcFile_for_dc10.m
    % for_dc_GenCodeCov_Test.m

    % Copyright 2023 The MathWorks, Inc.

    properties
        CodeCoverageResult;
        ForLoopExpectedSC = struct('C', [5/5; 9/9; 9/9; 14/14; 4/5; 12/12; 10/11; 8/9; 8/12; 54/54],...
                            'Cpp', [5/5; 8/8; 8/8; 12/12; 4/5; 12/12; 9/10; 7/8; 8/12; 44/44]);
    end

    properties(TestParameter)
        BuildMode = {'lib'};
        VerificationMode = {'SIL', 'PIL'};
        TargetLang = {'C', 'C++'};
    end

	methods (TestClassSetup)
        function suppressCompilerWarnings(testCase)
            %Added this to suppress C4083 MSVC warning (g3041111). 
            import matlab.unittest.fixtures.SuppressedWarningsFixture

            testCase.applyFixture(SuppressedWarningsFixture('Coder:buildProcess:targetCompilerWarnings'));
        end
	end

    methods(Test)
        function testWhileLoopDecisionCoverage(testCase, TargetLang, VerificationMode, BuildMode)
            whileCodeCovR = getCodeCoverageResult('while_dc_GenCodeCov_Test.m', TargetLang, VerificationMode, BuildMode);
            decisionCC = whileCodeCovR.coverageSummary('decision');
            expDecisionMetric = [2/2; 1/4; 1/2; 2/2; 4/4; 4/4];
            testCase.verifyEqual(decisionCC(:,1)./decisionCC(:,2), expDecisionMetric);

            statementCC = whileCodeCovR.coverageSummary('statement');
            expStatementCC = [3/3; 4/7; 4/5; 5/5; 11/11; 11/11];
            testCase.verifyEqual(statementCC(:,1)./statementCC(:,2), expStatementCC);
        end

        function testSwitchDecisionCoverage(testCase, TargetLang, VerificationMode, BuildMode)
            switchCodeCovR = getCodeCoverageResult('switch_dc_GenCodeCov_Test.m', TargetLang, VerificationMode, BuildMode);
            decisionCC = switchCodeCovR.coverageSummary('decision');
            expDecisionMetric = [4/4; 3/4; 3/4; 1/6; 4/4; 4/4; 65/65; 64/65];
            testCase.verifyEqual(decisionCC(:,1)./decisionCC(:,2), expDecisionMetric);

            statementCC = switchCodeCovR.coverageSummary('statement');
            expStatementCC = [11/11; 9/11; 9/11; 4/13; 11/11; 10/10; 133/133; 131/133];
            testCase.verifyEqual(statementCC(:,1)./statementCC(:,2), expStatementCC);
        end

        function testIfDecisionCoverage(testCase, TargetLang, VerificationMode, BuildMode)
            ifCodeCovR = getCodeCoverageResult('if_dc_GenCodeCov_Test.m', TargetLang, VerificationMode, BuildMode);
            decisionCC = ifCodeCovR.coverageSummary('decision');
            expDecisionMetric = [2/2; 1/2; 1/2; 2/2; 4/4; 4/4; 2/2; 128/128; 126/128];
            testCase.verifyEqual(decisionCC(:,1)./decisionCC(:,2), expDecisionMetric);

            statementCC = ifCodeCovR.coverageSummary('statement');
            expStatementCC = [5/5; 4/5; 4/5; 5/5; 7/7; 7/7; 5/5; 131/131; 129/131];
            testCase.verifyEqual(statementCC(:,1)./statementCC(:,2), expStatementCC);

        end
 
        function testForLoopDecisionCoverage(testCase, TargetLang, VerificationMode, BuildMode)
            forCodeCovR = getCodeCoverageResult('for_dc_GenCodeCov_Test.m', TargetLang, VerificationMode, BuildMode);
            expDecisionMetric = [1/2; 2/2; 2/2; 4/4; 1/2; 4/4; 3/4; 1/2; 1/4; 20/20];
            expStatementCC = testCase.ForLoopExpectedSC.(strrep(TargetLang, "++", "pp"));
            
            decisionCC = forCodeCovR.coverageSummary('decision');
            testCase.verifyEqual(decisionCC(:,1)./decisionCC(:,2), expDecisionMetric);
                
            statementCC = forCodeCovR.coverageSummary('statement');            
            testCase.verifyEqual(statementCC(:,1)./statementCC(:,2), expStatementCC);
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