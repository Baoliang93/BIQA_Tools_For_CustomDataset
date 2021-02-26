% clc;
clear;
warning off;

addpath('support_methods/');
addpath(genpath('tools'));

testDatabase = 'MyDataset'; % LIVE CSIQ TID2013 ChallengeDB_release
MosTxtName = 'names_with_mos.txt';
testMethod = {'NIQE'};
%testMethod = {'HOSA'}; % NIQE, BRISQUE, DIIVINE, FRIQUEE, CORNIA, NIQE, ILNIQE, HOSA
trainingPropertion = 0.80;
repetitions = 1; % when repetitions = 1, no random, split in order
seed = 0;

for j = 1:numel(testMethod)
    addpath(genpath(fullfile('support_methods',testMethod{j})));
    if strcmp(testMethod{j},'NIQE') || strcmp(testMethod{j},'ILNIQE')
        test_MyDataset([],testDatabase,MosTxtName,testMethod{j},trainingPropertion,repetitions);            
    else
        test_MyDataset_SVR(testDatabase,MosTxtName,testMethod{j}, trainingPropertion,repetitions);
    end
    rmpath(genpath(fullfile('support_methods',testMethod{j})));
end
