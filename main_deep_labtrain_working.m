%% STEP 1. Datastores
imds = imageDatastore("images");
classes = ["SS","SC","DEJ","Other"];
labelIDs = [1 2 3 4];
pxds = pixelLabelDatastore("masks", classes, labelIDs);
%% STEP 2. Split dataset
numFiles = numel(imds.Files);
idx = randperm(numFiles);
trainIdx = idx(1:round(0.8 * numFiles));
valIdx   = idx(round(0.8 * numFiles) + 1 : end);
imdsTrain = subset(imds, trainIdx);
pxdsTrain = subset(pxds, trainIdx);
imdsVal = subset(imds, valIdx);
pxdsVal = subset(pxds, valIdx);
%% STEP 3. Label datastores
dsTrain = pixelLabelImageDatastore(imdsTrain, pxdsTrain);
dsVal   = pixelLabelImageDatastore(imdsVal, pxdsVal);
dsTrain = transform(dsTrain, @to3);
dsVal   = transform(dsVal, @to3);
%% STEP 4. Build DeepLab v3+ (old MATLAB syntax)
imageSize = [1024 1600 3];
numClasses = 4;
% NO Weights parameter in your version
lgraph = deeplabv3plusLayers(imageSize, numClasses, "resnet50");
%% STEP 5. Training options
options = trainingOptions("adam", ...
   "InitialLearnRate", 1e-4, ...
   "MaxEpochs", 5, ...
   "MiniBatchSize", 1, ...
   "Shuffle", "every-epoch", ...
   "ValidationData", dsVal, ...
   "ValidationFrequency", 50, ...
   "Plots", "training-progress", ...
   "Verbose", true);
%% STEP 6. Train
trainedNet = trainNetwork(dsTrain, lgraph, options);
%% STEP 7. Evaluation
results = evaluateSemanticSegmentation(dsVal, trainedNet);
results.DataSetMetrics
results.ClassMetrics
results.ConfusionMatrix
%% Helper function
function dataOut = to3(dataIn)
   I = dataIn.inputImage{1};
   L = dataIn.pixelLabelImage{1};
   if size(I,3) == 1
       I = repmat(I, [1 1 3]);
   end
   dataOut = {I, L};
end
