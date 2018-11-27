function plotTextbox(txt,varargin)
%% PlotTextbox(txt) | (txt,location) | (txt,location,figure)
%
%   Adds text box to plot with given text. Optionally you can specify
%   the location of the graph to add it to and a figure object to plot on. 
% 
%   valid locations: (Defaults to SW)
%       - any cardinal direction 
%           - EX. 'NE' or 'NorthEast'
%           - EX. 'S' or 'South'
%       - outside after direction to specify that it should relative to the 
%         figure (vs the internal axes)
%           - EX 'NEO' or 'NorthEastOutside'
%
%
%  Created by Max Westwater - 7/2018

%% Get input location or set to default if none given
% first argument is always the text to be displayed
% the second & third are optional and can be either location or figure, in
% any order
switch(nargin)
    case 1
        locationInput = 'SW';
        fig = gcf;
    case 2
        input = varargin{1};
        if(ischar(input))
            locationInput = input;
            fig = gcf;
        else
            fig = input;
            locationInput = 'SW';
        end
    case 3
        if(ischar(varargin{1}))
            locationInput = varargin{1};
            fig = varargin{2};
        else
            locationInput = varargin{2};
            fig = varargin{1};
        end
end

%% Converts string to the shorthand (EX. SW)
%  Taken from built in legend() code
%  Checks for valid input and will convert any input to it's shorthand
%  notation
locations = {'North','South','East', 'West','NorthEast','SouthEast','NorthWest','SouthWest','NorthOutside','SouthOutside','EastOutside','WestOutside','NorthEastOutside','SouthEastOutside','NorthWestOutside','SouthWestOutside'};
locationAbbrevs = cell(1,length(locations));
for k=1:length(locations)
    str = locations{k};
    locationAbbrevs{k} = str(str>='A' & str<='Z');
end

locationCmp = strcmpi(locationInput, locations);
abbrevsCmp = strcmpi(locationInput, locationAbbrevs);
if any(locationCmp)
    str = char(locationInput);
    locationChar = str(str>='A' & str<='Z');
elseif any(abbrevsCmp)
    locationChar = locationAbbrevs{abbrevsCmp};
else
    error('Invalid argument to location. Type ''help plotTextbox'' for more information.');
end

%% Find boundaries of current axes or the entire graph if outside is selected
location = zeros(1,4);
switch(char(regexpi(locationChar,'(O)','match')))
    case 'O'
        disp('outside')
        boundary = [0 0 1 1];
    otherwise
        boundary = fig.CurrentAxes.Position;
        
end

%% Calculate boundaries based on graph and location
padding = 0.01;  % space between edge and start of textbox
switch(char(regexpi(locationChar,'(N|S)','match')))
    case 'N'
        location(2) = boundary(4) + boundary(2) - padding;
        vertAlign = 'top';
    case 'S'
        location(2) = boundary(2) + padding;
        vertAlign = 'bottom';
    otherwise
       location(2) = boundary(2) + boundary(4)/2;
        vertAlign = 'middle';
end

switch(char(regexpi(locationChar,'(E|W)','match')))
    case 'E'
        location(1) = boundary(3) + boundary(1) - padding;
        horzAlign = 'right';
    case 'W'
        location(1) = boundary(1) + padding;
        horzAlign = 'left';
    otherwise
        location(1) = boundary(1) + boundary(3)/2;
        horzAlign = 'center';
        
end

%% Actually create textbox 
f = defaultFonts;
annotation(fig,'textbox',location,'BackgroundColor','w',...
    'String',txt,'EdgeColor','k','interpreter','none',...
    'VerticalAlignment',vertAlign,'HorizontalAlignment',horzAlign, ...
    'FitBoxToText','on','FontName','FixedWidth','fontsize',f.textbox);

end