r = creat_ur5('right',transl(0,-0.544,0)); %持笔机器人


board_length = 2; %板长
board_width = 2 ; %板宽
pen_length = 0.05; %笔长
left_end = transl(0,0,0.4) * trotx(-0.5*pi);
delta_dis = 0.02; %每个点之间的间距
% 版上四角的位姿
board_left_top = left_end*transl(board_length/2,board_width/2,0);
board_left_bottom = left_end*transl(board_length/2,-board_width/2,0);
board_right_top = left_end*transl(-board_length/2,board_width/2,0);
board_right_bottom = left_end*transl(-board_length/2,-board_width/2,0);

% 绘制纸张的边缘
hold on;
trplot(left_end);
edge_x = [ board_left_top(1,4) board_left_bottom(1,4) board_right_bottom(1,4) board_right_top(1,4) board_left_top(1,4)];
edge_y = [ board_left_top(2,4) board_left_bottom(2,4) board_right_bottom(2,4) board_right_top(2,4) board_left_top(2,4)];
edge_z = [ board_left_top(3,4) board_left_bottom(3,4) board_right_bottom(3,4) board_right_top(3,4) board_left_top(3,4)];
plot3(edge_x,edge_y,edge_z);
%hold off;
%% 测试
%测试思路：一次测试一行，小循环修改z值，大循环修改x值
color_singularity = [251/255 98/255 112/255]; %写字的路径颜色
color_safe = [36/255 201/255 179/255]; %抬笔的路径颜色
a3 = -392.25;
a2 = -425;
d5 = 94.56;
diff_upper_limit = 0.5;

tic
for m = 0:pen_length/delta_dis
    %color = [rand rand rand];
    for n = 0:board_width/delta_dis 
        T1 = transl(0,-delta_dis*m,-delta_dis*n)*board_left_bottom;
        T2 = transl(0,-delta_dis*m,-delta_dis*n)*board_right_bottom;
        trajectory =ctraj(T1,T2,board_length/delta_dis);%board_length/delta_dis太大了
        a = ur5_ikine(r,trajectory);
        for i=1:size(a,1)
            c2 = cos(a(i,2));
            s3 = sin(a(i,3));
            c34 = cos(a(i,3)+a(i,4));
            c23 = cos(a(i,3)+a(i,2));
            s234 = sin(a(i,3)+a(i,2)+a(i,4));
            s5 = sin(a(i,5));
            expression1 = 1;
            expression2 = 1;
            expression3 = 1;
            %r.plot(a(i,:));
            if abs(-a3*s3+d5*c34) <= diff_upper_limit
                expression1 = 0;
            end
            if abs(-a3*c23-d5*s234-a2*c2) <= diff_upper_limit
                expression2 = 0;
            end
            if abs(s5) <= diff_upper_limit
                expression3 = 0;
            end
            color = color_safe;
            if expression1*expression2*expression3 ==0
                color = color_singularity;
            end
            pos = r.fkine(a(i,:));
            dot_pos = [pos(1,4) pos(2,4) pos(3,4)];
            scatter3(dot_pos(1),dot_pos(2),dot_pos(3),36,color);
        end
    end
end
toc



%  a = ur5_ikine_single(r,left_end);
%  r.plot(a{1});