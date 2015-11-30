function isCollisionHappening = isHittingTopWall(ball_x, ball_y, ball_vx, ball_vy, ball_radius)
%   Determines if a ball is colliding with the bottom wall
    tableWallThickness = 0.1016; %in meters
    tableLength = 2.4384;
    topWall_y = tableLength - tableWallThickness;
    distanceToWall = topWall_y - ball_y;
    isBallMovingTowardWall = ball_vy > 0 ;
    isBallIntersectingWall = distanceToWall <= ball_radius;
    isCollisionHappening = isBallMovingTowardWall && isBallIntersectingWall;
end
