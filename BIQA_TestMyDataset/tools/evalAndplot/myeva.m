clc;
clear;
%Label =load('predmosci_niqeX.mat');
Label =load('label_sci_scch_mos.mat');
Label =struct2cell(Label);
%path=Label{1,1}{1,1};
%label=Label{1,1}{1,2};

path=Label{1,1}{1,1};
label=Label{1,1}{1,2};

%Pre =load('predmosbrisq.mat');
Pre =load('Train-Tid-Test-scch-RankMos-1.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};
regression_model = 'regress_hamid';
[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);
%disp(('plcc,srcc: '+string(PLCC)+string(SRCC)))
disp(('ours: '+string(PLCC)+' '+string(MAE)+' '+string(RMS)+' '+string(SRCC)+' '+string(KRCC)))

Pre =load('Train-Tid-Test-scch-RankMos-0.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};
regression_model = 'regress_hamid';
[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);
%disp(('plcc,srcc: '+string(PLCC)+string(SRCC)))
disp(('ours1st: '+string(PLCC)+' '+string(MAE)+' '+string(RMS)+' '+string(SRCC)+' '+string(KRCC)))

Pre =load('ablation-Train-Tid-Test-scc-mse-RankMos-1.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};
regression_model = 'regress_hamid';
[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);
%disp(('plcc,srcc: '+string(PLCC)+string(SRCC)))
disp(('mse: '+string(PLCC)+' '+string(MAE)+' '+string(RMS)+' '+string(SRCC)+' '+string(KRCC)))


Pre =load('ablation-Train-Tid-Test-scc-mseMMD-RankMos-0.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};
regression_model = 'regress_hamid';
[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);
%disp(('plcc,srcc: '+string(PLCC)+string(SRCC)))
disp(('mseMMD: '+string(PLCC)+' '+string(MAE)+' '+string(RMS)+' '+string(SRCC)+' '+string(KRCC)))


Pre =load('ablation-Train-Tid-Test-scc-Rank-0.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};
regression_model = 'regress_hamid';
[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);
%disp(('plcc,srcc: '+string(PLCC)+string(SRCC)))
disp(('rank: '+string(PLCC)+' '+string(MAE)+' '+string(RMS)+' '+string(SRCC)+' '+string(KRCC)))


Pre =load('ablation-Train-Tid-Test-scc-RankMMD-0.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};
regression_model = 'regress_hamid';
[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);
%disp(('plcc,srcc: '+string(PLCC)+string(SRCC)))
disp(('rankmmd: '+string(PLCC)+' '+string(MAE)+' '+string(RMS)+' '+string(SRCC)+' '+string(KRCC)))


Pre =load('ablation-Train-Tid-Test-scc-RankMMDDA-0.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};
regression_model = 'regress_hamid';
[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);
%disp(('plcc,srcc: '+string(PLCC)+string(SRCC)))
disp(('rankmmdda: '+string(PLCC)+' '+string(MAE)+' '+string(RMS)+' '+string(SRCC)+' '+string(KRCC)))