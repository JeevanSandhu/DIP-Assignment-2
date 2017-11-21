function varargout = dip_assignment_2(varargin)
% DIP_ASSIGNMENT_2 MATLAB code for dip_assignment_2.fig
%      DIP_ASSIGNMENT_2, by itself, creates a new DIP_ASSIGNMENT_2 or raises the existing
%      singleton*.
%
%      H = DIP_ASSIGNMENT_2 returns the handle to a new DIP_ASSIGNMENT_2 or the handle to
%      the existing singleton*.
%
%      DIP_ASSIGNMENT_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIP_ASSIGNMENT_2.M with the given input arguments.
%
%      DIP_ASSIGNMENT_2('Property','Value',...) creates a new DIP_ASSIGNMENT_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dip_assignment_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dip_assignment_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dip_assignment_2

% Last Modified by GUIDE v2.5 21-Nov-2017 11:42:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dip_assignment_2_OpeningFcn, ...
                   'gui_OutputFcn',  @dip_assignment_2_OutputFcn, ...
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


% --- Executes just before dip_assignment_2 is made visible.
function dip_assignment_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dip_assignment_2 (see VARARGIN)

% Choose default command line output for dip_assignment_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dip_assignment_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dip_assignment_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
    global im;
    List = get(hObject, 'String');
    Val = get(hObject, 'Value');
    path = pwd;
    path = strcat(path, '\images\');
    name = List(Val);
    name = char(name);
    name = deblank(name);
    filename = strcat(path, name);
    im = imread(filename);

    axes(handles.axes1);
    imshow(im);
    
    fftim = fftshift(fft2(double(im)));
    mag = abs(fftim);
    axes(handles.axes2);
    imshow(log(1 + mag), []);

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
n = 1; %order
d = 50; %cutoff
h = size(im, 1);
w = size(im, 2);
fftim = fftshift(fft2(double(im)));
[x, y] = meshgrid(-floor(w/2):floor(w/2)-1,-floor(h/2):floor(h/2)-1);

B = sqrt(2) - 1;
D = sqrt(x.^2 + y.^2);
llp = 1 ./ (1 + B * (D ./ d).^(2 * n));

axes(handles.axes3);
imshow(llp);

out_spec_centre = fftim .* llp;
axes(handles.axes4);
imshow(log(1 + abs(out_spec_centre)), []);

out_spec = ifftshift(out_spec_centre);
out = real(ifft2(out_spec));
out = (out - min(out(:))) / (max(out(:)) - min(out(:)));
out = uint8(255*out);

axes(handles.axes5);
imshow(out);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global asdf1;
global asdf2;
n = text1; %order
d = text2; %cutoff
h = size(im, 1);
w = size(im, 2);
fftim = fftshift(fft2(double(im)));
[x, y] = meshgrid(-floor(w/2):floor(w/2)-1,-floor(h/2):floor(h/2)-1);

B = sqrt(2) - 1;
D = sqrt(x.^2 + y.^2);
llp = 1 ./ (1 + B * (d ./ D).^(2 * n));

axes(handles.axes3);
imshow(llp);

out_spec_centre = fftim .* llp;
axes(handles.axes4);
imshow(log(1 + abs(out_spec_centre)), []);

out_spec = ifftshift(out_spec_centre);
out = real(ifft2(out_spec));
out = (out - min(out(:))) / (max(out(:)) - min(out(:)));
out = uint8(255*out);

axes(handles.axes5);
imshow(out);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global asdf1;
asdf1 = str2double(get(hObject, 'String'))
% text1 = char(text1);
% text1 = deblank(text1);
% text1 = uint8(text1);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
global asdf2;
asdf2 = get(hObject, 'String');
asdf2 = char(asdf2)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
