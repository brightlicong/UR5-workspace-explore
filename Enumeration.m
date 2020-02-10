r = creat_ur5('right',transl(0,-0.544,0)); %�ֱʻ�����

board_length = 2; %�峤
board_width = 2 ; %���
pen_length = 0.05; %�ʳ�
left_end = transl(0,0,0.4) * trotx(-0.5*pi);
delta_dis = 0.025; %ÿ����֮��ļ��
% �����Ľǵ�λ��
board_left_top = left_end*transl(board_length/2,board_width/2,0);
board_left_bottom = left_end*transl(board_length/2,-board_width/2,0);
board_right_top = left_end*transl(-board_length/2,board_width/2,0);
board_right_bottom = left_end*transl(-board_length/2,-board_width/2,0);

% ����ֽ�ŵı�Ե
hold on;
trplot(left_end);
edge_x = [ board_left_top(1,4) board_left_bottom(1,4) board_right_bottom(1,4) board_right_top(1,4) board_left_top(1,4)];
edge_y = [ board_left_top(2,4) board_left_bottom(2,4) board_right_bottom(2,4) board_right_top(2,4) board_left_top(2,4)];
edge_z = [ board_left_top(3,4) board_left_bottom(3,4) board_right_bottom(3,4) board_right_top(3,4) board_left_top(3,4)];
plot3(edge_x,edge_y,edge_z);
%hold off;
%% ����
%����˼·��һ�β���һ�У�Сѭ���޸�zֵ����ѭ���޸�xֵ
tic
for m = 0:pen_length/delta_dis
    color = [rand rand rand];
    for n = 0:board_width/delta_dis 
        T1 = transl(0,-delta_dis*m,-delta_dis*n)*board_left_bottom;
        T2 = transl(0,-delta_dis*m,-delta_dis*n)*board_right_bottom;
        trajectory =ctraj(T1,T2,board_length/delta_dis);%board_length/delta_dis̫����
        a = ur5_ikine(r,trajectory);
        for i=1:size(a,1)
            %r.plot(a(i,:));
            pos = r.fkine(a(i,:));
            dot_pos = [pos(1,4) pos(2,4) pos(3,4)];
            scatter3(dot_pos(1),dot_pos(2),dot_pos(3),36,color);
        end
    end
end
toc



%  a = ur5_ikine_single(r,left_end);
%  r.plot(a{1});