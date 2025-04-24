function xt = Inv_Fourier(Xjw)
    Xjw_shift = ifftshift(Xjw);
    xt = ifft(Xjw_shift);
end
