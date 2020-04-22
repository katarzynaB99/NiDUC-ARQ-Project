function [encoded_signal] = crc_coder(signal)
%CRC_CODER Summary of this function goes here
%   Detailed explanation goes here
poly = 'z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1';
crc32 = comm.CRCGenerator('Polynomial', poly);

encoded_signal = crc32(signal);

end

