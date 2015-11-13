function inCircle = isInCircle(point_x, point_y, circle_x, circle_y, circle_radius)
%   Determine if a point is in a circle
    distance = sqrt((circle_x - point_x)^2 + (circle_y - point_y)^2);
    inCircle = distance <= circle_radius;
end

