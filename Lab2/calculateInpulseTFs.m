function [TFs,f_axis] = calculateInpulseTFs(hammer,microphones,windows, hop, Fs)

    [~,idx] = findpeaks(hammer, 'MinPeakHeight', 0.02);
    TFs = zeros(height(microphones),length(idx),height(windows),length(windows)/2+1);
    for j = 1:length(idx)
        if j == length(idx)
            start = idx(j);
            finish = length(microphones);
        else
            start = idx(j);
            finish = idx(j+1);
        end
        ham_hit = hammer(start:finish);
        for i = 1:height(microphones)
            for k = 1:height(windows)
                imp_resp = microphones(i,start:finish);
                [TFs(i,j,k,:), f_axis] = tfestimate(ham_hit, imp_resp, windows(k,:), hop, length(windows), Fs);
            end
        end    
    end
end