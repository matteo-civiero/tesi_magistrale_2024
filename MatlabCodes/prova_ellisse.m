clear all;
close all;

th = 0:0.2:2*pi;
initRobotShape = Rmat(pi/2)*[-0.01, 0.01, 0.01, -0.01; 0.8, 0.8, -0.8, -0.8]; % square
b = max(initRobotShape(2, :))*(1 + 0.2);
a = sqrt(b^2 * initRobotShape(1,1)^2 / (b^2 - initRobotShape(2,1)^2));
xe = a * cos(th);
ye = b * sin(th);
safe_shape = [xe; ye];
figure;
hold on;
plot(polyshape(initRobotShape(1,:), initRobotShape(2,:)), "EdgeColor","green");
plot(polyshape(safe_shape(1,:), safe_shape(2,:)), "EdgeColor","red");
xlim([-1.5, 1.5]);
ylim([-1.5, 1.5]);