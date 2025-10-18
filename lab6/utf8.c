#include <stdint.h>
#include <stdio.h>
#include "utf8.h"


void decode_utf8(const char* string) {
    const unsigned char* byte = (const unsigned char*)string;
    
    while (*byte != '\0') {
        uint32_t char_num = 0;
        uint8_t num_bytes = 0;
        
        // one byte
        if ((*byte & 0b10000000) == 0) {
            char_num = *byte;
            num_bytes = 1;
        }

        // two bytes
        else if ((*byte & 0b11100000) == 0b11000000) {
            char_num = (*byte & 0b00011111) << 6;
            byte++;

            char_num |= (*byte & 0b00111111);
            num_bytes = 2;
        }

        // three bytes
        else if ((*byte & 0b11110000) == 0b11100000) {
            char_num = (*byte & 0b00001111) << 12;
            byte++;

            char_num |= (*byte & 0b00111111) << 6;
            byte++;

            char_num |= (*byte & 0b00111111);
            num_bytes = 3;
        }

        // four bytes 
        else if ((*byte & 0b11111000) == 0b11110000) {
            char_num = (*byte & 0b00000111) << 18;
            byte++;

            char_num |= (*byte & 0b00111111) << 12;
            byte++;

            char_num |= (*byte & 0b00111111) << 6;
            byte++;

            char_num |= (*byte & 0b00111111);
            num_bytes = 4;
        }
        
        report_character(char_num, num_bytes);
        byte++;
    }
}