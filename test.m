test_number = 6561;
test_count = 0;

tests = zeros(test_number, 4);

%1st row - first_probability, 2nd row - second_probability,
%3rd row - third_probability, 4th row - fourth_probability
prob_matrix = [10 100 1000; 99999 75000 50000; 100000 10000 1000; 1000 10000 100000];

%1st row - signal_length, 2nd row - max_attempts, 3rd row - coding_param
arq_params = [100 1000 2000; 10 50 100 ; 10 50 100];

% KBS channel testing
% channel_type = "1";
% second_prob_probe = 1;
% third_prob_probe = 1;
% fourth_prob_probe = 1;
% for code_type_probe = 1:3
%     if (code_type_probe == 1)
%         code_type="1";
%     else
%         if (code_type_probe == 2)
%             code_type="2";
%         else
%             code_type="3";
%         end
%     end
%     for  first_prob_probe = 1:3
%         for signal_length_probe = 1:3
%             for max_attempts_probe = 1:3
%                 for coding_param_probe = 1:3
%                     test_count = test_count + 1
%                     [tests(test_count,1), tests(test_count,2), tests(test_count,3), tests(test_count,4)] = arq_main(arq_params(1,signal_length_probe), ...
%                         arq_params(2,max_attempts_probe), code_type, arq_params(3,coding_param_probe), channel_type, ...
%                         prob_matrix(1, first_prob_probe),  prob_matrix(2, second_prob_probe), ...
%                         prob_matrix(3, third_prob_probe),  prob_matrix(4, fourth_prob_probe));
%                 end
%             end    
%         end
%     end
% end

% Gilbert channel testing
channel_type = "2";
for code_type_probe = 1:3
    if (code_type_probe == 1)
        code_type="1";
    else
        if (code_type_probe == 2)
            code_type="2";
        else
            code_type="3";
        end
    end
    for  first_prob_probe = 1:3
        for  second_prob_probe = 1:3
            for  third_prob_probe = 1:3
                for  fourth_prob_probe = 1:3
                    for signal_length_probe = 1:3
                        for max_attempts_probe = 1:3
                            for coding_param_probe = 1:3
                                test_count = test_count + 1
                                [tests(test_count,1), tests(test_count,2), tests(test_count,3), tests(test_count,4)] = arq_main(arq_params(1,signal_length_probe), ...
                                    arq_params(2,max_attempts_probe), code_type, arq_params(3,coding_param_probe), channel_type, ...
                                    prob_matrix(1, first_prob_probe),  prob_matrix(2, second_prob_probe), ...
                                    prob_matrix(3, third_prob_probe),  prob_matrix(4, fourth_prob_probe));
                            end
                        end    
                    end
                end
            end
        end
    end
end

%write to xlsx
filename = 'tests2.xlsx';
writematrix(tests,filename,'Sheet',1,'Range','A2:D6561')