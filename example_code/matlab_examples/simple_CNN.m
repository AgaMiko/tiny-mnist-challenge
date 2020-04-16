% MSI TinyMNIST CHallenge 2020
% Agnieszka Miko³ajczyk
% Use "Run section" or "Run and Advance" option!
clc, clear
%% Load dataset
tinyMNIST = imageDatastore('TinyMNIST/train/', 'LabelSource', 'foldernames', 'IncludeSubfolders',true);
stats = countEachLabel(tinyMNIST)
[train,valid] = splitEachLabel(tinyMNIST,350,'randomize'); % split to validation and test data

%% Network architecture
% generate your own layer with APPS -> Deep Network Designer
% design it and click "analyze"
% if everything is ok click "export" and "generate code"
% now you can paste here your new layers

layers = [
    imageInputLayer([28 28 1],"Name","imageinput")
    convolution2dLayer([3 3],16,"Name","conv_2","Padding","same")
    reluLayer("Name","relu")
    convolution2dLayer([3 3],16,"Name","conv_1","Padding","same")
    maxPooling2dLayer([5 5],"Name","maxpool","Padding","same","Stride",[5 5])
    fullyConnectedLayer(10,"Name","fc")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")]

plot(layerGraph(layers));
%% Hyperparameters
options = trainingOptions('sgdm', ...
    'MaxEpochs',10,...
    'InitialLearnRate',1e-4, ...
    'Verbose',false, ...
    'Plots','training-progress');

%% Train
net = trainNetwork(train,layers,options);
%% Test on valid set
predictions = classify(net,valid);
labels = valid.Labels;
accuracy = sum(predictions == labels)/numel(labels)
%% Load test images
tinyMNIST_test = imageDatastore('TinyMNIST/test/', 'LabelSource', 'none', 'IncludeSubfolders',true);
predictions = classify(net,tinyMNIST);
%% 
submission=[]
for record=1:600
    filename=split(tinyMNIST_test.Files{record},'_'); % split string with _ delimiter
    filename=split(filename{2},'.'); % take second part of the string and split with . delimiter
    index = filename{1};
    submission = [submission; index, predictions(record)];
end
%%  open submission variable and copy it to excel
% add header 'id' and 'category' and save to csv file
openvar('submission')
% congratulations! now you can save the file