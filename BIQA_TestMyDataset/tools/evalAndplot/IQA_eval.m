function [plcc mae rms srcc krcc] = IQA_eval(smos, sobj, regression_model)

srcc = corr(smos, sobj, 'type', 'Spearman');
krcc = corr(smos, sobj, 'type', 'Kendall');
pmos = feval(regression_model, sobj, smos);
plcc = corr(smos, pmos);
mae = mean(abs(smos - pmos));
rms = sqrt(mean((smos - pmos).^2));

return;