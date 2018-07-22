function [im, LX, LY] = ridgeDetector(DT, ensDT, type)
im = zeros(size(DT));

%     [LX, LY] = gradient(DT);
%     [LXX, LXY] = gradient(LX);
%     [LYX, LYY] = gradient(LY);

[LX, LY] = imgradientxy(DT);
[LXX, LXY] = imgradientxy(LX);
[LYX, LYY] = imgradientxy(LY);
GM = sqrt(LX.^2 + LY.^2);

if (strcmp(type, 'gradient magnitude'))
    epslon = 4;
    %     im(GM < epslon) = 1;
    im(abs(LX) < epslon & abs(LY) < epslon) = 1;
    
    if (~isempty(ensDT))
        im((ensDT{1} == 0 & ensDT{2} ~= 0) | (ensDT{1} ~= 0 & ensDT{2} == 0)) = 0;
    end
end

if (strcmp(type, 'ridge'))
   FX = cell(1, size(ensDT, 2));
   FY = cell(1, size(ensDT, 2));
   GM = cell(1, size(ensDT, 2));
%     [Fx1, Fy1] = imgradient(ensDT{1});
%     GM1 = sqrt(Fx1.^2 + Fy1.^2);
%     [Fx2, Fy2] = imgradient(ensDT{2});
%     GM2 = sqrt(Fx2.^2 + Fy2.^2);
    
    mask = zeros(size(DT));
    for i = 1 : size(ensDT, 2)
        mask(DT >= ensDT{i}) = i;
        
        [fx, fy] = imgradient(ensDT{i});
        gm = sqrt(fx.^2 + fy.^2);
        FX{i} = fx;
        FY{i} = fy;
        GM{i} = gm;
    end
    
%     figure; 
%     subplot(1,2,1)
%     imshow(GM1, []); colormap(jet); colorbar
%     subplot(1,2,2)
%     imshow(GM2, []); colormap(jet);colorbar
%     figure;
%     subplot(1,2,1)
%     imshow(Fx1, []);colormap(jet); colorbar
%     subplot(1,2,2)
%     imshow(Fx2, []); colormap(jet);colorbar
%     figure;
%     subplot(1,2,1)
%     imshow(Fy1, []); colormap(jet);colorbar
%     subplot(1,2,2)
%     imshow(Fy2, []); colormap(jet);colorbar
    figure
    imshow(mask, []); colormap(jet); colorbar
    
    padMask = padarray(mask, [1, 1], inf);
    l = padMask(2:end-1, 1:end-2);
    u = padMask(1:end-2, 2:end-1);
    r = padMask(2:end-1, 3:end);
    b = padMask(3:end, 2:end-1);
    
    zc_v  = (u~=inf & b~=inf) & (u~=b);
    zc_v = u(zc_v)
    zc_h  = (l~=inf & r~=inf) & (l~=r);
    
    zc_locations  = (zc_h|zc_v);
    im(zc_locations) = 1;
%     im(Fy1.*Fy2 > 0) = 0;
%     im(ensDT{1} < 0.1 & ensDT{2} < 0.1) = 1;
end

















% 
%   [cos_eig, sin_eig, L_1, L_2] =  PS1z3a_get_hessian_orientation(LXX,LYY,LXY);
%     
%     Lpp = L_1;
%     Lqq = L_2;
%     Vpp1 = -sin_eig;
%     Vpp2 = cos_eig;
%     
%     LP = Vpp1.*LX + Vpp2.*LY;
%     cond = ((abs(Lpp) > abs(Lqq)) & (Lpp <= 0)) | ((abs(Lpp) < abs(Lqq)) & (Lqq <= 0)); %*(L_1<L_2);
%     %     cond = ((abs(Lpp) > abs(Lqq)) & (Lpp <= 0) & (abs(Lqq) < thres)) | ((abs(Lpp) < abs(Lqq)) & (Lqq <= 0) & (abs(Lpp) < thres)); %*(L_1<L_2);
%     
%     padLP = padarray(LP, [1, 1], inf);
%     l = padLP(2:end-1, 1:end-2);
%     u = padLP(1:end-2, 2:end-1);
%     r = padLP(2:end-1, 3:end);
%     b = padLP(3:end, 2:end-1);
%     
%     zc_v  = u.*b < 0;
%     zc_h  = l.*r<0;
%     
%     zc_locations  = (zc_h|zc_v);
%     im(zc_locations & cond) = 1;
%     
%     figure('units','normalized','outerposition',[0 0 1 1])
%     subplot(2,1,1)
%     imshow(Lpp, []); colormap(jet);colorbar; title('kappa 1')
%     subplot(2,1,2)
%     imshow(Lqq, []); colormap(jet);colorbar; title('kappa 2')
%     figure
%     imshow(LP, []); colormap(jet);colorbar; title('First order derivative along kappa 1')
%     
%     figure
%     imshow(LX, []); colormap(jet);colorbar; title('dx')
%     
%     figure
%     imshow(LY, []); colormap(jet);colorbar; title('dy')
%     
%     figure
%     imshow(GM, []); colormap(jet);colorbar; title('GM')
% 



