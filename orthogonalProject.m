function orthogonalProjection = orthogonalProject(A, B)
%   Takes the orthogonal projection of Vector A on Vector B
    projection = project(A, B);
    orthogonalProjection = A - projection;
end