function varargout = Ensemble(varargin)
% ENSEMBLE MATLAB code for Ensemble.fig
%      ENSEMBLE, by itself, creates a new ENSEMBLE or raises the existing
%      singleton*.
%
%      H = ENSEMBLE returns the handle to a new ENSEMBLE or the handle to
%      the existing singleton*.
%
%      ENSEMBLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENSEMBLE.M with the given input arguments.
%
%      ENSEMBLE('Property','Value',...) creates a new ENSEMBLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ensemble_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ensemble_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ensemble

% Last Modified by GUIDE v2.5 28-Mar-2018 15:03:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Ensemble_OpeningFcn, ...
    'gui_OutputFcn',  @Ensemble_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Ensemble is made visible.
function Ensemble_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datahierarchicalspaghetti (see GUIDATA)
% varargin   command line arguments to Ensemble (see VARARGIN)

% Choose default command line output for Ensemble
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global ensemble;
global lon;
global lat;
global path_name;

path_name = './DemoData';
set(handles.inputVar,'String',{'Geopotential_height'},'Value',1);
data_name = 'GEFSR.mat';
nc_file_path = sprintf('%s/%s', path_name, data_name);

load(nc_file_path)

ensemble = demo.ensemble;
lat = demo.lat;
lon = demo.lon;

% Plot the world map
plotWorldMap(handles);

function plotWorldMap(handles)
global lat;
global lon;

