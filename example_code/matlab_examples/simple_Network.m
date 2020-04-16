% MSI TinyMNIST CHallenge 2020
% Agnieszka Miko³ajczyk
% Use "Run section" or "Run and Advance" option!
%% Load Dataset
clc, clear
% Load images
images=[];
labels=[];
idx=0
disp('Loading...')
for folder=1:10
    directory="TinyMNIST/train/"+(folder-1);
    fileList = fullfile(directory, '*.jpg');
    jpegFiles = dir(fileList);
    folder
    for image=1:size(jpegFiles,1)
        idx=idx+1;
        % consider resizing images to a smaller size
        % resize it here, before reshaping 
        images = [images,reshape(imread(fullfile(jpegFiles(image).folder,jpegFiles(image).name)),28*28,[])]; 
        % reshape image from 28x28 to a single vector 28*28 = 784
        labels(idx)=folder;
    end
    
end
images=double(images); %convert it to double so we can use nftool
clear jpegFiles image idx folder fileList directory
%% Network architecture
nftool
% generate your own network with: APPS -> Neural Net Fitting. (or type nftool) 
% windows pops click "Next"
% Load "images" as inputs and "labels" as Targets
% go next, select parameters as you wish
% train algorithm with "Train" button
% after traning click "Next" few times to the last page
% select "Simple Script" or "Advanced Script"
% copy code here



% YOUR CODE







%% Calculate accuracy
predictions = xxx; 
labels = xxx
accuracy = sum(predictions == labels)/numel(labels)
%% Load test images
folder=[]
images=[];
filenames=[];
labels=[];
idx=0
disp('Loading...')
directory="TinyMNIST/test/test/";
fileList = fullfile(directory, '*.jpg');
tinyMNIST_test = dir(fileList);
for image=1:size(tinyMNIST_test,1)
    idx=idx+1;
    images = [images,reshape(imread(fullfile(tinyMNIST_test(image).folder,tinyMNIST_test(image).name)),28*28,[])];

end
  
images=double(images); %convert it to double so we can use nftool
clear directory fileList filenames folder idx image labels
%% Predict for test data

predictions = net(images) % net - your network

%% Prepare submission file
submission=[]
for record=1:600
    filename=split(tinyMNIST_test(record).name,'_'); % split string with _ delimiter
    filename=split(filename{2},'.'); % take second part of the string and split with . delimiter
    index = str2double(filename{1});
    submission = [submission; index, round(predictions(record))];
end
%%  open submission variable and copy it to excel
% add header 'id' and 'category' and save to csv file
openvar('submission')
% congratulations! now you can save the file
