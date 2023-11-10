function res = runMatlabModel(data)
    
    load('trained_classifier.mat')

    numCh = 4;
    filtData = zeros(size(data,1),numCh);

    % Filter the data
    for ch = 1:numCh
        filtData(:,ch) = highpass(data(:,1+ch), 5, 1000); % consider changing this threshold to improve accurac
    end

    includedFeatures = {'variance', 'mean_abs_value', 'mean_freq', 'slope_sign_change', 'root_mean_square', 'kurtosis', 'skewness'};
    featureTable = extractFeatures(filtData', includedFeatures);

    res = currentClassifier.predict(featureTable)
end