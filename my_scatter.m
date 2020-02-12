function [] =  my_scatter(inf)
% inf = [x y z color_r color_g color_b]
x = inf(1);
y = inf(2);
z = inf(3);
color = [inf(4) inf(5) inf(6)];
figure(1);
scatter3(x,y,z,36,color);
end

