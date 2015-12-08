function isCollisionHappening = isHittingWall(ball_x, ball_y, ball_vx, ball_vy, ball_radius, wall_start, wall_end)
%   Determines if a ball is colliding with the bottom wall
    wall = wall_end - wall_start;
    ball = [ball_x; ball_y];
    velocity = [ball_vx; ball_vy];
    ballToWallStart = wall_start - ball;
    orthogonalProjection = orthogonalProject(ballToWallStart, wall);
    distanceToWall = norm(orthogonalProjection);
    velocityInWallDirection=project(velocity, orthogonalProjection)
    isBallMovingTowardWall = ball_vy < 0 ;
    isBallIntersectingWall = distanceToWall <= ball_radius;
    isCollisionHappening = isBallMovingTowardWall && isBallIntersectingWall;
end