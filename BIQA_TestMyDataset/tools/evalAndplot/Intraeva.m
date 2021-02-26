clc;
clear;

Label =load('MOS_Tid2013_test.mat');
Label =struct2cell(Label);


path=Label{1,1}{1,2};
label=Label{1,1}{1,1};

Pre =load('Train-Tid-Test-tid-mse-RankMos-0.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};
regression_model = 'regress_hamid';
[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);

disp(('ours: '+string(PLCC)+' '+string(MAE)+' '+string(RMS)+' '+string(SRCC)+' '+string(KRCC)))