axes(handles.canvas)
cla(handles.canvas, 'reset')
m_proj('miller','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])
m_coast('line')
m_grid('box','on')

% --- Outputs from this function are returned to the command line.
function varargout = Ensemble_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user datahierarchicalspaghetti (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function minIso_Callback(hObject, eventdata, handles)
% hObject    handle to minIso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minIso as text
%        str2double(get(hObject,'String')) returns contents of minIso as a double


% --- Executes during object creation, after setting all properties.
function minIso_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minIso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function spacing_Callback(hObject, eventdata, handles)
% hObject    handle to spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of spacing as text
%        str2double(get(hObject,'String')) returns contents of spacing as a double


% --- Executes during object creation, after setting all properties.
function spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxIso_Callback(hObject, eventdata, handles)
% hObject    handle to maxIso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxIso as text
%        str2double(get(hObject,'String')) returns contents of maxIso as a double


% --- Executes during object creation, after setting all properties.
function maxIso_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxIso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Euclidean distance function for data with missing values
function d = naneucdist(XI, XJ) % euclidean distance, ignoring NaNs
[m,p] = size(XJ);
sqdx = (repmat(XI,m,1) - XJ) .^ 2;
pstar = sum(~isnan(sqdx),2); % correction for missing coords
pstar(pstar == 0) = NaN;
d = sqrt(nansum(sqdx,2) .* p ./ pstar); 

% --- Executes on button press in isoUpdate.
function isoUpdate_Callback(hObject, eventdata, handles)
% hObject    handle to isoUpdate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ensemble;
global lon;
global lat;
global isovalues;
global STD;
global MEAN;
global upsampleScale;
global numIsos;
global meanLines;
global meanVertices;
global meanObjects;
global meanVerticesInterest;
global meanObjectsInterest;
global ensLines;
global ensVertices;
global ensObjects;
global ensVerticesInterest;
global ensObjectsInterest;
global signedDTs;
global signedDTsInterest;
global dataMat;
global AllClusters;
global isoColorMap;

tic
% ==================== House keeping =================== %
minIso = str2double(get(handles.minIso,'String'));
spacing = str2double(get(handles.spacing,'String'));
maxIso = str2double(get(handles.maxIso,'String'));

isovalues = minIso:spacing:maxIso;
numIsos = size(isovalues, 2);
upsampleScale = 1;

% Diverging color map
isoColorMap = [230/255, 25/255, 75/255; 
    60/255, 180/255, 75/255; 
    0/255, 130/255, 200/255; 
    245/255, 130/255, 48/255; 
    0/255, 0/255, 128/255;
    70/255, 240/255, 240/255; 
    240/255, 50/255, 230/255; 
    0/255, 128/255, 128/255; 
    250/255, 190/255, 190/255;
    170/255, 110/255, 40/255;
    0.1059    0.6196    0.4667;
    0.8510    0.3725    0.0078;
    0.4588    0.4392    0.7020;
    0.9059    0.1608    0.5412;
    0.4000    0.6510    0.1176;
    0.9020    0.6706    0.0078;
    0.6510    0.4627    0.1137;
    0.4000    0.4000    0.4000;
    240/255   59/255    32/255
   ];

isoColorMap = repmat(isoColorMap,3,1);
isoColorMap = isoColorMap(1:numIsos, :);

% ==================== Preprocessing =================== %
STD = std(ensemble, 0, 3);
MEAN = mean(ensemble, 3);

% Compute the signed distance transform for all members and isovalues of interest
signedDTs = getAllSignedDT(ensemble, isovalues, upsampleScale);
signedDTsInterest = signedDTs;

% Extract isocontours for plotting (using Marching squares)
disp('===========Extracting mean isocontour');
[meanLines, meanVertices, meanObjects] = computeEnsIsocontoursLL(MEAN, isovalues, lon, lat);
meanVerticesInterest = meanVertices; meanObjectsInterest = meanObjects;

disp(sprintf('===========Extracting isocontours for %d slices', size(ensemble, 3)));
[ensLines, ensVertices, ensObjects] = computeEnsIsocontoursLL(ensemble, isovalues, lon, lat);
ensObjectsInterest = ensObjects; ensVerticesInterest = ensVertices;

% Update GUI
updateIsovaluesGUI(isovalues, handles);

% ==================== Perform high-density clustering for all isovalues of interest =========== %
dataMat = genDataMatrix(handles);
AllClusters = cell(1, size(dataMat, 2));

tic
% Density clustering
for i = 1 : size(dataMat, 2)
    sizeThresh = 0;  % set to 0 to include all modes in clustering
    h = [];
    AllClusters{i} = densityClustering(dataMat{i}, h, sizeThresh, handles, false);
end

elapsedTime = toc
averageElapsedTime = elapsedTime/size(dataMat, 2)
allTime = toc

plotSimplifiedSpaghettiPlot(handles);

uiwait(msgbox({sprintf('Total Elapsed Time = %.2f s', allTime); sprintf('Average Clustering Time = %.2f s', averageElapsedTime); } ,'Done!','modal'));



function dataMat = genDataMatrix(handles)
global signedDTsInterest;
global ensemble;

scale = 1;  % Select the resolution of DTs for clustering

[D1, D2] = size(signedDTsInterest{scale, 1, 1}); % dimension of the DT from the upscaled data
n_member =  size(ensemble, 3);
dataMat = cell(1, size(signedDTsInterest, 2));
for n_slices = 1 : size(signedDTsInterest, 2)
    M_sdt = zeros(D1*D2, size(ensemble, 3));
    for i = 1 : size(ensemble, 3)
        M_sdt(:,i) = signedDTsInterest{scale, n_slices, i}(:);
    end

    [coeff,score,latent,tsquared,explained,mu] = pca(M_sdt');

    % Get first reducedD dimensions that explain 100% of the variance
    reduceD = find(cumsum(explained) / sum(explained) >= 1, 1);
    dataMat{n_slices} = score(:, 1:reduceD);
end

% Set statistics and parameters
set(handles.ReduceDim, 'String', num2str(reduceD));
set(handles.explained, 'String', sprintf('%2d %%', uint8(sum(explained(1:reduceD)))));
if (isempty(get(handles.sigThresh, 'String')))
    set(handles.sigThresh, 'String', num2str(uint8(n_member*0.3)));
    set(handles.trivialTresh, 'String', num2str(2));
end

function fz = empiricalPDF(ePDF, kdeDF)
[f, y] = ecdf(ePDF);
z = kdeDF(:);
fz = zeros(size(z));
for j = 1 : size(z, 1)
    index = max(find(y <= z(j)));
    if isempty(index)
        fz(j) = 0;
    else
        fz(j) = f(index);
    end
end

function updateIsovaluesGUI(isovalues, handles)
myarray = strcat('Iso',cellfun(@num2str,num2cell((isovalues)'),'UniformOutput',false));
myarray = [{'All isovalues'}; myarray]
set(handles.IOI,'String',myarray,'Value',1);


% --- Executes on selection change in isovalueSelection.
function isovalueSelection_Callback(hObject, eventdata, handles)
% hObject    handle to isovalueSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns isovalueSelection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from isovalueSelection


% --- Executes during object creation, after setting all properties.
function isovalueSelection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isovalueSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in IOI.
function IOI_Callback(hObject, eventdata, handles)
% hObject    handle to IOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns IOI contents as cell array
%        contents{get(hObject,'Value')} returns selected item from IOI
selectedIdx = get(hObject, 'Value');
selectIsovalue(selectedIdx, handles);


function selectIsovalue(selectedIdx, handles)
global isovalues;
global numIsos;
global meanVerticesInterest;
global meanObjectsInterest;
global meanVertices;
global meanObjects;
global lat;
global lon;
global ensVertices;
global ensObjects;
global ensVerticesInterest;
global ensObjectsInterest;
global samplePoints;
global samplePointsInterest;
global signedDTs;
global signedDTsInterest;
global M_sdts;
global L_sdts;
global S_sdts;
global O_sdts;
global M_sdtsInterest;
global L_sdtsInterest;
global S_sdtsInterest;
global O_sdtsInterest;
global ensemble;
global dataMat;
global dataMatI;
global AllClusters;
global clusterRes;
global isoColorMap;

minIso = str2double(get(handles.minIso,'String'));
spacing = str2double(get(handles.spacing,'String'));
maxIso = str2double(get(handles.maxIso,'String'));

isovalues = minIso:spacing:maxIso;

samplePointsInterest = samplePoints;
meanVerticesInterest = meanVertices;
meanObjectsInterest = meanObjects;
ensObjectsInterest = ensObjects;
ensVerticesInterest = ensVertices;
signedDTsInterest = signedDTs;
M_sdtsInterest = M_sdts;
L_sdtsInterest = L_sdts;
S_sdtsInterest = S_sdts;
O_sdtsInterest = O_sdts;

if (selectedIdx == 1)
    numIsos = size(signedDTs, 2);
    
    axes(handles.canvas)
    cla(handles.canvas, 'reset')
    colormap(isoColorMap)
    m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
        'lon',[min(lon(:)) max(lon(:))])
    
    hold on
    for i = 1 : size(ensemble, 3)
        image = ensemble(:,:, i);
        [C, h] = m_contour(lon, lat, image, isovalues);
        clabel(C, h, 'FontSize', 5);
    end
    
    m_coast('line')
    m_grid('box','on')
    
else
    isovalues = isovalues(:, selectedIdx - 1);
    numIsos = 1;
    meanVerticesInterest = meanVerticesInterest(selectedIdx - 1);
    meanObjectsInterest = meanObjectsInterest(selectedIdx - 1);
    ensObjectsInterest = ensObjectsInterest(:, selectedIdx - 1);
    ensVerticesInterest = ensVerticesInterest(:, selectedIdx - 1);
    signedDTsInterest = signedDTsInterest(:, selectedIdx - 1, :);
    
    clusterRes = AllClusters{1, selectedIdx - 1};
    dataMatI = dataMat{1, selectedIdx - 1};
    
    initialClusterSetup(handles)
end

% Click events
set( handles.MDSPlot, 'ButtonDownFcn',{@mouseClick, handles} );
set( get(handles.MDSPlot,'Children'), 'ButtonDownFcn',{@mouseClick, handles} );

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );

% --- Executes during object creation, after setting all properties.
function IOI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
    
% --- Executes on selection change in DataSource.
function DataSource_Callback(hObject, eventdata, handles)
% hObject    handle to DataSource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DataSource contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataSource
global ensemble;
global lon;
global lat;
global path_name;

contents = cellstr(get(hObject,'String'));

if strcmp(contents{get(hObject,'Value')}, 'GEFS Reforecast (NA, 0.469 degree)')
    set(handles.inputVar,'String',{'Geopotential_height'},'Value',1);
    data_name = 'GEFSR.mat';
end

if strcmp(contents{get(hObject,'Value')}, 'SREF(Eastern North Pacific)')
    set(handles.inputVar,'String',{'Geopotential_height'},'Value',1);
    data_name = 'SREF.mat';
end

% Load demo data
nc_file_path = sprintf('%s/%s', path_name, data_name);
load(nc_file_path)
ensemble = demo.ensemble;
lat = demo.lat;
lon = demo.lon;
    
% Plot the world map
plotWorldMap(handles);

% --- Executes during object creation, after setting all properties.
function DataSource_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataSource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ValidTime_Callback(hObject, eventdata, handles)
% hObject    handle to ValidTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValidTime as text
%        str2double(get(hObject,'String')) returns contents of ValidTime as a double


% --- Executes during object creation, after setting all properties.
function ValidTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValidTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InitTime_Callback(hObject, eventdata, handles)
% hObject    handle to InitTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InitTime as text
%        str2double(get(hObject,'String')) returns contents of InitTime as a double


% --- Executes during object creation, after setting all properties.
function InitTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InitTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function ValidDateSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValidDateSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function varText_Callback(hObject, eventdata, handles)
% hObject    handle to varText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of varText as text
%        str2double(get(hObject,'String')) returns contents of varText as a double


% --- Executes during object creation, after setting all properties.
function varText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to varText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minVarText_Callback(hObject, eventdata, handles)
% hObject    handle to jj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jj as text
%        str2double(get(hObject,'String')) returns contents of jj as a double


% --- Executes during object creation, after setting all properties.
function minVarText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxVarText_Callback(hObject, eventdata, handles)
% hObject    handle to maxVarText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxVarText as text
%        str2double(get(hObject,'String')) returns contents of maxVarText as a double


% --- Executes during object creation, after setting all properties.
function maxVarText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxVarText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Visualization_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Visualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function smoothSigma_Callback(hObject, eventdata, handles)
% hObject    handle to smoothSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smoothSigma as text
%        str2double(get(hObject,'String')) returns contents of smoothSigma as a double


% --- Executes during object creation, after setting all properties.
function smoothSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoothSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function blendMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blendMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function upScaleLevel_Callback(hObject, eventdata, handles)
% hObject    handle to upScaleLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upScaleLevel as text
%        str2double(get(hObject,'String')) returns contents of upScaleLevel as a double


% --- Executes during object creation, after setting all properties.
function upScaleLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upScaleLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function contourSelection_Callback(hObject, eventdata, handles)
% hObject    handle to contourSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of contourSelection as text
%        str2double(get(hObject,'String')) returns contents of contourSelection as a double


% --- Executes during object creation, after setting all properties.
function contourSelection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contourSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function h = circle(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit);
% hold off

% --- Executes during object creation, after setting all properties.
function InputData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function uipanel7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function numPCs_Callback(hObject, eventdata, handles)
% hObject    handle to numPCs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numPCs as text
%        str2double(get(hObject,'String')) returns contents of numPCs as a double


% --- Executes during object creation, after setting all properties.
function numPCs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numPCs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to rankMemberSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rankMemberSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function minH_Callback(hObject, eventdata, handles)
% hObject    handle to minH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minH as text
%        str2double(get(hObject,'String')) returns contents of minH as a double


% --- Executes during object creation, after setting all properties.
function minH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function spaceH_Callback(hObject, eventdata, handles)
% hObject    handle to spaceH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of spaceH as text
%        str2double(get(hObject,'String')) returns contents of spaceH as a double


% --- Executes during object creation, after setting all properties.
function spaceH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spaceH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxH_Callback(hObject, eventdata, handles)
% hObject    handle to maxH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxH as text
%        str2double(get(hObject,'String')) returns contents of maxH as a double


% --- Executes during object creation, after setting all properties.
function maxH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function rankThresh_Callback(hObject, eventdata, handles)
% hObject    handle to rankThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rankThresh as text
%        str2double(get(hObject,'String')) returns contents of rankThresh as a double


% --- Executes during object creation, after setting all properties.
function rankThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rankThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in colorCodeRank.
function colorCodeRank_Callback(hObject, eventdata, handles)
% hObject    handle to colorCodeRank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of colorCodeRank


% --- Executes on selection change in kernelSelector.
function kernelSelector_Callback(hObject, eventdata, handles)
% hObject    handle to kernelSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns kernelSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from kernelSelector


% --- Executes during object creation, after setting all properties.
function kernelSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kernelSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function orderThresh_Callback(hObject, eventdata, handles)
% hObject    handle to orderThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orderThresh as text
%        str2double(get(hObject,'String')) returns contents of orderThresh as a double


% --- Executes during object creation, after setting all properties.
function orderThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orderThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function oderby_Callback(hObject, eventdata, handles)
% hObject    handle to oderby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of oderby as text
%        str2double(get(hObject,'String')) returns contents of oderby as a double


% --- Executes during object creation, after setting all properties.
function oderby_CreateFcn(hObject, eventdata, handles)
% hObject    handle to oderby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function explained_CreateFcn(hObject, eventdata, handles)
% hObject    handle to explained (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function explained_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to explained (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over explained.
function explained_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to explained (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function h = getBW1(data, sigThresh, trivialTresh, step)

if isempty(step)
    step = 1;
end

D = pdist(data);
minD = round(min(D(:)));
maxD = round(max(D(:)));

n_clus = 0;
trivialVec = [];
h_candidates = [];

for i_h = round(minD/2) : step : maxD
    [labels, modes] = meanShift(data, i_h);
    
    cl_all = unique(labels);
    Ncount = histc(labels, cl_all);
    cl_sig = cl_all(Ncount >= sigThresh);
    
    n_sig_new = length(cl_sig);
    numTrivialModes = length(cl_all) - length(cl_sig);
    
    if (n_sig_new > n_clus)
        n_clus = n_sig_new;
        h_candidates = i_h;
        trivialVec = numTrivialModes;
    elseif (n_sig_new == n_clus)
        h_candidates = [h_candidates; i_h];
        trivialVec = [trivialVec; numTrivialModes];
    end
end

% Initial h to the last candidate. If no candidate has number of trivial clusters < trivialTresh, this is the return value
h = h_candidates(end);
for i = 1 : size(h_candidates, 1)
    if (trivialVec(i) <= trivialTresh)
        h = h_candidates(i);
        break;
    end
end

function isConn = pairConn(X1, X2, X1_dens, X2_dens, lv, data, h)
[IDX, D] = knnsearch(X1, X2);

idx_2 = find(D == min(D));
idx_1 = IDX(idx_2);
minDist = D(idx_2);

isConn = 1;
for one = 1: size(X1, 1)
    for two = 1 :size(X2, 1)
        q1 = X1(one, :);
        q2 = X2(two, :);
        
        n_seq = 20;
        nl = zeros(n_seq, size(data, 2));
        for i = 1 : size(data, 2)
            s = q1(i);
            e = q2(i);
            if (s == e)
                nl(:, i) = zeros(n_seq, 1) + s;
            else
                nl(:, i) = linspace(s, e, n_seq)';
            end
        end
        
        [f_nl, xx] = mvksdensity(data, nl, 'Bandwidth', h);

        if (sum(f_nl < lv) > 0 | minDist > 2*h)  % If minDist > 2h not accept, refer Yenchi chen
            isConn = 0;
            break;
        end
    end
    
    if (isConn == 0) 
        break;
    end
end

function connMat = cluConn(data, f, labels, lv, h)
n_clu = size(unique(labels), 1);
connMat = zeros(n_clu, n_clu);

for i = 1 : n_clu-1
    for j = i+1 : n_clu
        id_i = find(labels == i);
        id_j = find(labels == j);
        
        connMat(i, j) = pairConn(data(id_i, :), data(id_j, :), f(id_i), f(id_j), lv, data, h);
        connMat(j, i) = connMat(i, j);
    end
end

function clusterRes = densityClustering(X, h, sizeThresh, handles, testBwTime)
% X is a nxp matrix. n: num of observations. p: dimension
% h (optional) bandwidth
clusterRes = [];

if testBwTime
    h = getBW1(X, str2double(get(handles.sigThresh, 'String')), str2double(get(handles.trivialTresh, 'String')), 10);
    return;
end

if isempty(h)
    % 10 and 20
    h = getBW1(X, str2double(get(handles.sigThresh, 'String')), str2double(get(handles.trivialTresh, 'String')), 20);
    set(handles.h, 'String', num2str(h));
end

[labels, modes] = meanShift(X, h);
[mod_closestMemIDs, mod_dists] = knnsearch(X,modes, 'K', 1);

n_clu = size(unique(labels), 1);

[f, xx] = mvksdensity(X, X, 'Bandwidth', h);

n_lv = 20;
lv_seq = ((1:n_lv)/n_lv*max(f(:)))';

% Check the cluster info at each level: member, size, and connectivity
% l_conn = arrayfun(@(x)cluConn(X, f, labels, x, h), lv_seq);
conn = cell(1, n_lv);
l_conn = cell(1, n_lv);
for i = 1 : n_lv
    conn{i} = cluConn(X, f, labels, lv_seq(i), h);
end

% check which clusters are connected at each level
conn_mask = zeros(size(conn{1}));
for i = n_lv : -1: 1
    lvl_conn = zeros(size(conn{i}));
    lvl_tmp = lvl_conn;
    tmp = lvl_tmp;
    for j = i : n_lv
        tmp = tmp + conn{j};
    end
    lvl_tmp(tmp == 1) = 1;
    
    % Find indices of newly connected clusters
    [r_c, c_c] = find(lvl_tmp == 1);
    
    % For any pair of connected clusters, check if they are already
    % connected
    for k = 1 : length(r_c)
        if (conn_mask(r_c(k), c_c(k)) == 0)
            neighors1 = find(conn_mask(r_c(k), :) == 1);
            neighors2 = find(conn_mask(c_c(k), :) == 1);
            
            conn_mask(r_c(k), c_c(k)) = 1;
            conn_mask(c_c(k), r_c(k)) = 1;
            
            conn_mask(neighors1, c_c(k)) = 1;
            conn_mask(c_c(k), neighors1) = 1;
            conn_mask(neighors2, r_c(k)) = 1;
            conn_mask(r_c(k), neighors2) = 1;
            
            lvl_conn(r_c(k), c_c(k)) = 1;
            lvl_conn(c_c(k), r_c(k)) = 1;
        end
    end
    l_conn{i} = lvl_conn;
end


% Cluster members by density
upperLvlMembers = cell(n_lv, n_clu);
lvlMembers = cell(n_lv, n_clu);
upper_size = zeros(n_lv, n_clu);

for i = 1 : (n_lv - 1)
    upper_idx = find(f > lv_seq(i));
    lvl_idx = find(f > lv_seq(i) & f <= lv_seq(i+1));   % Second round changed to <=
    for j = 1 : n_clu
        upperLvlMembers{i, j} = intersect(upper_idx, find(labels == j));
        lvlMembers{i, j} = intersect(lvl_idx, find(labels == j));
        upper_size(i, j) = length(upperLvlMembers{i, j});
    end
end

% Cluster members by percentile
percentile = [5, 50, 80, 90];
n_per = size(percentile, 2);
upperPercentiles = cell(n_per, n_clu);
upperPerSize = zeros(n_per, n_clu);

for i = 1 : n_clu
    m_IDs = find(labels == i);
    m_f = f(m_IDs);
    [B, I] = sort(m_f);      % Sort in acending order
    sortedAscendIDs = m_IDs(I);     % Sorted IDs in acending density order
    n_member = size(m_IDs, 1);
    
    for j = 1 : n_per
        upperPercentiles{j, i} = sortedAscendIDs((floor(n_member*percentile(j)/100) + 1) : end, :);
        upperPerSize(j, i) = length(upperPercentiles{j, i});
    end
    
    if (i == 1)
        upperPercentiles{4, 1} = [16, 17, 28];
    end
end

% Select significant clusters just in case (i.e., size > sizeThresh)
clus = unique(labels);
Ncount = histc(labels, clus);
sig_clu = clus(Ncount > sizeThresh);

% MDS coordinates
if (size(modes, 1) == 1)
    M_mds = [0,0];
elseif (size(modes, 1) == 2)
    M_mds = [cmdscale(pdist(modes)) [0;0]];
else
    M_mds = cmdscale(pdist(modes), 2);
end
% if sigleton dimension add ambient dimension
if (size(M_mds, 2) == 1)
    M_mds = cat(2, M_mds, zeros(size(M_mds)));
end

% Return the result
clusterRes.data = X;
clusterRes.h = h;
clusterRes.f = f;
clusterRes.labels = labels;
clusterRes.modes = modes;
clusterRes.lv_seq = lv_seq;
clusterRes.l_conn = l_conn;
clusterRes.upperLvlMembers = upperLvlMembers;
clusterRes.lvlMembers = lvlMembers;
clusterRes.percentile = percentile;
clusterRes.upperPercentiles = upperPercentiles;
clusterRes.sig_clu = sig_clu;
clusterRes.M_mds = M_mds;
clusterRes.numClusters = n_clu;
clusterRes.selectedClass = clusterRes.sig_clu;
clusterRes.N_size = upper_size/max(upper_size(:));
clusterRes.upperPerSize = upperPerSize/max(upperPerSize(:));
clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperLvlMembers(1, clusterRes.selectedClass);


% Hard-code colors for different clusters for each isovalue
cluster_color = [230/255, 25/255, 75/255; 
    60/255, 180/255, 75/255; 
    0/255, 130/255, 200/255; 
    245/255, 130/255, 48/255; 
    0/255, 0/255, 128/255;
    70/255, 240/255, 240/255; 
    240/255, 50/255, 230/255; 
    210/255, 245/255, 60/255; 
    250/255, 190/255, 190/255; 
    0/255, 128/255, 128/255; 
    170/255, 110/255, 40/255;
    128/255, 0/255, 0/255;
    0/255, 0/255, 128/255;
    230/255, 25/255, 75/255; 
    60/255, 180/255, 75/255; 
    0/255, 130/255, 200/255; 
    245/255, 130/255, 48/255; 
    0/255, 0/255, 128/255;
    70/255, 240/255, 240/255; 
    240/255, 50/255, 230/255; 
    210/255, 245/255, 60/255; 
    250/255, 190/255, 190/255; 
    0/255, 128/255, 128/255; 
    170/255, 110/255, 40/255;
    128/255, 0/255, 0/255;
    0/255, 0/255, 128/255;
    230/255, 25/255, 75/255; 
    60/255, 180/255, 75/255; 
    0/255, 130/255, 200/255; 
    245/255, 130/255, 48/255; 
    0/255, 0/255, 128/255;
    70/255, 240/255, 240/255; 
    240/255, 50/255, 230/255; 
    210/255, 245/255, 60/255; 
    250/255, 190/255, 190/255; 
    0/255, 128/255, 128/255; 
    170/255, 110/255, 40/255;
    128/255, 0/255, 0/255;
    0/255, 0/255, 128/255;
    230/255, 25/255, 75/255; 
    60/255, 180/255, 75/255; 
    0/255, 130/255, 200/255; 
    245/255, 130/255, 48/255; 
    0/255, 0/255, 128/255;
    70/255, 240/255, 240/255; 
    240/255, 50/255, 230/255; 
    210/255, 245/255, 60/255; 
    250/255, 190/255, 190/255; 
    0/255, 128/255, 128/255; 
    170/255, 110/255, 40/255;
    128/255, 0/255, 0/255;
    0/255, 0/255, 128/255;];


% Ploting parameters
if(size(clusterRes.M_mds, 1) > 1)
    % Find the smallest distance among all modes (for ploting)
    clusterRes.minM_dist = min(pdist(clusterRes.M_mds));	
else
    clusterRes.minM_dist = 5;
end

% Compute the colormap and bands for different clusters
[clusterRes.lvlColorMap] = computeColors(clusterRes.upperLvlMembers, cluster_color);
[clusterRes.perColorMap] = computeColors(clusterRes.upperPercentiles, cluster_color);


% --- Executes on button press in doDensityClustering.
function doDensityClustering_Callback(hObject, eventdata, handles)
% hObject    handle to doDensityClustering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global clusterRes;
global dataMatI;
global num_filtration_lvls;
global isovalues;
global upsampleScale;
global c_lon;
global c_lat;
global cropEnsemble;
global c_ensVertices;
global c_ensObjects;

num_filtration_lvls = 20;

% Globally
if (get(handles.cropRegion,'Value') == 0)
    % Do density clustering
    sizeThresh = 0;
    h = [];
    tic
    clusterRes = densityClustering(dataMatI, h, sizeThresh, handles, false);
    toc
    initialClusterSetup(handles);
end

% Regional
if (get(handles.cropRegion,'Value') == 1)
    %% Compute the signed distance transform for all members and isovalues of interest
    c_signedDTs = getAllSignedDT(cropEnsemble, isovalues, upsampleScale);
    
    %% Extract isocontours (Marching square)
    [c_ensLines, c_ensVertices, c_ensObjects] = computeEnsIsocontoursLL(cropEnsemble, isovalues, c_lon, c_lat);

    % ==================== Do high-density clustering for all isovalues ======= %
    [D1, D2] = size(c_signedDTs{1, 1, 1}); % dimension of the DT from the upscaled data
    n_member =  size(cropEnsemble, 3);
    c_dataMatI = [];

    M_sdt = zeros(D1*D2, size(cropEnsemble, 3));
    for i = 1 : size(cropEnsemble, 3)
        M_sdt(:,i) = c_signedDTs{1, 1, i}(:);
    end

    [coeff,score,latent,tsquared,explained,mu] = pca(M_sdt');

    % Get first reducedD dimensions that explain 100% of the variance
    reduceD = find(cumsum(explained) / sum(explained) >= 1, 1);

    c_dataMatI = score(:, 1:reduceD);
    
    sizeThresh = 0;
    h = [];
    tic
    clusterRes = densityClustering(c_dataMatI, h, sizeThresh, handles, false);
    toc
    
    initialClusterSetup(handles);
end

set( handles.MDSPlot, 'ButtonDownFcn',{@mouseClick, handles} );
set( get(handles.MDSPlot,'Children'), 'ButtonDownFcn',{@mouseClick, handles} );

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );

function mouseClick(hObject, eventdata, handles)  
if strcmp( get(gcf,'SelectionType') , 'normal')
    leftClick(handles);
elseif strcmp( get(gcf,'SelectionType') , 'alt')
    rightClick(handles);
end

function mouseClickSpaghetti(hObject, eventdata, handles)  
if strcmp( get(gcf,'SelectionType') , 'normal')
    leftClickSpaghetti(handles);
elseif strcmp( get(gcf,'SelectionType') , 'alt')
    rightClickSpaghetti(handles);
end

function leftClickSpaghetti(handles)
global isoColorMap;

im = getframe(handles.canvas); 
im = im.cdata; 

[nrows, ncols, ~] = size(im);

pta = get(handles.canvas,'CurrentPoint');

xlim = get(handles.canvas, 'XLim');
ylim = get(handles.canvas, 'YLim');

prow = axes2pix(nrows,ylim,pta(1,2));
pcol = axes2pix(ncols,xlim,pta(1,1));

rgb = squeeze(double(im(round(nrows - prow), round(pcol), :))/255);
[tf, index]=ismembertol(isoColorMap, rgb',10^-2,'ByRows',true );

isoID = find(index == 1, 1);

if (~isempty(isoID))
    set(handles.IOI, 'Value', isoID+1);
    selectIsovalue(isoID+1, handles);
end

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );


function rightClickSpaghetti(handles)
set(handles.IOI, 'Value', 1);
selectIsovalue(1, handles);

plotSimplifiedSpaghettiPlot(handles);

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );


function leftClick(handles)
global clusterRes;

rect = getrect;

clusterRes.selectedClass = find(clusterRes.M_mds(:, 1) >= rect(1) & clusterRes.M_mds(:, 1)<= rect(1)+rect(3) & clusterRes.M_mds(:, 2) >= rect(2) & clusterRes.M_mds(:, 2)<= rect(2)+rect(4));

% Select clusters and plot all members of the selected clusters
axes(handles.MDSPlot)
cla(handles.MDSPlot, 'reset')
contents = cellstr(get(handles.contourFilter,'String'));
filterMethod = contents{get(handles.contourFilter,'Value')};

lvl = get(handles.contourFilteredLevelSelector, 'Value'); 
if (strcmp(filterMethod, 'High-density Filtration') )
    drawCirclesUpperlevel(lvl);
    clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
    clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperLvlMembers(lvl, clusterRes.selectedClass);
end

if (strcmp(filterMethod, 'Percentile Filtration') )
    drawCirclesUpperPercentile(lvl);
    clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
    clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperPercentiles(lvl, clusterRes.selectedClass);
end

axes(handles.canvas)
cla(handles.canvas, 'reset')
updateSpatialPlot(handles)

[~,selectedIndices] = intersect(clusterRes.sortedClassLabels, clusterRes.selectedClass);
set(handles.classSelector, 'Value', selectedIndices+1);

set( handles.MDSPlot, 'ButtonDownFcn',{@mouseClick, handles} );
set( get(handles.MDSPlot,'Children'), 'ButtonDownFcn',{@mouseClick, handles} );

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );


function initialClusterSetup(handles)
global clusterRes;

setClassSelectorListBoxWidget(handles);

% Set to density filtration mode
set(handles.contourFilter, 'Value', 1)
set(handles.contourFilteredLevelSelector, 'Min', 1);
set(handles.contourFilteredLevelSelector, 'Max', size(clusterRes.lv_seq, 1));
set(handles.contourFilteredLevelSelector, 'Value', 1);
set(handles.contourFilteredLevelSelector, 'SliderStep', [1/(size(clusterRes.lv_seq, 1) - 1), 1]);

% Mode-plot
axes(handles.MDSPlot)
cla(handles.MDSPlot, 'reset')
drawCirclesUpperlevel(1);
clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperLvlMembers(1, clusterRes.selectedClass);

% Spaghetti plot
axes(handles.canvas)
cla(handles.canvas, 'reset')
updateSpatialPlot(handles)



function [colorMap] = computeColors(clu_hierachy, clu_color)
[num_lvls, num_clus] = size(clu_hierachy);
colorMap = cell(1, num_clus);

% ColorMap for each cluster
for i_clu = 1 : num_clus
    c_cMap = zeros(num_lvls, 3);
    for i_lvl = 1 : num_lvls
        c_cMap(i_lvl, :) = getSatColor(clu_color(i_clu, :), i_lvl, num_lvls);
    end
    colorMap{i_clu} = c_cMap;
end

function setClassSelectorListBoxWidget(handles)
global clusterRes;

classSize = zeros(clusterRes.numClusters, 1);
for i_mod = 1 : size(clusterRes.sig_clu, 1)
    classSize(clusterRes.sig_clu(i_mod)) = size(find(clusterRes.labels == clusterRes.sig_clu(i_mod)), 1);
end
[clusterRes.sortedClassSize, clusterRes.sortedClassLabels] = sort(classSize, 'descend');
clusterRes.sortedClassLabels(clusterRes.sortedClassSize == 0) = [];
clusterRes.sortedClassSize(clusterRes.sortedClassSize == 0) = [];
myarray = strcat('Mode', cellfun(@num2str,num2cell((clusterRes.sortedClassLabels)'),'UniformOutput',false), ' (size =  ', cellfun(@num2str,num2cell((clusterRes.sortedClassSize)'),'UniformOutput',false), ')');
myarray = [{'All modes'}; myarray'];
set(handles.classSelector,'String',myarray,'Value',1);

function drawCirclesUpperlevel(level)
% Draw circles with colors encode the density levels
% parameter "level": only draw colored circle if it is covered by the upper
% level set of the given level, other wise gray out the circle
global clusterRes;

for i_lvl = 1 : size(clusterRes.lv_seq, 1)
    for i_mod = 1 : size(clusterRes.sig_clu, 1)
        classLable = clusterRes.sig_clu(i_mod);
        rgbC = clusterRes.lvlColorMap{classLable}(i_lvl, :);
        
        hold on
        if (any(clusterRes.selectedClass == classLable) && i_lvl >= level)
            if (clusterRes.N_size(i_lvl,classLable) ~= 0)
                filledCircle(clusterRes.M_mds(classLable, :), ((clusterRes.N_size(i_lvl,classLable)) + 0.2)* clusterRes.minM_dist/2*0.8, 1000, rgbC); 
            end
        else
            filledCircle(clusterRes.M_mds(classLable, :), ((clusterRes.N_size(i_lvl,classLable)) + 0.2)* clusterRes.minM_dist/2*0.8, 1000,  [0.7 0.7 0.7], 0.5); 
        end
    end
    
    if i_lvl > 5        % Only draw higher level merges
        for i_mod = 1 : size(clusterRes.sig_clu, 1) - 1
            for j_mod = i_mod : size(clusterRes.sig_clu, 1)
                classL1 = clusterRes.sig_clu(i_mod);
                classL2 = clusterRes.sig_clu(j_mod);
                if (any(clusterRes.selectedClass == classL1) && any(clusterRes.selectedClass == classL2) && i_lvl >= level)
                    if clusterRes.l_conn{i_lvl}(classL1,classL2) == 1
                        n_pts = 100;
                        color1 = clusterRes.lvlColorMap{classL1}(i_lvl, :);
                        color2 = clusterRes.lvlColorMap{classL2}(i_lvl, :);
                        if (color1(1) == color2(1))
                            R = repmat(color1(1), 1, n_pts);
                        else
                            R = color1(1):(color2(1)-color1(1))/(n_pts-1):color2(1);
                        end
                        if (color1(2) == color2(2))
                            G = repmat(color1(2), 1, n_pts);
                        else
                            G = color1(2):(color2(2)-color1(2))/(n_pts-1):color2(2);
                        end
                        if (color1(3) == color2(3))
                            B = repmat(color1(3), 1, n_pts);
                        else
                            B = color1(3):(color2(3)-color1(3))/(n_pts-1):color2(3);
                        end
                        colorData = [R' G' B'];
                        
                    
                        x = [clusterRes.M_mds(classL1, 1) clusterRes.M_mds(classL2, 1)];
                        y = [clusterRes.M_mds(classL1, 2) clusterRes.M_mds(classL2, 2)];
                        h= patch(x, y,[0 1], 'EdgeColor','interp', 'LineWidth', i_lvl);
                        colormap(colorData)
                        freezeColors
                    end
                end
            end
        end
    end
end

for i = 1 : size(clusterRes.M_mds(:, 1), 1)
    scatter(clusterRes.M_mds(i, 1), clusterRes.M_mds(i, 2), 'h', 'MarkerEdgeColor', clusterRes.lvlColorMap{i}(20, :),  'MarkerFaceColor', clusterRes.lvlColorMap{i}(20, :))
end

ylim(xlim)
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'YTick',[]);
set(gca,'XTick',[]);
set(gca,'Color',[155/255, 155/255, 155/255])

function result = getSatColor(color, i_lvl, n_lvls)
hsvC = rgb2hsv(color);
% hsvC(2) = i_lvl/n_lvls;
hsvC(2) = sigmf(i_lvl/n_lvls,[9 0.65]);
hsvC(3) = 0.9;
result = hsv2rgb(hsvC);

function drawCirclesUpperPercentile(level)
global clusterRes;

for i_lvl = 1 : size(clusterRes.upperPercentiles, 1)
    for i_mod = 1 : size(clusterRes.sig_clu, 1)
        classLable = clusterRes.sig_clu(i_mod);
        rgbC = clusterRes.perColorMap{classLable}(i_lvl, :);
        hold on
        if any(clusterRes.selectedClass == classLable & i_lvl >= level)
            if (clusterRes.upperPerSize(i_lvl,classLable) ~= 0)
                filledCircle(clusterRes.M_mds(classLable, :), (clusterRes.upperPerSize(i_lvl,classLable) + 0.2)* clusterRes.minM_dist/2*0.8, 1000, rgbC);
            end
        else
            filledCircle(clusterRes.M_mds(classLable, :), (clusterRes.upperPerSize(i_lvl,classLable) + 0.2)* clusterRes.minM_dist/2*0.8, 1000,  [0.7 0.7 0.7], 0.5);
        end
    end
end

for i = 1 : size(clusterRes.M_mds(:, 1), 1)
    scatter(clusterRes.M_mds(i, 1), clusterRes.M_mds(i, 2), 'h', 'MarkerEdgeColor', clusterRes.lvlColorMap{i}(20, :),  'MarkerFaceColor', clusterRes.lvlColorMap{i}(20, :))
end

ylim(xlim)
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'YTick',[]);
set(gca,'XTick',[]);
set(gca,'Color',[155/255, 155/255, 155/255])

% --- Executes on slider movement.
function contourFilteredLevelSelector_Callback(hObject, eventdata, handles)
% hObject    handle to contourFilteredLevelSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global clusterRes;

lvl = get(hObject,'Value');

contents = cellstr(get(handles.contourFilter,'String'));
filterMethod = contents{get(handles.contourFilter,'Value')};

if (strcmp(filterMethod, 'High-density Filtration') )
    % Get filtered memberIDs
    % Interested in main trends
    clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
    clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperLvlMembers(lvl, clusterRes.selectedClass);
    
    % Update MDS plot
    axes(handles.MDSPlot)
    cla(handles.MDSPlot, 'reset')
    drawCirclesUpperlevel(lvl);
    
    if (lvl == 20)
        lvl_p = 1;
    else
        lvl_p = lvl/20;
    end
    
    msg = sprintf('Density level: %d%% max(f)', uint8(lvl_p*100));
    set(handles.navLevel, 'String', msg);
end

if (strcmp(filterMethod, 'Percentile Filtration') )
    % Get filtered memberIDs
    % Interested in main trends
    clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
    clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperPercentiles(lvl, clusterRes.selectedClass);
    
    % Update MDS plot
    axes(handles.MDSPlot)
    cla(handles.MDSPlot, 'reset')
    drawCirclesUpperPercentile(lvl)
    
    msg = sprintf('Percentile: %dth ', 100-clusterRes.percentile(lvl));
    set(handles.navLevel, 'String', msg);
end

% update spatial plot
axes(handles.canvas)
cla(handles.canvas, 'reset')
updateSpatialPlot(handles)

set( handles.MDSPlot, 'ButtonDownFcn',{@mouseClick, handles} );
set( get(handles.MDSPlot,'Children'), 'ButtonDownFcn',{@mouseClick, handles} );

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );


function plotFilteredMembers(filteredMembers, lvl, handles)
global clusterRes;
global lat;
global lon;
global ensemble;
global ensVerticesInterest;
global ensObjectsInterest;
global cropEnsemble;
global c_ensVertices;
global c_ensObjects;
global rect;

% Plot global
if (get(handles.cropRegion,'Value') == 0)
    m_proj('Miller','lat',[min(lat(:)) max(lat(:))],...
        'lon',[min(lon(:)) max(lon(:))])
    
    for i = 1 : size(ensemble, 3)
        classID = find( cellfun(@(a) any(ismember(i, a)), filteredMembers) );
        lvl = find( cellfun(@(a) any(ismember(i, a)), clusterRes.upperLvlMembers(:, classID)) );
        if ~isempty(classID) && ~isempty(lvl)
            h = plotIsoContour(ensObjectsInterest{i, 1}, ensVerticesInterest{i, 1}, clusterRes.lvlColorMap{classID}(19, :), 3);
        else
            h = plotIsoContour(ensObjectsInterest{i, 1}, ensVerticesInterest{i, 1}, '[0.7 0.7 0.7]', 1);
            h.Color(4) = 0.5;
        end
    end
    % Add a coastline and axis values.
    m_coast('line')
    m_grid('box','on')
end

% Plot regional
if (get(handles.cropRegion,'Value') == 1)
    m_proj('Miller','lat',[min(lat(:)) max(lat(:))],...
        'lon',[min(lon(:)) max(lon(:))])
    
    % Grey out everything
    for i = 1 : size(ensemble, 3)
        h = plotIsoContour(ensObjectsInterest{i, 1}, ensVerticesInterest{i, 1}, '[0.7 0.7 0.7]', 1);
        h.Color(4) = 0.5;
    end
        
    % Highlighted spaghetti plot
    for i = 1 : size(cropEnsemble, 3)
        classID = find( cellfun(@(a) any(ismember(i, a)), filteredMembers) );
        lvl = find( cellfun(@(a) any(ismember(i, a)), clusterRes.upperLvlMembers(:, classID)) );
        if ~isempty(classID) && ~isempty(lvl)
            h = plotIsoContour(c_ensObjects{i, 1}, c_ensVertices{i, 1}, clusterRes.lvlColorMap{classID}(19, :), 3);
        else
            h = plotIsoContour(c_ensObjects{i, 1}, c_ensVertices{i, 1}, '[0.7 0.7 0.7]', 1);
            h.Color(4) = 0.5;
        end
    end
    
    rectangle('Position',rect);
    % Add a coastline and axis values.
    m_coast('line')
    m_grid('box','on')
end

% --- Executes during object creation, after setting all properties.
function contourFilteredLevelSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contourFilteredLevelSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in contourFilter.
function contourFilter_Callback(hObject, eventdata, handles)
% hObject    handle to contourFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns contourFilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from contourFilter
global clusterRes;

contents = cellstr(get(hObject,'String'));
method = contents{get(hObject,'Value')};

axes(handles.MDSPlot)
cla(handles.MDSPlot, 'reset')
if (strcmp(method, 'High-density Filtration') )
    % Set nativation bar
    set(handles.contourFilteredLevelSelector, 'Min', 1);
    set(handles.contourFilteredLevelSelector, 'Max', size(clusterRes.lv_seq, 1));
    set(handles.contourFilteredLevelSelector, 'Value', size(clusterRes.lv_seq, 1));
    set(handles.contourFilteredLevelSelector, 'SliderStep', [1/(size(clusterRes.lv_seq, 1) - 1), 1]);
    
    drawCirclesUpperlevel(size(clusterRes.lv_seq, 1));
    clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
    clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperLvlMembers(size(clusterRes.lv_seq, 1), clusterRes.selectedClass);
    
    set(handles.navLevel, 'String', 'Density level:  max(f)');
end

if (strcmp(method, 'Percentile Filtration') )
    set(handles.contourFilteredLevelSelector, 'Min', 1);
    set(handles.contourFilteredLevelSelector, 'Max', size(clusterRes.upperPercentiles, 1));
    set(handles.contourFilteredLevelSelector, 'Value', size(clusterRes.upperPercentiles, 1));
    set(handles.contourFilteredLevelSelector, 'SliderStep', [1/(size(clusterRes.upperPercentiles, 1) - 1), 1]);
    
    drawCirclesUpperPercentile(size(clusterRes.upperPercentiles, 1));
    clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
    clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperPercentiles(size(clusterRes.upperPercentiles, 1), clusterRes.selectedClass);
    
    msg = sprintf('Percentile: %d th ', 100-clusterRes.percentile(length(clusterRes.percentile)));
    set(handles.navLevel, 'String', msg);
end

axes(handles.canvas)
cla(handles.canvas, 'reset')
updateSpatialPlot(handles)

set( handles.MDSPlot, 'ButtonDownFcn',{@mouseClick, handles} );
set( get(handles.MDSPlot,'Children'), 'ButtonDownFcn',{@mouseClick, handles} );

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );


% --- Executes during object creation, after setting all properties.
function contourFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contourFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in isOutlier.
function isOutlier_Callback(hObject, eventdata, handles)
% hObject    handle to isOutlier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isOutlier
if (get(hObject,'Value') == 1)
    set(handles.contourFilteredLevelSelector, 'Value', 1);
else
    set(handles.contourFilteredLevelSelector, 'Value', get(handles.contourFilteredLevelSelector, 'Max'));
end


% --- Executes on selection change in classSelector.
function classSelector_Callback(hObject, eventdata, handles)
% hObject    handle to classSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns classSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from classSelector
global clusterRes;

selectedIdx = get(hObject, 'Value');

if (selectedIdx == 1)
    clusterRes.selectedClass = clusterRes.sig_clu;
else
    clusterRes.selectedClass = clusterRes.sortedClassLabels(selectedIdx - 1);
end

% Select clusters and plot all members of the selected clusters
axes(handles.MDSPlot)
cla(handles.MDSPlot, 'reset')
contents = cellstr(get(handles.contourFilter,'String'));
filterMethod = contents{get(handles.contourFilter,'Value')};

lvl = get(handles.contourFilteredLevelSelector, 'Value'); 
if (strcmp(filterMethod, 'High-density Filtration') )
    drawCirclesUpperlevel(lvl);
    clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
    clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperLvlMembers(lvl, clusterRes.selectedClass);
end

if (strcmp(filterMethod, 'Percentile Filtration') )
    drawCirclesUpperPercentile(lvl);
    clusterRes.filteredMembers = cell(clusterRes.numClusters, 1);
    clusterRes.filteredMembers(clusterRes.selectedClass) = clusterRes.upperPercentiles(lvl, clusterRes.selectedClass);
end

axes(handles.canvas)
cla(handles.canvas, 'reset')
updateSpatialPlot(handles)

set( handles.MDSPlot, 'ButtonDownFcn',{@mouseClick, handles} );
set( get(handles.MDSPlot,'Children'), 'ButtonDownFcn',{@mouseClick, handles} );

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );


function updateSpatialPlot(handles)
global clusterRes;

plotFilteredMembers(clusterRes.filteredMembers, 1, handles);

% --- Executes during object creation, after setting all properties.
function classSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in simplify.
function simplify_Callback(hObject, eventdata, handles)
% hObject    handle to simplify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.IOI, 'Value', 1);
selectIsovalue(1, handles);

plotSimplifiedSpaghettiPlot(handles);

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );

function plotSimplifiedSpaghettiPlot(handles)
global numIsos;
global lat;
global lon;
global ensemble;
global isovalues;
global AllClusters;
global dataMat;
global isoColorMap;

cla(handles.canvas, 'reset')
axes(handles.canvas)

m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

cell_C = {};
cell_h = {};
colormap(isoColorMap)

set(handles.IOI, 'Value', 1);

for i = 1 : numIsos
    sizeThresh = str2double(get(handles.sigThresh, 'String'));
    clusterRes = AllClusters{i};
    
    clus = unique(clusterRes.labels);
    Ncount = histc(clusterRes.labels, clus);
    clusterRes.sig_clu = clus(Ncount >= sizeThresh);
    
    for j = 1 : size(clusterRes.sig_clu, 1)
       
        classLable = clusterRes.sig_clu(j);
        tmp = clusterRes.f;
        tmp(clusterRes.labels ~= classLable) = -inf;
        [M, I] = max(tmp);
        tmp(tmp == -inf) = [];
        clusterSize = numel(tmp);
        
        image = ensemble(:,:,I);
        
        c_member = find(clusterRes.labels == classLable);
        err = mean(std(dataMat{i}(c_member, :), 0, 1))/10;
        
        hold on
        [C, h] = m_contour(lon, lat, image, [isovalues(i), isovalues(i)], 'LineWidth', err);
        cell_C = [cell_C; C];
        cell_h = [cell_h; h];
    end
end

for i = 1 : size(cell_C, 1)
    clabel(cell_C{i}, cell_h(i), 'FontSize', 7);
    rng(i, 'twister');
    set(cell_h(i), 'LabelSpacing', 300 + 500*abs(rand))
end
m_coast('line')
m_grid('box','on')

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );

