function varargout = ImageProcessor(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageProcessor_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageProcessor_OutputFcn, ...
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



% --- Executes just before ImageProcessor is made visible.
function ImageProcessor_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = ImageProcessor_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel1 is resized.
function uipanel1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function text2_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in
% menu_process.--------------------------------------------------------------------------------------------------------------->>>>>>>>
% 
function menu_process_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'fileLoaded') || ~handles.fileLoaded
    msgbox('Please Load an Image First!', 'Error', 'error');
    return;
end

contents = cellstr(get(hObject, 'String'));
choice = contents{get(hObject, 'Value')};   

img = handles.originalImage;
result = img;

% --- ???? ??? menu_process_Callback ---
switch choice
    case 'Original'
        result = img;

    % --- Block 1 ---
    case 'Rgb2Gray'
        msg = ['Enter Conversion Method Index:', char(10), ...
               '1: Average (R+G+B)/3', char(10), ...
               '2: Red Channel Only', char(10), ...
               '3: Green Channel Only', char(10), ...
               '4: Blue Channel Only', char(10), ...
               '5: Weighted Sum (0.2R + 0.3G + 0.5B)'];
        
        answer = inputdlg(msg, 'RGB to Gray Options', [1 50], {'1'});
        
        if ~isempty(answer)
            method_index = str2double(answer{1});
            
            if ~isnan(method_index) && method_index >= 1 && method_index <= 5
                result = RGB2gray(img, method_index);
            else
                msgbox('Please enter a valid index between 1 and 5!', 'Input Error', 'error');
                return;
            end
        end
        
    case 'Contrast Stretching'
        result = contrast_stretch(img);
        
    case 'Padding'
        prompt = {'Enter Height Padding (padH):', ...
                  'Enter Width Padding (padW):', ...
                  'Enter Padding Value (0-255):'};
        dlgtitle = 'Padding Parameters';
        dims = [1 50];
        definput = {'10', '10', '0'}; 
        
        answer = inputdlg(prompt, dlgtitle, dims, definput);
        
        if ~isempty(answer)
            pH = str2double(answer{1});
            pW = str2double(answer{2});
            pVal = str2double(answer{3});
            result = padding(img, pH, pW, pVal);
        end
        
    case 'Point Sharpening'
        result = point_sharpening(img);
        
    case 'Ideal Low Pass Filter'
        answer = inputdlg('Enter Cut-off Frequency (D0):', 'Ideal LPF', [1 50], {'50'});
        if ~isempty(answer)
            D0 = str2double(answer{1});
            result = IdealLowPassFilter(img, D0);
        end
        
    case 'Add Salt & Pepper Noise'
        answer = inputdlg({'Salt Probability:', 'Pepper Probability:'}, 'Noise Params', [1 50], {'0.05', '0.05'});
        if ~isempty(answer)
            result = SaltPepperAdd(img, str2double(answer{1}), str2double(answer{2}));
        end
        
    case 'Remove Salt & Pepper Noise'
        answer = inputdlg('Enter Window Size (e.g., 3, 5, 7):', 'Salt & Pepper Removal', [1 50], {'3'});
        if ~isempty(answer)
            win_size = str2double(answer{1});
            result = SaltPepperRemove(img, win_size);
        end
        
    case 'Geometric Mean Filter'
        answer = inputdlg('Enter Window Size (e.g., 3, 5, 7):', 'Geometric Mean Filter', [1 50], {'3'});
        
        if ~isempty(answer)
            win_size = str2double(answer{1});
            result = geometric_mean_filter(img, win_size);
        end
    
    case {'Erosion', 'Dilation', 'Opening', 'Closing'}
        prompt = {'Enter Structuring Element Size (e.g., 3):', ...
                  'Enter Padding Value (0 for Black, 255 for White):'};
        dlgtitle = ['Parameters for ' choice];
        dims = [1 50];
        definput = {'3', '0'};
        answer = inputdlg(prompt, dlgtitle, dims, definput);
        
        if ~isempty(answer)
            se_size = str2double(answer{1});
            padVal = str2double(answer{2});
            se_matrix = ones(se_size, se_size);
            
            switch choice
                case 'Erosion'
                    result = erosion(img, se_matrix, padVal);
                case 'Dilation'
                    result = dilation(img, se_matrix, padVal);
                case 'Opening'
                    result = opening(img, se_matrix, padVal);
                case 'Closing'
                    result = closing(img, se_matrix, padVal);
            end
        end
        
        
    % --- Block 2 ---
    case 'Gray2Binary'
        answer = inputdlg('Enter Threshold Value (0-255):', 'Gray to Binary', [1 50], {'128'});
        
        if ~isempty(answer)
            th_val = str2double(answer{1});
            
            if ~isnan(th_val) && th_val >= 0 && th_val <= 255
                result = graytobinary(img, th_val);
            else
                msgbox('Please enter a valid threshold between 0 and 255!', 'Error', 'error');
                return;
            end
        end
        
    case 'LOG Filter'
        result = Log(img);
        
    case 'Correlation'
        result = correlation(img);
        
    case 'Line Sharpening'
        result = LineSharpening(img);
        
    case 'Ideal High Pass Filter'
        answer = inputdlg('Enter Cut-off Frequency (D0):', 'Ideal HPF', [1 50], {'50'});
        if ~isempty(answer)
            result = ideal_high_pass_filter(img, str2double(answer{1}));
        end
        
    case 'Add Uniform Noise'
        prompt = {'Min (a):', 'Max (b):', 'Density (0-1):'};
        dlgtitle = 'Uniform Noise Parameters';
        definput = {'0', '50', '0.1'};
        answer = inputdlg(prompt, dlgtitle, [1 50], definput);
        
        if ~isempty(answer)
            a = str2double(answer{1});
            b = str2double(answer{2});
            perc = str2double(answer{3});
            result = uniform_noise(img, a, b, perc, 'a');
        end

    case 'Remove Uniform Noise'
        answer = inputdlg('Enter Window Size (e.g., 3):', 'Remove Uniform Noise', [1 50], {'3'});
        if ~isempty(answer)
            win = str2double(answer{1});
            result = MeanFilter(img, win);
        end
        
    case 'Harmonic Mean Filter'
        answer = inputdlg('Enter Window Size (k):', 'Harmonic Mean Filter', [1 50], {'3'});
        
        if ~isempty(answer)
            k_val = str2double(answer{1});
            
            result = harmonic_filter(img, k_val);
        end

    % --- Block 3 ---
    case 'RGB2Binary'
        result = RGB2Binary(img);
        
    case 'Gamma Correction'
        answer = inputdlg('Enter Gamma Value:', 'Gamma', [1 50], {'1.5'});
        if ~isempty(answer)
            result = GammaCorrection(img, str2double(answer{1}));
        end
        
    case 'Mean Filter'
        result = MeanFilter(img);
        
    case 'Min Filter'
        result = MinFilter(img);
        
    case 'Max Filter'
        result = MaxFilter(img);
        
    case 'Butterworth Low Pass Filter'
        answer = inputdlg({'Cut-off Frequency (D0):', 'Order (n):'}, 'Butterworth LPF', [1 50], {'50', '2'});
        if ~isempty(answer)
            result = ButterworthLowPass(img, str2double(answer{1}), str2double(answer{2}));
        end
        
    case 'Add Gaussian Noise'
        prompt = {'Sigma (Standard Deviation):', 'Mean Value:'};
        dlgtitle = 'Gaussian Noise Parameters';
        dims = [1 50];
        definput = {'10', '0'};
        answer = inputdlg(prompt, dlgtitle, dims, definput);
        
        if ~isempty(answer)
            sigma = str2double(answer{1});
            meanVal = str2double(answer{2});
            result = GaussianOperations(img, 'add', sigma, meanVal);
        end
        
    case 'Remove Gaussian Noise'
        answer = inputdlg('Enter Sigma for Smoothing:', 'Remove Gaussian Noise', [1 50], {'2'});
        
        if ~isempty(answer)
            sigma = str2double(answer{1});
            result = GaussianOperations(img, 'remove', sigma, 0);
        end
        
    case 'Contraharmonic Mean Filter'
        answer = inputdlg('Enter Order (Q):', 'Contraharmonic', [1 50], {'1.5'});
        if ~isempty(answer)
            result = ContraharmonicFilter(img, str2double(answer{1}));
        end

    % --- Block 4 ---
    case 'Brightness'
        prompt = {'Enter Offset Value:', ...
                  'Enter Option (1:Add, 2:Mul, 3:Sub, 4:Div):'};
        dlgtitle = 'Brightness & Darkness Control';
        dims = [1 50];
        % 2. ??? ???????? (offset = 50, option = 1)
        definput = {'50', '1'}; 
        
        answer = inputdlg(prompt, dlgtitle, dims, definput);
        
        if ~isempty(answer)
            val = str2double(answer{1});
            opt = str2double(answer{2});
            if ~isnan(opt) && opt >= 1 && opt <= 4
                result = Brightness_Darkness(img, val, opt);
            else
                msgbox('Please enter a valid Option index (1, 2, 3, or 4)!', 'Input Error', 'error');
                return;
            end
        end
        
    case 'Histogram Equalization'
        result = Histogram_Equalization(img);
        
    case 'Weight Filter'
        result = weighted_filter(img); 
        
    case 'Median Filter'
        result = median_filter(img);
        
    case 'MidPoint Filter'
        result = MidpointFilter(img); % &&&&&&&&&&&&&&&&&&
        
    case 'Butterworth High Pass Filter'
        answer = inputdlg({'Cut-off (D0):', 'Order (n):'}, 'Butterworth HPF', [1 50], {'50', '2'});
        if ~isempty(answer)
            result = butterworthHPF(img, str2double(answer{1}), str2double(answer{2}));
        end
        
    case 'Add Rayleigh Noise'
        answer = inputdlg({'Parameter a:', 'Parameter b:'}, 'Rayleigh Noise', [1 50], {'0', '1'});
        if ~isempty(answer)
            result = add_rayleigh_noise(img, str2double(answer{1}), str2double(answer{2}));
        end
        
    case 'Remove Rayleigh Noise'
        result = remove_rayleigh_noise(img);
        
    case 'Adaptive Filter'
        prompt = {'Enter Window Size (e.g., 3, 5, 7):', 'Enter Noise Variance:'};
        dlgtitle = 'Adaptive Filter Parameters';
        definput = {'7', '25'};
        answer = inputdlg(prompt, dlgtitle, [1 50], definput);
        
        if ~isempty(answer)
            win_size = str2double(answer{1});
            n_var = str2double(answer{2});
            
            result = adaptive_filter(img, win_size, n_var);
        end

    % --- Block 5 ---
    case 'Negative Image'
        result = ImageNegative(img);
        
    case 'Bit Plane Slicing'
        result = BitPlaneSlicing(img);
        
    case 'Point Detection'
        result = PointDetection(img);
        
    case 'Fourier Transform (DFT)'
        result = DFT(img);
        
    case 'Gaussian Low Pass Filter'
        answer = inputdlg('Enter Cut-off (D0):', 'Gaussian LPF', [1 50], {'50'});
        if ~isempty(answer)
            result = gaussianLPF(img, str2double(answer{1}));
        end
        
    case 'Add Exponential Noise'
        answer = inputdlg({'Parameter a:', 'Parameter b:'}, 'Exp Noise', [1 50], {'1', '10'});
        if ~isempty(answer)
            result = AddExponentialNoise(img, str2double(answer{1}), str2double(answer{2}));
        end
        
    case 'Remove Exponential Noise'
        result = RemoveExponentialNoise(img);

    % --- Block 6 ---
    case 'Histogram Plot'
        result = histogram(img);
        
    case 'Intensity Level Slicing'
        answer = inputdlg({'Min Intensity:', 'Max Intensity:'}, 'Slicing', [1 50], {'100', '200'});
        if ~isempty(answer)
            result = IntensityLevelSlicing(img, str2double(answer{1}), str2double(answer{2}));
        end
        
    case 'Line Detection'
        prompt = {'Enter Method (Sobel/Prewitt/Canny):', ...
                  'Enter Direction (H for Horizontal, V for Vertical, D for Diagonal):'};
        dlgtitle = 'Line Detection Parameters';
        dims = [1 50];
        definput = {'Sobel', 'H'}; 
        
        answer = inputdlg(prompt, dlgtitle, dims, definput);
        
        if ~isempty(answer)
            method = answer{1};
            direction = answer{2};

            result = line_detection(img, method, direction);
        end
        
    case 'Inverse Fourier Transform'
        result = InverseFourierTransform(img);
        
    case 'Gaussian High Pass Filter'
        answer = inputdlg('Enter Cut-off (D0):', 'Gaussian HPF', [1 50], {'50'});
        if ~isempty(answer)
            result = gaussianHPF(img, str2double(answer{1}));
        end
        
    case 'Add Gamma Noise'
        answer = inputdlg({'Parameter a:', 'Parameter b:'}, 'Gamma Noise', [1 50], {'2', '10'});
        if ~isempty(answer)
            result = AddGammaNoise(img, str2double(answer{1}), str2double(answer{2}));
        end
        
    case 'Remove Gamma Noise'
        result = RemoveGammaNoise(img);

    otherwise
        result = img;
end
axes(handles.axes2);
imshow(result);

handles.processedImage = result;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menu_process_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_load.
function btn_load_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.tif', 'Image Files'}, 'Select an Image');
if isequal(filename,0) || isequal(pathname,0)
    return;
end

fullPath = fullfile(pathname, filename);
img = imread(fullPath);

axes(handles.axes1); 
imshow(img);

handles.originalImage = img;     
handles.processedImage = img;   
handles.fileLoaded = true;      

guidata(hObject, handles);


% --- Executes on button press in btn_save.
function btn_save_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'processedImage')
    msgbox('No processed image to save!', 'Error', 'error');
    return;
end

[filename, pathname] = uiputfile({'*.jpg';'*.png';'*.bmp'}, 'Save Image As');

if isequal(filename,0) || isequal(pathname,0)
    return;
end

fullPath = fullfile(pathname, filename);
imwrite(handles.processedImage, fullPath);

msgbox('Image Saved Successfully!', 'Success');
