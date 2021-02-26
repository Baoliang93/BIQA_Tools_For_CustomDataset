
function [delta,beta,yhat,mos,diff] = findrmse1(iqa,mos,str,str2,str3,xxx,yyy,zzz)

%x = iqa;
%y = mos;
%temp = corrcoef(x,y);
%if (temp(1,2)>0)
%beta0(3) = mean(x);
%beta0(1) = abs(max(y) - min(y));
%beta0(4) = mean(y);
%beta0(2) = 1/std(x);
%beta0(5) = 1;%0;%1;
%else
%beta0(3) = mean(x);
%beta0(1) = -abs(max(y) - min(y));
%beta0(4) = mean(y);
%beta0(2) = 1/std(x);
%beta0(5) = 1;%0;%1;
%end
%maxiter = 100000;
%[beta ehat J] = nlinfit(x,y,@myfunn3,beta0,maxiter);
%[yhat delta] = nlpredci(@myfunn3,x,beta,ehat,J);
%diff = abs(y - yhat);
%[xx ord] = sort(x);

%%
%g = figure;hold on;
%h = plot(x,y,'.','markersize',24);
%plot(xx,yhat(ord),'r','LineWidth',3);
%plot(xx,yhat(ord)+delta(ord),'k--','LineWidth',3);
%plot(xx,yhat(ord)-delta(ord),'k--','LineWidth',3);

% close all
% beg(:,1) = [192  80  77]/255;
% beg(:,2) = [247 150  70]/255;
% beg(:,3) = [155 187  89]/255;
% beg(:,4) = [ 79 129 189]/255;
% beg(:,5) = [ 75 172 198]/255;
% beg(:,6) = [128 100 162]/255;
regression_model = 'regress_hamid';

iqa1 = feval(regression_model, iqa, mos);
iqa  = iqa1;
plcc = corr(mos, iqa)


beg(:,1) = [255 000 000]/255;
beg(:,2) = [000 255 000]/255;
beg(:,1) = [000 000 255]/255;
beg(:,2) = [000 255 255]/255;
% beg(:,7) = [192 192 192]/255;
ttt = 'osd^v><';
num1=258;
num =492;
g = figure;hold on;
i = 1;
h = plot(iqa(1:num1),mos(1:num1),ttt(i),'MarkerFaceColor',beg(:,i),'MarkerEdgeColor','k','Markersize',10);

i = 2;
h = plot(iqa(num1+1:num),mos(num1+1:num),ttt(i),'MarkerFaceColor',beg(:,i),'MarkerEdgeColor','k','Markersize',10);

%xx = xxx(1):0.01:xxx(end);
%h = plot(xx,xx,'--','color',[0 0 0]/255,'markersize',30);set(h,'LineWidth',2.5);

%global contrast decrements
legend('HEVC','HEVC-SCC','Location',zzz);
set(gca,'fontsize',20,'LineWidth',1);
xlabel(str2,'fontsize',30);
ylabel(str3,'fontsize',30);
%title(str,'fontsize',40);

xlim(xxx([1,end]));
ylim(yyy([1,end]));
set(gca,'XTick',xxx);
set(gca,'YTick',yyy);
%set(gca,'ygrid','on');
%set(gca,'LineWidth',2);

saveas(gca,[str '_' str2 '2'],'png');
close all
