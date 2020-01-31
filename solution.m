r = creat_ur5('right',transl(0,-0.544,0));

% 遍历所有点
board_length = 2;
board_width = 1 ;
pen_length = 0.05;
left_end = transl(0,0,0) * trotx(-0.5*pi);

% 方框边缘的位姿
board_left_head = left_end*transl(board_length/2,board_width/2,0);
board_left_tail = left_end*transl(board_length/2,-board_width/2,0);
board_right_head = left_end*transl(-board_length/2,board_width/2,0);
board_right_tail = left_end*transl(-board_length/2,-board_width/2,0);

% 绘制纸张的边缘
hold on;
trplot(left_end);
edge_x = [ board_left_head(1,4) board_left_tail(1,4) board_right_tail(1,4) board_right_head(1,4) board_left_head(1,4)];
edge_y = [ board_left_head(2,4) board_left_tail(2,4) board_right_tail(2,4) board_right_head(2,4) board_left_head(2,4)];
edge_z = [ board_left_head(3,4) board_left_tail(3,4) board_right_tail(3,4) board_right_head(3,4) board_left_head(3,4)];
plot3(edge_x,edge_y,edge_z);
%对纸张内每个点进行绘制

delta = 0.01;
width_num = round(board_width/delta);
length_num = round(board_length/delta);
img = zeros(width_num,length_num);
%%




%%
for i=1:width_num
    for j=1:length_num
        base  = transl(board_width/2-i*delta,-board_length/2+j*delta,0);
        T = inv(left_end)*base;
        try
            a = ur5_ikine_single(r,T);
            img(i,j)=1;
        catch
            fprintf("No!\n")
        end
    end
end

%绘制持笔机器人以作参照
q = ur5_ikine_single(r,left_end);
r.plot(q{1});




figure
imshow(img)
