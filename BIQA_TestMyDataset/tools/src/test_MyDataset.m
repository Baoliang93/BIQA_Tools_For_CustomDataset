function [SRCC,PLCC] = test_MyDataset(net,testDatabase,MosTxtName, testMethod, Trainingproportion,repetitions)
    
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
    
    if ~exist(fullfile('result', testDatabase, testMethod, 'scores.mat'), 'file')
        for i = 1:numel(disImagePath)
            fprintf('processing image %d / %d \n',i,numel(disImagePath));
            scores(i) = CallingTheSourceCodeForScorePrediction(disImagePath{i},testMethod);
        end
        save(fullfile('result', testDatabase, testMethod, 'scores.mat'),'scores');
    else
        load(fullfile('result', testDatabase, testMethod, 'scores.mat'),'scores');
    end
    trainNum = ceil(lines * Trainingproportion);
    regression_model = 'regress_hamid';
    scores = scores(:);
    if repetitions ==1        
        testingSet = trainNum+1:lines;
        [PLCC MAE RMS SRCC KRCC]  = IQA_eval(mos(testingSet), scores(testingSet), regression_model);        
        fprintf('Method = %s, SRCC = %.4f,  PLCC = %.4f, \n', testMethod, abs(SRCC), abs(PLCC));
    else
        all_ids = 1:lines;
        for seed = 1:10
            testingSet = (randperm(numel(all_ids),lines-trainNum));
            [plcc MAE RMS srcc KRCC]  = IQA_eval(mos(testingSet), scores(testingSet), regression_model);
            fprintf('Method = %s, SRCC = %.4f,  PLCC = %.4f, \n', testMethod, abs(srcc), abs(plcc));
            SRCC(seed) = srcc;
            PLCC(seed) = plcc;
        end
        fprintf('SRCC = %.4f, std = %.4f;  PLCC = %.4f, std = %.4f \n', abs(median(SRCC)), std(SRCC), abs(median((PLCC))), std((PLCC)));
    end
end

