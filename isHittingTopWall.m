function isCollisionHappening = isHittingTopWall(ball_x, ball_y, ball_vx, ball_vy, ball_radius, tableLength, tableWallThickness)
%   Determines if a ball is colliding with the top wall
    topWall_y = tableLength - tableWallThickness;
    distanceToWall = topWall_y - ball_y;
    isBallMovingTowardWall = ball_vy > 0 ;
    isBallIntersectingWall = distanceToWall <= ball_radius;
    isCollisionHappening = isBallMovingTowardWall && isBallIntersectingWall;
end
