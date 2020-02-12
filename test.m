r = creat_ur5('right',transl(0,-0.544,0)); %持笔机器人
board_length = 3; %板长
board_width = 3; %板宽
pen_length = 0.05; %笔长
left_end = transl(0,0,1) * trotx(-0.5*pi);
board_left_top = left_end*transl(board_length/2,board_width/2,0);
delta_dis = 0.05;
m=5;
n=6;

T1 = transl(-1.5,-delta_dis*m,-delta_dis*n)*board_left_top;
hold on
trplot(T1)
trplot(board_left_top)
%diff = round(abs(([board_left_top(3,4) board_left_top(1,4)] - [pos(3,4) pos(1,4)])/delta_dis));