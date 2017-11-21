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

% Last Modified by GUIDE v2.5 21-Nov-2017 10:47:05

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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
