function [SRCC,PLCC] = test_MyDataset_OnlyTestingset(net,testDatabase,MosTxtName, testMethod, Trainingproportion,repetitions)
    
    if ~exist(fullfile('result', testDatabase, testMethod), 'dir')
        mkdir(fullfile('result', testDatabase, testMethod));
    end
    
    fprintf('Results on MyDataset...');
    Path = fullfile('databases', testDatabase);   
    fp = fopen(fullfile(Path,MosTxtName),'r');
    
    C = textscan(fp,'%s%f32');
    disImagePath = C{1,1};
    mos = C{1,2}; 
    [lines,~]=size(mos);
    for i = 1:lines
        disImagePath{i} = fullfile(Path,'distorted_images',disImagePath{i});
    end
    fclose(fp);
    trainNum = ceil(lines * Trainingproportion);
    if ~exist(fullfile('result', testDatabase, testMethod, 'scores.mat'), 'file')
        for i = trainNum+1:numel(disImagePath)
            fprintf('processing image %d / %d \n',i,numel(disImagePath));
            scores(i) = CallingTheSourceCodeForScorePrediction(disImagePath{i},testMethod);
        end
        save(fullfile('result', testDatabase, testMethod, 'scores.mat'),'scores');
    else
        load(fullfile('result', testDatabase, testMethod, 'scores.mat'),'scores');
    end
    
    regression_model = 'regress_hamid';
    scores = scores(:);
    if repetitions ==1        
        [PLCC MAE RMS SRCC KRCC]  = IQA_eval(mos, scores, regression_model);        
        fprintf('Method = %s, SRCC = %.4f,  PLCC = %.4f, \n', testMethod, abs(SRCC), abs(PLCC));
    else
        fprintf('Unsupport!')
    end
end

