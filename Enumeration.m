r = creat_ur5('right',transl(0,-0.544,0)); %�ֱʻ�����

%% ������������
if isempty(gcp('nocreate')) %���֮ǰû�п���parpool������
    parpool(maxNumCompThreads);  %��Ϊ����ʹ�ú���
end
%% ��������
board_length = 3; %�峤
board_width = 3; %���
pen_length = 0.05; %�ʳ�
left_end = transl(0,0,0) * trotx(-0.5*pi);
delta_dis = 0.03; %ÿ����֮��ļ��
% �����Ľǵ�λ��
board_left_top = transl(board_length/2,0,board_width/2)*left_end;
board_left_bottom = transl(board_length/2,0,-board_width/2)*left_end;
board_right_top = transl(-board_length/2,0,board_width/2)*left_end;
board_right_bottom = transl(-board_length/2,0,-board_width/2)*left_end;

%% ����ֽ�ŵı�Ե
% hold on;
% trplot(left_end);
% edge_x = [ board_left_top(1,4) board_left_bottom(1,4) board_right_bottom(1,4) board_right_top(1,4) board_left_top(1,4)];
% edge_y = [ board_left_top(2,4) board_left_bottom(2,4) board_right_bottom(2,4) board_right_top(2,4) board_left_top(2,4)];
% edge_z = [ board_left_top(3,4) board_left_bottom(3,4) board_right_bottom(3,4) board_right_top(3,4) board_left_top(3,4)];
% plot3(edge_x,edge_y,edge_z);
%hold off;
%% ����
%����˼·��һ�β���һ�У�Сѭ���޸�zֵ����ѭ���޸�xֵ
color_singularity = [251 98 112]; %д�ֵ�·����ɫ
color_safe = [36 201 179]; %̧�ʵ�·����ɫ
a3 = -392.25;
a2 = -425;
d5 = 94.56;
diff_upper_limit = 0.5;
pixel_length = round(board_length/delta_dis);
pixel_width = round(board_width/delta_dis);
%% ����һ���հ�ͼƬ
img_blank = uint8(255*ones(pixel_width,pixel_length,3));
tic
parfor m = 1:round(pen_length/delta_dis)
    img_name = ['.\output\' num2str(m) '.png'];
    img_result = img_blank;
    for n = 1:pixel_width 
        T1 = transl(0,-delta_dis*m,-delta_dis*n)*board_left_top;
        T2 = transl(0,-delta_dis*m,-delta_dis*n)*board_right_top;
        trajectory =ctraj(T1,T2,pixel_length);
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
            diff = round(abs(([board_left_top(3,4) board_left_top(1,4)] - [pos(3,4) pos(1,4)])/delta_dis));
            
            img_result(diff(1),diff(2),:) = color;
        end
    end

    imwrite(img_result,img_name);
end
toc



%  a = ur5_ikine_single(r,left_end);
%  r.plot(a{1});