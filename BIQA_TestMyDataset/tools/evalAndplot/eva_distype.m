clc;
clear;
Label =load('sci_scch.mat');
Label =struct2cell(Label);
path=Label{1,1}{1,1};
label=Label{1,1}{1,2};

Pre =load('predmosscnn_sccRank.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};


regression_model = 'regress_hamid';
[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);
PLCC
SRCC