%     figure
%     subplot(1,3,1)
%     imagesc(LX)
%     colorbar
%     subplot(1,3,2)
%     imagesc(LY)
%     subplot(1,3,3)
%     imagesc(GM)
%     colorbar

% common = (LXX - LYY)./(sqrt((LXX - LYY).^2 + 4*(LXY.^2)));
% cosB = sqrt(0.5*(1 + common));
% sinB = sign(LXY).*sqrt(0.5*(1 - common));
%
% Lp = sinB.*LX - cosB.*LY;
% Lq = cosB.*LX + sinB.*LY;
%
% Lpp = (sinB.^2).*LXX - 2*sinB.*cosB.*LXY + (cosB.^2).*LYY;
% Lqq = (cosB.^2).*LXX + 2*sinB.*cosB.*LXY + (sinB.^2).*LYY;
%
% % im((abs(Lpp) > abs(Lqq) & Lp == 0 & Lpp < 0) | (abs(Lpp) < abs(Lqq) & Lq == 0 & Lqq < 0)) = 1;
% im(abs(Lp) < 1e-3  & abs(Lq) < 1e-3) = 1;
%
%
% for i = 1:size(DT, 1)
%     for j = 1:size(DT, 2)
%         Lx = LX(i, j);
%         Ly = LY(i, j);
%         Lxx = LXX(i, j);
%         Lxy = LXY(i, j);
%         Lyy = LYY(i, j);
%
%
%
%
%     end
% end
%             Luv = LX*Ly*(LXx - Lyy) - (LX^2 - Ly^2)*LXy;
%             Luu2subvv2 = (Ly^2 - LX^2)*(LXx - Lyy) - 4*LX*Ly*LXy;
%             Luu = (LX^2)*Lyy - 2*LX*Ly*LXy + (Ly^2)*LXx;
%
%             if (Luv == 0 && Luu2subvv2 > 0 && Luu < 0)
%                 im(i, j) = 1;
%             end


%         Lpp = zeros(size(DT));
%         Lqq = zeros(size(DT));
%         Vpp1 = zeros(size(DT));
%         Vpp2 = zeros(size(DT));
%         Vqq1 = zeros(size(DT));
%         Vqq2 = zeros(size(DT));
%         for i = 1:size(DT, 1)
%             for j = 1:size(DT, 2)
%                 Lx = LX(i, j);
%                 Ly = LY(i, j);
%                 Lxx = LXX(i, j);
%                 Lxy = LXY(i, j);
%                 Lyy = LYY(i, j);
%
%                 hessian = [Lxx, Lxy; Lxy, Lyy];
%                 [eigvec, eigval] = eig(hessian);
%                 Lpp(i, j) = eigval(1, 1);
%                 Lqq(i, j) = eigval(2, 2);
%                 Vpp1(i, j) = eigvec(1, 1);
%                 Vpp2(i, j) = eigvec(2, 1);
%                 Vqq1(i, j) = eigvec(1, 2);
%                 Vqq2(i, j) = eigvec(2, 2);
%             end
%         end
%
% [cos_eig, sin_eig, L_1, L_2] =  PS1z3a_get_hessian_orientation(LXX,LYY,LXY);
% % LPPEnr = sqrt(cos_eig.^2+sin_eig.^2);
%
% LP1 = cos_eig.*LX + sin_eig.*LY;
% LP2 = Vpp1.*LX + Vpp2.*LY;
% cond = ((abs(L_1) > abs(L_2)) & (L_1 < 0) & (L_2 == 0)) | ((abs(L_1) < abs(L_2)) & (L_2 < 0) & (L_1 == 0)); %*(L_1<L_2);
% im(LP1 < 0.1) = 1;

% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,1,1)
% imshow(LP1, []); colormap(jet);colorbar
% subplot(2,1,2)
% imshow(LP2, []); colormap(jet);colorbar
% figure
% imshow(L_1, []); colormap(jet);colorbar
% figure
% imshow(GM, []); colormap(jet);colorbar
% a = 12
%         [cos_eig, sin_eig, L_1, L_2] =  PS1z3a_get_hessian_orientation(LXX,LYY,LXY);
%
%         [ismax, ismin]             =    PS1z3b_maxalong_orientation(LX, LY, cos_eig, sin_eig, L_1, L_2);
%
%         im(logical(ismax)) = 1;
% %


%
%         Luv = LX.*LY.*(LXX - LYY) - (LX.^2 - LY.^2).*LXY;
%         Luu2subvv2 = (LY.^2 - LX.^2).*(LXX - LYY) - 4*LX.*LY.*LXY;
%         Luu = (LX.^2).*LYY - 2*LX.*LY.*LXY + (LY.^2).*LXX;
%
%         im(Luv == 0 & Luu2subvv2 > 0 & Luu < 0) = 1;

%     end
% end
