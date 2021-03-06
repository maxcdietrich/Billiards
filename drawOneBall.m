function timeSeries = drawOneBall(initial_x, initial_y, initial_v, initial_angle )
    tic
    % profile on
    tableWallThickness = 0.1016; %in meters
    tableLength = 2.4384;
    tableWidth = 1.2192;
    timeSeries = simulateOneBall(initial_x, initial_y, initial_v, initial_angle, tableWidth, tableLength, tableWallThickness);
    % timeseries = (initial x, initial y, initial velocity, initial angle)
    % profile viewer
    toc
    Time = timeSeries(:,1);
    X = timeSeries(:,2);
    Y = timeSeries(:,3);
    Vx = timeSeries(:,4);
    Vy = timeSeries(:,5);

  
animate_func(timeSeries)

    function animate_func(timeSeries)
        %timeseries is a multidimensional array
        %each frame in the z axis is a timeseries of 1 ball
        Time = timeSeries(:,1,1);
        X = timeSeries(:,2,:);
        Y = timeSeries(:,3,:);
        limits = [0, 3, 0, 3];

        for i = 1: 2: length(Time)
            clf;
            axis(limits);
            hold on;
            draw_func(X(i,:,:), Y(i,:,:));
            drawnow;
        end
    end
    
    function draw_func(X, Y)
        drawTable(tableWidth, tableLength, tableWallThickness)
        number_of_balls = length(X);
        for ball = 1 : number_of_balls
            plot(X(ball), Y(ball), 'b.', 'MarkerSize', 20);
        end
    end



end
function drawTable(tableWidth, tableLength, tableWallThickness)
        % draws a billiard table 
        %subtract wall thickness twice to get distance from origin
        upper_wall = tableLength - 2 * tableWallThickness;
        right_wall = tableWidth - 2 * tableWallThickness;
        table = [tableWallThickness, tableWallThickness, right_wall, upper_wall];
        rectangle('Position', table, 'FaceColor', 'g')
end