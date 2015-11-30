% tic
profile on
timeSeries = simulateOneBall(0.5, 0.3, 13, 45);
% timeseries = (initial x, initial y, initial velocity, initial angle)
profile viewer
Time = timeSeries(:,1);
X = timeSeries(:,2);
Y = timeSeries(:,3);
Vx = timeSeries(:,4);
Vy = timeSeries(:,5);

clf
%comet(X,Y)
% xlabel('horizontal position (m)')
% ylabel('vertical position (m)')
% title ('ball position')
% pause
 plot (Time, Vx)
% xlabel('Time (s)')
% ylabel('horizontal velocity (m/s)')
% % title('ball horizontal velocity')
%  pause
% plot(Time, Vy)
% xlabel('Time (s)')
% ylabel('vertical velocity (m/s)')
% title('ball vertical velocity')
disp(Time(end))
