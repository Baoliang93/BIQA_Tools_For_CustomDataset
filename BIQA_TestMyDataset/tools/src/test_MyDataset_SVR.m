function test_MyDataset_SVR(testDatabase,MosTxtName, testMethod, Trainingproportion,repetitions)
    
    if ~exist(fullfile('result', testDatabase, testMethod), 'dir')
        mkdir(fullfile('result', testDatabase, testMethod));
    end
    
    fprintf('processing MyDataset images.....');
    Path = fullfile('databases', testDatabase);
    fp = fopen(fullfile(Path,MosTxtName),'r');
    C = textscan(fp,'%s%f32');
    disImagePath = C{1,1};
    mos = C{1,2}; 
    [lines,~]=size(mos);
    fclose(fp);
    
    
    if ~exist(fullfile('result', testDatabase, testMethod, 'features.mat'), 'file')       
        for i = 1:lines
            fprintf('processing image %d / 3000 \n',i);
            ImagePath = fullfile(Path,'distorted_images',disImagePath{i});
            features{i} = MyCallingTheSourceCodeForFeatureExtraction(ImagePath,testMethod);
        end
        features = cat(2,features{:});
        save(fullfile('result', testDatabase, testMethod, 'features.mat'),'features','mos');
    else
        load(fullfile('result', testDatabase, testMethod, 'features.mat'),'features','mos');
    end
    
    idx = isnan(features); features(idx) = 0;  % for FRIQUEE
    
    tic;
    trainNum = ceil(lines * Trainingproportion);
    regression_model = 'regress_hamid';
    mos = double(mos)';
    if repetitions ==1        
        trainingSet = 1:trainNum;
        testingSet = trainNum+1:lines;
        trainX = features(:,trainingSet)';
        testX = features(:,testingSet)';
        
        if ~strcmp(testMethod,'HOSA')
            [trainX, testX] = featNormalize(trainX, testX);
        end
        
        switch testMethod
            case 'BRISQUE'
                if Trainingproportion == 0.2
                    svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 2 -c 256 -g 0.005');
                elseif Trainingproportion == 0.5
                    svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 2 -c 128 -g 0.05');
                else
                    svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 2 -c 256 -g 0.005');
                end
            case 'CORNIA'
                svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 0');
            case 'HOSA'
                if Trainingproportion >= 0.8
                    svm_model = svmtrain(mos(trainingSet)',  double(trainX), '-s 4 -t 2 -c 256 -g 0.005');
                else
                    svm_model = svmtrain(mos(trainingSet)',  double(trainX), '-s 4 -t 2 -c 128 -g 0.05');
                end
            case 'DIIVINE'
                if Trainingproportion >= 0.8
                    svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 2 -c 4 -g 0.5');
                elseif Trainingproportion == 0.5
                    svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 2 -c 4 -g 0.3');
                else
                    svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 2 -c 4 -g 0.06');
                end
            case 'FRIQUEE'
                if Trainingproportion >= 0.8
                    svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 2 -c 0.5 -g 0.05');
                elseif Trainingproportion == 0.5
                    svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 2 -c 1 -g 0.1');
                elseif Trainingproportion == 0.2
                    svm_model = svmtrain(mos(trainingSet)', double(trainX), '-s 4 -t 2 -c 2 -g 0.05');
                end
            otherwise 
                error('Unsupported Method!');
        end
        [scores, ~,~] = svmpredict(mos(testingSet)', double(testX), svm_model,'-q');
%         if strcmp(testMethod,'HOSA')
%             [scores, ~,~] = predict(mos(testingSet)', sparse(testX), svm_model,'-q');
%         else
%             [scores, ~,~] = svmpredict(mos(testingSet)', double(testX), svm_model,'-q');
%         end
            
        [PLCC MAE RMS SRCC KRCC]  = IQA_eval(mos(testingSet)', scores, regression_model);        
        fprintf('Method = %s, SRCC = %.4f,  PLCC = %.4f, \n', testMethod, abs(SRCC), abs(PLCC));
    else
        error('Unsupported Now!');
    end
        
        
    