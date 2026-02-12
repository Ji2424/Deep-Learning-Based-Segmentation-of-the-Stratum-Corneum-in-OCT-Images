% Step 1. Load TIFF files
imageFiles = dir('*.tiff');
imageNames = {imageFiles.name}';

% Step 2. Load MAT files
matFiles = dir('labeled_image*.mat');
matNames = {matFiles.name}';

% Check count
numSlices = length(imageNames);

if numSlices ~= length(matNames)
    error('TIFF count does not match MAT count');
end

% Step 3. Create folders
mkdir images
mkdir masks

% Step 4. Loop through slices
for i = 1:numSlices

    % Load TIFF slice (image i)
    I = imread(imageNames{i});
    I = mat2gray(double(I));

    % Load the corresponding MAT file
    S = load(matNames{i});
    Layers = S.Layers;

    % Extract ONLY the i-th mask slice
    M = Layers.Labels(:,:,i);   % THIS IS THE FIX
    M = uint8(M);

    % Save image and mask
    imwrite(I, sprintf('images/img_%03d.png', i));
    imwrite(M, sprintf('masks/mask_%03d.png', i));
end

disp('Finished exporting dataset.');