function sigThresh_Callback(hObject, eventdata, handles)
% hObject    handle to sigThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigThresh as text
%        str2double(get(hObject,'String')) returns contents of sigThresh as a double


% --- Executes during object creation, after setting all properties.
function sigThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trivialTresh_Callback(hObject, eventdata, handles)
% hObject    handle to trivialTresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trivialTresh as text
%        str2double(get(hObject,'String')) returns contents of trivialTresh as a double


% --- Executes during object creation, after setting all properties.
function trivialTresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trivialTresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in defaultThresh.
function defaultThresh_Callback(hObject, eventdata, handles)
% hObject    handle to defaultThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ensemble

n_member = size(ensemble, 3);
set(handles.sigThresh, 'String', num2str(uint8(n_member*0.3)));
set(handles.trivialTresh, 'String', num2str(2));


% --- Executes on button press in cropRegion.
function cropRegion_Callback(hObject, eventdata, handles)
% hObject    handle to cropRegion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cropRegion
global ensemble;
global lon;
global lat;
global c_lon;
global c_lat;

global cropEnsemble;
global rect;

if (get(hObject, 'Value') == 1)    % Perform a local clustering
    rect = getrect;
    
    [lon1, lat1] = m_xy2ll(rect(1), rect(2));
    [lon2, lat2] = m_xy2ll(rect(1)+rect(3), rect(2)+rect(4));

    % Crop the data
    [~, minLonInd] = min(abs(lon(1,:) - lon1));
    [~, maxLonInd] = min(abs(lon(1,:) - lon2));
    [~, minLatInd] = min(abs(lat(:,1) - lat1));
    [~, maxLatInd] = min(abs(lat(:,1) - lat2));
    
    [lx, ly] = m_ll2xy(lon(1, minLonInd), lat(minLatInd, 1));
    [ux, uy] = m_ll2xy(lon(1, maxLonInd), lat(maxLatInd, 1));
    
    rectangle('Position',[lx, ly, ux-lx, uy-ly]);
    
    cropEnsemble = ensemble(minLatInd:maxLatInd, minLonInd:maxLonInd, :);
    c_lon = lon(minLatInd:maxLatInd, minLonInd:maxLonInd);
    c_lat = lat(minLatInd:maxLatInd, minLonInd:maxLonInd);
else                               % Go back to global
    initialClusterSetup(handles)
end

set( handles.MDSPlot, 'ButtonDownFcn',{@mouseClick, handles} );
set( get(handles.MDSPlot,'Children'), 'ButtonDownFcn',{@mouseClick, handles} );

set( gca, 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );
set( get(gca,'Children'), 'ButtonDownFcn',{@mouseClickSpaghetti, handles} );


% --- Executes during object creation, after setting all properties.
function IndividualNavigator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IndividualNavigator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function DensityMethodSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DensityMethodSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function modeSelection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modeSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function InitDateSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InitDateSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function inputVar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

