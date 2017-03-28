function snakeGame()
[tag board_size] = config();
if isequal(board_size,'Small')
    board = zeros(12,12);
elseif isequal(board_size,'Medium')
    board = zeros(16,16);
elseif isequal(board_size,'Large')
    board = zeros(20,20);
end
status = true;
[row col] = size(board);
plot([ones(1, row)*(-col/2) -col/2:col/2 (col/2).*ones(1, row) col/2:-1:-col/2], [row/2:-1:-row/2 (-row/2)*ones(1, col) -row/2:row/2 (col/2)*ones(1,col)], 'k-');
axis([-10 10 -10 10]);
axis off
hold on
r = -row/4;
c = -col/4;
snake = plot([c c+1], [r r], 'g-', 'LineWidth', 3);
cookie_row = round((row-2)*rand - (row-2)/2);
cookie_col = round((col-2)*rand - (col-2)/2);
cookie = plot(cookie_col, cookie_row, 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 3);
temp = 0;
line_col = c-1:0.1:c;
line_row = r*ones(1,length(line_col));
hit = false;
while status
    set(gcf, 'KeyPressFcn',@(a,b)get(gcf,'CurrentCharacter'));
    set(snake,'Visible','off');
    snake = plot(line_col, line_row, 'g-', 'LineWidth', 3);
    if abs(cookie_row-r) <= 0.2 & abs(cookie_col-c) <= 0.2 & temp ~= 0 & ~isempty(temp)
        set(cookie,'Visible','off');
        cookie_row = round((row-2)*rand - (row-2)/2);
        cookie_col = round((col-2)*rand - (col-2)/2);
        cookie = plot(cookie_col, cookie_row, 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 3);
        if isequal(arrow,30)
            r = r+0.1;
            line_col(end+1) = line_col(end);
            line_row(end+1) = line_row(end)+0.1;
        elseif isequal(arrow,31)
            r = r-0.1;
            line_col(end+1) = line_col(end);
            line_row(end+1) = line_row(end)-0.1;
        elseif isequal(arrow,29)
            c = c+0.1;
            line_col(end+1) = line_col(end)+0.1;
            line_row(end+1) = line_row(end);
        elseif isequal(arrow,28)
            c = c-0.1;
            line_col(end+1) = line_col(end)-0.1;
            line_row(end+1) = line_row(end);
        end
        set(snake,'Visible','off');
        snake = plot(line_col, line_row, 'g-', 'LineWidth', 3);
    end
    arrow = double(get(gcf, 'CurrentCharacter'));
    if arrow ~= 28 & arrow ~= 29 & arrow ~= 30 & arrow ~= 31
        arrow = temp;
    end
    if (arrow + temp) == 61 | (arrow + temp) == 57
        arrow = temp;
    end
    if isequal(arrow,30) || isequal(arrow,31)
        if isequal(arrow,30)
            r = r+0.1;
        elseif isequal(arrow,31)
            r = r-0.1;
        end
        last = line_col(end);
        line_col(1) = [];
        line_col(end+1) = last;
        line_row(1) = [];
        line_row(end+1) = r;
    elseif isequal(arrow,29) || isequal(arrow,28)
        if isequal(arrow,29)
            c = c+0.1;
        elseif isequal(arrow,28)
            if isempty(temp)
                line_col = line_col(end:-1:1);
                c = c-1.1;
            else
                c = c-0.1;
            end
        end
        last = line_row(end);
        line_row(1) = [];
        line_row(end+1) = last;
        line_col(1) = [];
        line_col(end+1) = c;
    end
    temp = arrow;
    row_check = find(line_row(1:end-1) == r);
    col_check = find(line_col(1:end-1) == c);
    for i = 1:length(row_check)
        if any(col_check == row_check(i))
            hit = true;
        end
    end
    if c >= col/2-0.05 || c <= -col/2+0.05 || r >= row/2-0.05 || r <= -row/2+0.05 || hit
        status = false;
        gameover = dialog('Position',[650 350 250 150],'Name', tag);
        uicontrol('Parent',gameover,'Style','text','Position',[20 41 210 80],'String','Game Over');
        uicontrol('Parent',gameover,'Style','text','Position',[21 -13 210 80],'String',sprintf('Your Score: %d',length(line_col)-11));
    end
    pause(0.03);
end
end