function [decoded_ginal, error] = crc_decoder(signal)
%CRC_DECODER Summary of this function goes here
%   Detailed explanation goes here
poly = [1 0 0 0 0 0 1 0 0 1 1 0 0 0 0 0 1 0 0 0 1 1 1 0 1 1 0 1 1 0 1 1 1];
[decoded_ginal, error] = nrCRCDecode(signal, poly);

end