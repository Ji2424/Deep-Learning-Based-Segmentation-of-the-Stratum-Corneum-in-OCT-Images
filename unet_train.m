

%% STEP 1. Create datastores
imds = imageDatastore('images');

classes = ["SS","SC","DEJ","Other"];
labelIDs = [1 2 3 4];

pxds = pixelLabelDatastore('masks', classes, labelIDs);


%% STEP 2. Split dataset (80 percent train, 20 percent val)
numFiles = numel(imds.Files);
idx = randperm(numFiles);

trainIdx = idx(1:round(0.8 * numFiles));
valIdx   = idx(round(0.8 * numFiles) + 1 : end);

imdsTrain = subset(imds, trainIdx);
pxdsTrain = subset(pxds, trainIdx);

imdsVal = subset(imds, valIdx);
pxdsVal = subset(pxds, valIdx);


%% STEP 3. Prepare datastores (convert grayscale to RGB)
dsTrain = pixelLabelImageDatastore(imdsTrain, pxdsTrain);
dsVal   = pixelLabelImageDatastore(imdsVal, pxdsVal);

dsTrain = transform(dsTrain, @to3);
dsVal   = transform(dsVal, @to3);


%% STEP 4. Build U-Net model
imageSize = [1024 1600 3];
numClasses = 4;

lgraph = unetLayers(imageSize, numClasses);


%% STEP 5. Training options
options = trainingOptions("adam", ...
    "InitialLearnRate", 1e-4, ...
    "MaxEpochs", 5, ...         % Increase later if needed
    "MiniBatchSize", 1, ...
    "Shuffle", "every-epoch", ...
    "ValidationData", dsVal, ...
    "ValidationFrequency", 50, ...
    "Plots", "training-progress", ...
    "Verbose", true);


%% STEP 6. Train
trainedNet = trainNetwork(dsTrain, lgraph, options);


%% STEP 7. Full evaluation on validation set
results = evaluateSemanticSegmentation(dsVal, trainedNet);

disp("Dataset Metrics:");
results.DataSetMetrics

disp("Per-Class Metrics:");
results.ClassMetrics

disp("Confusion Matrix:");
results.ConfusionMatrix


%% Helper function: convert grayscale to RGB
function dataOut = to3(dataIn)
    I = dataIn.inputImage{1};
    L = dataIn.pixelLabelImage{1};

    if size(I,3) == 1
        I = repmat(I, [1 1 3]);
    end

    dataOut = {I, L};
end



