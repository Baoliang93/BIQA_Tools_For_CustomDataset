clc;
clear;
Label =load('label_scc_dmos.mat');
Label =struct2cell(Label);
path=Label{1,1}{1,2};
label=-1*Label{1,1}{1,1};

Pre =load('Train-Live-Test-q-RankMos-1.mat');
Pre =struct2cell(Pre);
pre=Pre{1,1}{1,2};
label_A=label(1:7:end);
label_B=label(2:7:end);
label_C=label(3:7:end);
label_D=label(4:7:end);
label_E=label(5:7:end);
label_F=label(6:7:end);
label_G=label(7:7:end);

pre_A=pre(1:7:end);
pre_B=pre(2:7:end);
pre_C=pre(3:7:end);
pre_D=pre(4:7:end);
pre_E=pre(5:7:end);
pre_F=pre(6:7:end);
pre_G=pre(7:7:end);

regression_model = 'regress_hamid';
[PLCC_A MAE RMS SRCC_A KRCC]  = IQA_eval(label_A, pre_A, regression_model);
disp(('A: '+string(PLCC_A)+string(SRCC_A)))
[PLCC_B MAE RMS SRCC_B KRCC]  = IQA_eval(label_B, pre_B, regression_model);
disp(('B: '+string(PLCC_B)+string(SRCC_B)))

[PLCC_C MAE RMS SRCC_C KRCC]  = IQA_eval(label_C, pre_C, regression_model);
disp(('C: '+string(PLCC_C)+string(SRCC_C)))

[PLCC_D MAE RMS SRCC_D KRCC]  = IQA_eval(label_D, pre_D, regression_model);
disp(('D: '+string(PLCC_D)+string(SRCC_D)))

[PLCC_E MAE RMS SRCC_E KRCC]  = IQA_eval(label_E, pre_E, regression_model);
disp(('E: '+string(PLCC_E)+string(SRCC_E)))

[PLCC_F MAE RMS SRCC_F KRCC]  = IQA_eval(label_F, pre_F, regression_model);
disp(('F: '+string(PLCC_F)+string(SRCC_F)))

[PLCC_G MAE RMS SRCC_G KRCC]  = IQA_eval(label_G, pre_G, regression_model);
disp(('G: '+string(PLCC_G)+string(SRCC_G)))


[PLCC MAE RMS SRCC KRCC]  = IQA_eval(label, pre, regression_model);
disp(('All: '+string(PLCC)+string(SRCC)))



