close all
clear
clc

% Parameters
% path_name = 'E:\Github\StatisticalRendering\Voreen\data';
path_name = '../voreen-src-4.4-win/data/';

data_folder = 'Cylinder';
data_name = 'Cylinder';
data_dir = sprintf('%s/%s/', path_name, data_folder);
raw_file_name = sprintf('%s/%s_64.raw', data_dir, data_name);

% Read Raw Volume
[scalarVolume, I1, I2, I3, S1, S2, S3] = readRawVolume(data_folder, raw_file_name);

curvature = zeros(size(scalarVolume));
curvature2 = zeros(size(scalarVolume));
[fx, fy, fz] = gradient(scalarVolume);

[gxx, gxy, gxz] = gradient(fx);
[gyx, gyy, gyz] = gradient(fy);
[gzx, gzy, gzz] = gradient(fz);

 
for i = 1 : I1
    for j = 1 : I2
        for k = 1 : I3
            % Hessian
            H = [gxx(i, j, k), gxy(i, j, k), gxz(i, j, k);
                 gyx(i, j, k), gyy(i, j, k), gyz(i, j, k);
                 gzx(i, j, k), gzy(i, j, k), gzz(i, j, k)];
            g = [fx(i, j, k), fy(i, j, k), fz(i, j, k)];
            n = [0, 0, 0];
            if norm(g) ~= 0
                n = -g / norm(g);
            end
            
            nnT = zeros(3, 3);
            nnT(1, 1) = n(1) * n(1);
            nnT(1, 2) = n(1) * n(2);
            nnT(1, 3) = n(1) * n(3);
            nnT(2, 1) = n(2) * n(1);
            nnT(2, 2) = n(2) * n(2);
            nnT(2, 3) = n(2) * n(3);
            nnT(3, 1) = n(3) * n(1);
            nnT(3, 2) = n(3) * n(2);
            nnT(3, 3) = n(3) * n(3);
            
            P = eye(3) - nnT;
            
            G = zeros(3, 3);
            if norm(g) ~= 0
                G = -P*H*P / norm(g);
            end
            
            tt = trace(G);
            
            % compute Frobenius norm of G
            F = 0.0;
            F = F + abs(G(1, 1)) ^ 2;
            F = F + abs(G(1, 2)) ^ 2;
            F = F + abs(G(1, 3)) ^ 2;
            F = F + abs(G(2, 1)) ^ 2;
            F = F + abs(G(2, 2)) ^ 2;
            F = F + abs(G(2, 3)) ^ 2;
            F = F + abs(G(3, 1)) ^ 2;
            F = F + abs(G(3, 2)) ^ 2;
            F = F + abs(G(3, 3)) ^ 2;
            F = sqrt(F);
            
            kappa1 = (tt + sqrt(2.0 * (F*F) - (tt*tt))) / 2.0;
            kappa2 = (tt - sqrt(2.0 * (F*F) - (tt*tt))) / 2.0;
            
            v = [-2.0, 3.0, 0.0]';
            kv = dot(v, G * v) / dot(v, P * v);   % kappa along v
    
            curvature(i, j, k) = kappa1;
            curvature2(i, j, k) = kv;
        end
    end
end

subplot(1,2,1)
scatter(scalarVolume(:), curvature(:));
subplot(1,2,2)
scatter(scalarVolume(:), curvature2(:));
