function isCollisionHappening = isHittingLeftWall(ball_x, ball_y, ball_vx, ball_vy, ball_radius, tableWidth, tableWallThickness)
%   Determines if a ball is colliding with the Left wall
    leftWall_x = 0 + tableWallThickness;
    distanceToWall = ball_x - leftWall_x;
    isBallMovingTowardWall = ball_vx < 0 ;
    isBallIntersectingWall = distanceToWall <= ball_radius;
    isCollisionHappening = isBallMovingTowardWall && isBallIntersectingWall;
end