function [ball_vfx, ball_vfy] = hitHorizontalWall (ball_vix, ball_viy)
    coefficient_of_restitution = 0.804;
    ball_vfx = ball_vix * coefficient_of_restitution;    
    ball_vfy = -ball_viy * coefficient_of_restitution;
end