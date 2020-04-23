function [ time_taken, bit_error_rate, total_redundancy, attempts_taken ] = arq_main( signal_length, code_type, coding_param, channel_type, first_probability, second_probability )
%ARQ_MAIN Summary of this function goes here
%   Detailed explanation goes here
    bit_error_rate = 0;
    sent_bits_sum = 0;
    time_taken = 0;
    total_redundancy = 0;
    
    tic
    generated_signal = signal_generator(signal_length);
    encoded_signal = [];
   
    if code_type == '1'
        %Bit parzystosci
        encoded_signal = parity_bit_encoder(generated_signal, coding_param);
        total_redundancy = length(encoded_signal) - signal_length;
    else
        if code_type == '2'
            %Suma kontrolna
            encoded_signal = control_sum_coder(generated_signal, coding_param);
            total_redundancy = coding_param;
        else
            %CRC
            encoded_signal = crc_coder(generated_signal);
            total_redundancy = 32;
        end
    end
    
    encoded_signal_length = length(encoded_signal);
    
    status = 100;
    error = 0;
    received_signal = [];
    decoded_signal = [];
    error_number = 0;
    attempts_taken = 0
    if channel_type == '1'
        %KBS
        while status
            [received_signal, error_number] = KBS_channel(encoded_signal, first_probability);
            bit_error_rate = bit_error_rate + error_number;
            sent_bits_sum = sent_bits_sum + encoded_signal_length;
            if code_type == '1'
                %Bit parzystosci
                [decoded_signal, error] = parity_bit_decoder(received_signal, coding_param);
            else
                if code_type == '2'
                    %Suma kontrolna
                    [decoded_signal, error] = control_sum_decoder(received_signal, coding_param);
                else
                    %CRC
                    [decoded_signal, error] = crc_decoder(received_signal);
                end
            end
            
            if error == 0
                status = 0;
            else
                status = status - 1;
            end
            attempts_taken = attempts_taken + 1;
        end
        
    else
        %Gilbert
        while status
            [received_signal, error_number] = gilbert_channel(encoded_signal, first_probability, second_probability);
            bit_error_rate = bit_error_rate + error_number;
            sent_bits_sum = sent_bits_sum + encoded_signal_length;
            if code_type == '1'
                %Bit parzystosci
                [decoded_signal, error] = parity_bit_decoder(received_signal, coding_param);
            else
                if code_type == '2'
                    %Suma kontrolna
                    [decoded_signal, error] = control_sum_decoder(received_signal, coding_param);
                else
                    %CRC
                    [decoded_signal, error] = crc_decoder(received_signal);
                end
            end
            
            if error == 0
                status = 0;
            else
                status = status - 1;
            end
            attempts_taken = attempts_taken + 1;
        end
    end
    time_taken = toc;
    bit_error_rate = bit_error_rate / sent_bits_sum;
    
    %disp(time_taken);
    %disp(bit_error_rate);
    %disp(total_redundancy);
    %disp(code_type);
    %disp(channel_type);
    
end

