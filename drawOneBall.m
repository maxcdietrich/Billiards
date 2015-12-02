function drawOneBall(initial_x, initial_y, initial_v, initial_angle )
tic
% profile on
timeSeries = simulateOneBall(initial_x, initial_y, initial_v, initial_angle);
% timeseries = (initial x, initial y, initial velocity, initial angle)
% profile viewer
toc
Time = timeSeries(:,1);
X = timeSeries(:,2);
Y = timeSeries(:,3);
Vx = timeSeries(:,4);
Vy = timeSeries(:,5);

comet(X,Y)

% animate_func(timeSeries)
% 
% function animate_func(timeSeries)
%     %timeseries is a multidimensional array
%     %each frame in the z axis is a timeseries of 1 ball
%     Time = timeSeries(:,1,1);
%     X = timeSeries(:,2,:);
%     Y = timeSeries(:,3,:);
%     limits = [0, 3, 0, 3];
%     
%     for i = 1:length(Time)
%         clf;
%         axis(limits);
%         hold on;
%         draw_func(X(i,:,:), Y(i,:,:));
%         drawnow;
%     end
% end
% 
% function draw_func(X, Y)
%     number_of_balls = length(X);
%     for ball = 1 : number_of_balls
%         plot(X(ball), Y(ball), 'MarkerSize', 10);
%     end
% end


end