function [FTs, f_axis] = computeFTs(hammer,in, sz)

    [~,idx] = findpeaks(hammer, 'MinPeakHeight', 0.02);
    FTs = zeros(height(in),length(idx),sz/2);
    for j = 1:length(idx)
        if j == length(idx)
            start = idx(j);
            finish = length(in);
        else
            start = idx(j);
            finish = idx(j+1);
        end
        imp_resp = in(:,start:finish).';
        [app, f_axis] = ffg(imp_resp,sz,1/12500);
        FTs(:,j,:) = reshape(app.',width(imp_resp),1,sz/2);
    end

end