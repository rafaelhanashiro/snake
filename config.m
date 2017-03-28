function [tag, size] = config()
d = dialog('Position',[650 350 250 190],'Name','Game Configurations');
uicontrol('Parent',d,'Style','text','Position',[21 88 210 80],'String','Board Size');
uicontrol('Parent',d,'Style','popup','Position',[75 90 100 55],'String',{'Small';'Medium';'Large'},'Callback',@callback1);
uicontrol('Parent',d,'Style','text','Position',[20 33 210 80],'String','Gamer Tag');
uicontrol('Parent',d,'Style','edit','Position',[50 65 150 25],'Callback',@callback2);
uicontrol('Parent',d,'Position',[92 20 70 30],'String','Enter','Callback','delete(gcf)');
size = 'Small';
tag = 'Unknown';
uiwait(d);
    function callback1(popup, event)
        idx = popup.Value;
        popup_items = popup.String;
        size = char(popup_items(idx,:));
    end
    function callback2(text, event)
        tag = text.String;
    end
end