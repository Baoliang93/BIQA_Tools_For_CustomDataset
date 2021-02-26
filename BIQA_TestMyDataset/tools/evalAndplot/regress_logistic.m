function [yhat, beta, ehat, rsqr] = regress_logistic(X, Y)

model = 'logistic5';

ymax = max(Y);
ymin = min(Y);
xmax = max(X);
xmin = min(X);

beta0(1) = ymax;
beta0(2) = ymin;
beta0(3) = mean(X);
beta0(4) = 0.5;

[beta ehat, J] = nlinfit(X, Y, model, beta0);
[yhat delta] = nlpredci(model, X, beta, ehat, J);

ehat = Y-yhat;
mY = mean(Y);
rsqr = 1 - sum(ehat.^2)/sum((Y-mY).^2);

return;