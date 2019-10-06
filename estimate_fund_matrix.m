function f_matrix = estimate_fund_matrix(matches)
    % computing A
    column_1 = matches(:,1).*matches(:,3);
    column_2 = matches(:,1).*matches(:,4);
    column_3 = matches(:,1);
    column_4 = matches(:,3).*matches(:,2);
    column_5 = matches(:,2).*matches(:,4);
    column_6 = matches(:,2);
    column_7 = matches(:,3);
    column_8 = matches(:,4);
    column_9 = ones(length(matches), 1);
    A = [column_1, column_2, column_3, column_4, column_5, column_6, column_7, column_8, column_9];
    
    % Computing SVD (Singular Value Decomposition of A) to solve for F
    [U S V] = svd(A);
    F1 = V(:,end);
    F2 = [F1(1:3)'; F1(4:6)'; F1(7:9)'];    % reshaping F
    
    % Computing SVD of F and re-estimating F to ensure rank 2
    [UF, SF, VF] = svd(F2);
    SF(:,end) = zeros(size(SF, 1), 1);
    f_matrix = UF * SF * VF';
end