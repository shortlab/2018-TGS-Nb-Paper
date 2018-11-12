function [peak,errs,ft]=fit_spectra_peaks_interact(fft,plotty)
%Feed function a power spectral density and it will return the position of
%the peak and the error in the gaussian fitting

fft=fft(1:floor(0.2*end),:);

% fft=fft(2500:end,:);%added 7/31/16 for irr_cu_16 processing
% 
% [mx_val,ind]=max(fft(:,2)); 
% 
% min_pct_fit=0.50;
% 
% pos_ind=ind;
% go_p=1;
% while go_p
%     pos_ind=pos_ind+1;
%     if fft(pos_ind,2)<=min_pct_fit*mx_val
%         go_p=0;
%     end
% end
% 
% neg_ind=ind;
% go_n=1;
% while go_n
%     neg_ind=neg_ind-1;
%     if fft(neg_ind,2)<=min_pct_fit*mx_val
%         go_n=0;
%     end
% end

figure()
plot(fft(:,1),fft(:,2),'k-');
hold on
[x_cord,y_cord]=ginput(2);

neg_x_cord=x_cord(1);
pos_x_cord=x_cord(2);

[~,neg_ind]=min(abs(fft(:,1)-neg_x_cord));
[~,pos_ind]=min(abs(fft(:,1)-pos_x_cord));

pk_trace=fft(neg_ind:pos_ind,:);

% This is the gaussian fitting for the peaks, which doesn't do so hot but
% is good enough
ft=fit(pk_trace(:,1),pk_trace(:,2),'gauss1');
peak=ft.b1;
error_mat=confint(ft,0.95);
errs=[peak-error_mat(1,2); error_mat(2,2)-peak];

if plotty
    figure()
    plot(pk_trace(:,1),ft(pk_trace(:,1)),pk_trace(:,1),pk_trace(:,2));
end

%Below is a record of some previous peak fitting procedures that I tried at
%some point.

% Try a center of mass weighting method to find the peak position
% % peak=(sum(pk_trace(:,1).*pk_trace(:,2)))/(sum(pk_trace(:,2)));
% % errs=[];
% % ft=[];

close all
end