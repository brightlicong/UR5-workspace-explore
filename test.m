r = creat_ur5('right',transl(0,-0.544,0)); %�ֱʻ�����
board_length = 2; %�峤
board_width = 2 ; %���
pen_length = 0.05; %�ʳ�
left_end = transl(0,0,0.4) * trotx(-0.5*pi)*trotz(pi);
delta_dis = 0.02; %ÿ����֮��ļ��
% �����Ľǵ�λ��
board_left_top = left_end*transl(board_length/2,board_width/2,0);
board_left_bottom = left_end*transl(board_length/2,-board_width/2,0);
board_right_top = left_end*transl(-board_length/2,board_width/2,0);
board_right_bottom = left_end*transl(-board_length/2,-board_width/2,0);
hold on;
trplot(left_end);

view(127,30)
edge_x = [ board_left_top(1,4) board_left_bottom(1,4) board_right_bottom(1,4) board_right_top(1,4) board_left_top(1,4)];
edge_y = [ board_left_top(2,4) board_left_bottom(2,4) board_right_bottom(2,4) board_right_top(2,4) board_left_top(2,4)];
edge_z = [ board_left_top(3,4) board_left_bottom(3,4) board_right_bottom(3,4) board_right_top(3,4) board_left_top(3,4)];
plot3(edge_x,edge_y,edge_z);