function res = runMatlabModel(data)
    
    %!python testData.py --matlabmodel ../../../EMG_Live_Classifier/runMatlabModel.m
    load('trained_classifier.mat')

    numCh = 4;
    filtData = zeros(size(data,1),numCh);

    % Filter the data
    for ch = 1:numCh
        filtData(:,ch) = highpass(data(:,1+ch), 5, 1000); % consider changing this threshold to improve accuracy
    end

    includedFeatures = {'variance', 'mean_abs_value', 'mean_freq', 'slope_sign_change', 'root_mean_square', 'kurtosis', 'skewness'};
    featureTable = extractFeatures(filtData', includedFeatures);

    res = currentClassifier.predict(featureTable)
end