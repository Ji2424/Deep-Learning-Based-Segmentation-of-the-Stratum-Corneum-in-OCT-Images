%% Step 1. Load the trained model
load trainedUNet1.mat    % loads trainedNet


%% Step 2. Load a test OCT image (.png or .tiff)
testImage = imread("Bscan - (16Oct2025 11-25-48.77).tiff");

% Convert grayscale to RGB if needed
if size(testImage,3) == 1
   testImage = repmat(testImage,[1 1 3]);
end


%% Step 3. Run segmentation
predMask = semanticseg(testImage, trainedNet);


%% Step 4. Apply your custom colours for visualisation
% IMPORTANT: replace colours later when you send me one ground truth mask.
% These are placeholder colours but the structure is correct.

classes = ["SS","SC","DEJ","Other"];

cmap = [
    0 0 1        % SS (blue)
    1 0 0        % SC (red)
    1 0.6 0      % DEJ (orange)
    0.5 0 0.7    % Other (purple)
];

overlay = labeloverlay(testImage, predMask, ...
    "Colormap", cmap, ...
    "Transparency", 0.35);

figure; 
imshow(overlay);
title("Predicted Segmentation (Custom Colours)");


%% Optional Step 5. Compare with ground truth
% Only use this if you have the matching labelled mask
% trueMask = readimage(pxds, index);
% figure;
% subplot(1,2,1); imshow(labeloverlay(testImage, trueMask, "Colormap", cmap, "Transparency",0.35)); title("Ground Truth");
% subplot(1,2,2); imshow(overlay); title("Prediction");


%% Optional Step 6. Evaluate on validation set
% results = evaluateSemanticSegmentation(dsVal, trainedNet);
% metrics = results.DataSetMetrics
% classMetrics = results.ClassMetrics


