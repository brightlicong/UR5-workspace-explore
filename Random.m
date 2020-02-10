r = creat_ur5('right',transl(0,-0.544,0));

board_length = 1;
board_width = 0.7 ;
pen_length = 0.1;
left_end = transl(0,0,-0.2) * trotx(1/6*pi);
%left_end = transl(0.4,0,0) * trotx(1/2*pi);

board_left_head = left_end*transl(board_length/2,board_width/2,0);
board_left_tail = left_end*transl(board_length/2,-board_width/2,0);
board_right_head = left_end*transl(-board_length/2,board_width/2,0);
board_right_tail = left_end*transl(-board_length/2,-board_width/2,0);
hold on;
trplot(left_end);
edge_x = [ board_left_head(1,4) board_left_tail(1,4) board_right_tail(1,4) board_right_head(1,4) board_left_head(1,4)];
edge_y = [ board_left_head(2,4) board_left_tail(2,4) board_right_tail(2,4) board_right_head(2,4) board_left_head(2,4)];
edge_z = [ board_left_head(3,4) board_left_tail(3,4) board_right_tail(3,4) board_right_head(3,4) board_left_head(3,4)];
plot3(edge_x,edge_y,edge_z);

times = 10000000;
qList = zeros(times,6);
for i = 1:times
    q = rand(1,6)*pi;
    qList(i,:) = q ;
end

a = [board_length/2 board_length/2 -board_width/2 -board_width/2 board_length/2]; 
b = [board_width/2 -board_width/2 -board_width/2 board_width/2 board_width/2]; 
%plot3(a,b,[0 0 0 0 0]);
count = 0;

for i = 1:times
    robot_end = r.fkine(qList(i,:));
    T = r.fkine(qList(i,:))*transl(0,0,pen_length);
    dis =  inv(left_end)*T;
    dis_x = dis(1,4);
    dis_y = dis(2,4);
    dis_z = dis(3,4);
    if  abs(dis_z) < 0.01 && dis(3,3)<-0.75
        %set(gca,'xtick',-2:1:2)        
        %set(gca,'ytick',-2:1:2) 
        %set(gca,'ztick',-2:1:2)
        count = count + 1;
        %trplot(dis);
        %trplot(robot_end);
        plot2(T(1:3,4)','*','color','r');
        %plot2([dis_x dis_y dis_z],'*','color','b');
        
        if count > 200
            trplot(robot_end)
            r.plot(qList(i,:));
            break;
        end
        
    end
end


%r.teach();