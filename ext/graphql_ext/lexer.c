
#line 1 "ext/graphql_ext/lexer.rl"

#line 117 "ext/graphql_ext/lexer.rl"



static const char _graphql_c_lexer_trans_keys[] = {
	4, 22, 4, 43, 14, 47, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 49, 4, 22,
	4, 4, 4, 4, 4, 22, 4, 4,
	4, 4, 14, 15, 14, 15, 10, 15,
	12, 12, 0, 49, 0, 0, 4, 22,
	4, 4, 4, 4, 4, 4, 4, 22,
	4, 4, 4, 4, 1, 1, 14, 15,
	10, 29, 14, 15, 10, 29, 10, 29,
	12, 12, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	14, 46, 14, 46, 14, 46, 14, 46,
	0
};

static const char _graphql_c_lexer_char_class[] = {
	0, 1, 2, 2, 1, 2, 2, 2,
	2, 2, 2, 2, 2, 2, 2, 2,
	2, 2, 2, 2, 2, 2, 2, 0,
	3, 4, 5, 6, 2, 7, 2, 8,
	9, 2, 10, 0, 11, 12, 13, 14,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 16, 2, 2, 17, 2, 2, 18,
	19, 19, 19, 19, 20, 19, 19, 19,
	19, 19, 19, 19, 19, 19, 19, 19,
	19, 19, 19, 19, 19, 19, 19, 19,
	19, 19, 21, 22, 23, 2, 24, 2,
	25, 26, 27, 28, 29, 30, 31, 32,
	33, 19, 19, 34, 35, 36, 37, 38,
	39, 40, 41, 42, 43, 44, 19, 45,
	46, 19, 47, 48, 49, 0
};

static const short _graphql_c_lexer_index_offsets[] = {
	0, 19, 59, 93, 126, 159, 192, 225,
	258, 291, 324, 360, 379, 380, 381, 400,
	401, 402, 404, 406, 412, 413, 463, 464,
	483, 484, 485, 486, 505, 506, 507, 508,
	510, 530, 532, 552, 572, 573, 606, 639,
	672, 705, 738, 771, 804, 837, 870, 903,
	936, 969, 1002, 1035, 1068, 1101, 1134, 1167,
	1200, 1233, 1266, 1299, 1332, 1365, 1398, 1431,
	1464, 1497, 1530, 1563, 1596, 1629, 1662, 1695,
	1728, 1761, 1794, 1827, 1860, 1893, 1926, 1959,
	1992, 2025, 2058, 2091, 2124, 2157, 2190, 2223,
	2256, 2289, 2322, 2355, 2388, 2421, 2454, 2487,
	2520, 2553, 2586, 2619, 2652, 2685, 2718, 2751,
	2784, 2817, 2850, 2883, 2916, 2949, 2982, 3015,
	3048, 3081, 3114, 3147, 3180, 3213, 3246, 3279,
	3312, 3345, 3378, 3411, 3444, 3477, 3510, 3543,
	3576, 3609, 3642, 3675, 0
};

static const short _graphql_c_lexer_indicies[] = {
	2, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 3, 1, 0, 0, 0, 0,
	0, 0, 0, 0, 1, 0, 0, 0,
	0, 0, 0, 0, 0, 1, 0, 0,
	0, 1, 0, 0, 0, 1, 0, 0,
	0, 0, 0, 1, 0, 0, 0, 1,
	0, 1, 4, 5, 5, 0, 0, 0,
	5, 5, 0, 0, 0, 0, 5, 5,
	5, 5, 5, 5, 5, 5, 5, 5,
	5, 5, 5, 5, 5, 5, 5, 5,
	5, 5, 5, 5, 6, 7, 7, 0,
	0, 0, 7, 7, 0, 0, 0, 0,
	7, 7, 7, 7, 7, 7, 7, 7,
	7, 7, 7, 7, 7, 7, 7, 7,
	7, 7, 7, 7, 7, 7, 8, 8,
	0, 0, 0, 8, 8, 0, 0, 0,
	0, 8, 8, 8, 8, 8, 8, 8,
	8, 8, 8, 8, 8, 8, 8, 8,
	8, 8, 8, 8, 8, 8, 8, 1,
	1, 0, 0, 0, 1, 1, 0, 0,
	0, 0, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1,
	9, 9, 0, 0, 0, 9, 9, 0,
	0, 0, 0, 9, 9, 9, 9, 9,
	9, 9, 9, 9, 9, 9, 9, 9,
	9, 9, 9, 9, 9, 9, 9, 9,
	9, 10, 10, 0, 0, 0, 10, 10,
	0, 0, 0, 0, 10, 10, 10, 10,
	10, 10, 10, 10, 10, 10, 10, 10,
	10, 10, 10, 10, 10, 10, 10, 10,
	10, 10, 11, 11, 0, 0, 0, 11,
	11, 0, 0, 0, 0, 11, 11, 11,
	11, 11, 11, 11, 11, 11, 11, 11,
	11, 11, 11, 11, 11, 11, 11, 11,
	11, 11, 11, 12, 12, 0, 0, 0,
	12, 12, 0, 0, 0, 0, 12, 12,
	12, 12, 12, 12, 12, 12, 12, 12,
	12, 12, 12, 12, 12, 12, 12, 12,
	12, 12, 12, 12, 12, 12, 0, 0,
	0, 12, 12, 0, 0, 0, 0, 12,
	12, 12, 12, 12, 12, 12, 12, 12,
	12, 12, 12, 12, 12, 12, 12, 12,
	12, 12, 12, 12, 12, 0, 0, 1,
	15, 14, 14, 14, 14, 14, 14, 14,
	14, 14, 14, 14, 14, 14, 14, 14,
	14, 14, 16, 17, 18, 19, 14, 14,
	14, 14, 14, 14, 14, 14, 14, 14,
	14, 14, 14, 14, 14, 14, 14, 16,
	20, 21, 22, 22, 24, 24, 25, 25,
	13, 13, 22, 22, 26, 28, 29, 27,
	30, 31, 32, 33, 34, 35, 36, 27,
	37, 38, 27, 39, 40, 41, 42, 43,
	44, 44, 45, 27, 46, 44, 44, 44,
	44, 47, 48, 49, 44, 44, 50, 44,
	51, 52, 53, 44, 54, 55, 56, 57,
	58, 44, 44, 44, 59, 60, 61, 28,
	64, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 3, 14, 67, 68, 69, 14,
	14, 14, 14, 14, 14, 14, 14, 14,
	14, 14, 14, 14, 14, 14, 14, 14,
	16, 70, 18, 71, 39, 40, 25, 25,
	73, 72, 22, 22, 72, 72, 72, 72,
	74, 72, 72, 72, 72, 72, 72, 72,
	72, 74, 22, 22, 25, 25, 75, 75,
	24, 24, 75, 75, 75, 75, 74, 75,
	75, 75, 75, 75, 75, 75, 75, 74,
	25, 25, 73, 72, 40, 40, 72, 72,
	72, 72, 74, 72, 72, 72, 72, 72,
	72, 72, 72, 74, 76, 44, 44, 13,
	13, 13, 44, 44, 13, 13, 13, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 78, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 79, 44, 44, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 80,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 81, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 82, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 83, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 84, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	44, 44, 44, 44, 85, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 86, 44, 44, 44,
	44, 44, 44, 44, 44, 87, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 88, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 89, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 90, 44, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 91, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 92, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 93, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	94, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 95,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 96, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 97, 44, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 98,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 99, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 44, 44, 100, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	101, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 44, 102, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 103, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 104, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 105, 106, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	107, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 108, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 109, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	110, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 44, 111, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 112, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 113, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 114, 44, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	115, 44, 44, 44, 116, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 117, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 118, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	44, 44, 119, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 120, 44,
	44, 44, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	44, 44, 44, 44, 44, 121, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 122, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 123, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 124,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 125, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 126, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 127, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	128, 44, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	129, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 130, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 131, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 132, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 133, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 134, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 135, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 136, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	44, 44, 44, 44, 137, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	138, 44, 44, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 139,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 140,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 141, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 142, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 143, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	144, 44, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	145, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 146, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 147, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 148,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 149, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 150, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 151, 44, 44,
	44, 44, 44, 44, 152, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 153,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 154,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 155,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 156, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 157, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 158, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 159, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 160, 44, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	161, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 162, 44,
	44, 44, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	163, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 164, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 165, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 166, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	167, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	168, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 169, 44, 44,
	44, 44, 44, 170, 44, 44, 77, 77,
	77, 44, 44, 77, 77, 77, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 171, 44, 44, 44, 44, 44, 77,
	77, 77, 44, 44, 77, 77, 77, 44,
	44, 44, 44, 44, 172, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	77, 77, 77, 44, 44, 77, 77, 77,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 173, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 77, 77, 77, 44, 44, 77, 77,
	77, 44, 44, 44, 44, 44, 174, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 77, 77, 77, 44, 44, 77,
	77, 77, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 175, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 77, 77, 77, 44, 44,
	77, 77, 77, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 176, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 77, 77, 77, 44,
	44, 77, 77, 77, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 177, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 44, 77, 77, 77,
	44, 44, 77, 77, 77, 44, 44, 44,
	44, 44, 44, 44, 44, 44, 44, 44,
	44, 178, 44, 44, 44, 44, 44, 44,
	44, 44, 44, 44, 0
};

static const char _graphql_c_lexer_index_defaults[] = {
	1, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 14, 14, 14, 14, 14,
	14, 13, 23, 13, 0, 27, 62, 1,
	65, 66, 66, 14, 14, 14, 32, 63,
	72, 75, 75, 72, 63, 13, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 77, 77, 77, 77,
	77, 77, 77, 77, 0
};

static const char _graphql_c_lexer_trans_cond_spaces[] = {
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, 0
};

static const short _graphql_c_lexer_cond_targs[] = {
	21, 0, 21, 1, 2, 3, 6, 4,
	5, 7, 8, 9, 10, 21, 11, 12,
	14, 13, 25, 15, 16, 27, 33, 21,
	34, 17, 21, 21, 22, 21, 21, 23,
	30, 21, 21, 21, 21, 31, 36, 32,
	35, 21, 21, 21, 37, 21, 21, 38,
	46, 53, 63, 81, 88, 91, 92, 96,
	105, 123, 128, 21, 21, 21, 21, 21,
	24, 21, 21, 26, 21, 28, 29, 21,
	21, 18, 19, 21, 20, 21, 39, 40,
	41, 42, 43, 44, 45, 37, 47, 49,
	48, 37, 50, 51, 52, 37, 54, 57,
	55, 56, 37, 58, 59, 60, 61, 62,
	37, 64, 72, 65, 66, 67, 68, 69,
	70, 71, 37, 73, 75, 74, 37, 76,
	77, 78, 79, 80, 37, 82, 83, 84,
	85, 86, 87, 37, 89, 90, 37, 37,
	93, 94, 95, 37, 97, 98, 99, 100,
	101, 102, 103, 104, 37, 106, 113, 107,
	110, 108, 109, 37, 111, 112, 37, 114,
	115, 116, 117, 118, 119, 120, 121, 122,
	37, 124, 126, 125, 37, 127, 37, 129,
	130, 131, 37, 0
};

static const char _graphql_c_lexer_cond_actions[] = {
	1, 0, 2, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 3, 0, 0,
	0, 0, 0, 0, 0, 4, 0, 5,
	6, 0, 7, 10, 0, 11, 12, 13,
	0, 14, 15, 16, 17, 0, 13, 18,
	18, 19, 20, 21, 22, 23, 24, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 25, 26, 27, 28, 29,
	30, 31, 32, 0, 33, 4, 4, 34,
	35, 0, 0, 36, 0, 37, 0, 0,
	0, 0, 0, 0, 0, 38, 0, 0,
	0, 39, 0, 0, 0, 40, 0, 0,
	0, 0, 41, 0, 0, 0, 0, 0,
	42, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 43, 0, 0, 0, 44, 0,
	0, 0, 0, 0, 45, 0, 0, 0,
	0, 0, 0, 46, 0, 0, 47, 48,
	0, 0, 0, 49, 0, 0, 0, 0,
	0, 0, 0, 0, 50, 0, 0, 0,
	0, 0, 0, 51, 0, 0, 52, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	53, 0, 0, 0, 54, 0, 55, 0,
	0, 0, 56, 0
};

static const char _graphql_c_lexer_to_state_actions[] = {
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 8, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0
};

static const char _graphql_c_lexer_from_state_actions[] = {
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 9, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0
};

static const char _graphql_c_lexer_eof_trans[] = {
	1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 14, 14, 14, 14, 14,
	14, 14, 24, 14, 1, 0, 63, 64,
	66, 67, 67, 67, 67, 67, 72, 64,
	73, 76, 76, 73, 64, 14, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 78, 78, 78, 78,
	78, 78, 78, 78, 0
};

static const char _graphql_c_lexer_nfa_targs[] = {
	0, 0
};

static const char _graphql_c_lexer_nfa_offsets[] = {
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0
};

static const char _graphql_c_lexer_nfa_push_actions[] = {
	0, 0
};

static const char _graphql_c_lexer_nfa_pop_trans[] = {
	0, 0
};

static const int graphql_c_lexer_start = 21;
static const int graphql_c_lexer_first_final = 21;
static const int graphql_c_lexer_error = -1;

static const int graphql_c_lexer_en_main = 21;


#line 120 "ext/graphql_ext/lexer.rl"


#include <ruby.h>

typedef enum TokenType {
	INT,
	FLOAT,
	ON,
	FRAGMENT,
	TRUE_LITERAL,
	FALSE_LITERAL,
	NULL_LITERAL,
	QUERY,
	MUTATION,
	SUBSCRIPTION,
	SCHEMA,
	SCALAR,
	TYPE,
	EXTEND,
	IMPLEMENTS,
	INTERFACE,
	UNION,
	ENUM,
	INPUT,
	DIRECTIVE,
	REPEATABLE,
	RCURLY,
	LCURLY,
	RPAREN,
	LPAREN,
	RBRACKET,
	LBRACKET,
	COLON,
	QUOTED_STRING,
	BLOCK_STRING,
	VAR_SIGN,
	DIR_SIGN,
	ELLIPSIS,
	EQUALS,
	BANG,
	PIPE,
	AMP,
	IDENTIFIER,
	COMMENT,
	UNKNOWN_CHAR
} TokenType;

typedef struct Meta {
	int line;
	int col;
	char *query_cstr;
	char *pe;
	VALUE tokens;
	VALUE previous_token;
} Meta;

#define STATIC_VALUE_TOKEN(token_type, content_str) \
case token_type: \
token_sym = ID2SYM(rb_intern(#token_type)); \
token_content = rb_str_new_cstr(content_str); \
break;

#define DYNAMIC_VALUE_TOKEN(token_type) \
case token_type: \
token_sym = ID2SYM(rb_intern(#token_type)); \
token_content = rb_utf8_str_new(ts, te - ts); \
break;

void emit(TokenType tt, char *ts, char *te, Meta *meta) {
	int quotes_length = 0; // set by string tokens below
	int line_incr = 0;
	VALUE token_sym = Qnil;
	VALUE token_content = Qnil;
	
	switch(tt) {
		STATIC_VALUE_TOKEN(ON, "on")
		STATIC_VALUE_TOKEN(FRAGMENT, "fragment")
		STATIC_VALUE_TOKEN(QUERY, "query")
		STATIC_VALUE_TOKEN(MUTATION, "mutation")
		STATIC_VALUE_TOKEN(SUBSCRIPTION, "subscription")
		STATIC_VALUE_TOKEN(REPEATABLE, "repeatable")
		STATIC_VALUE_TOKEN(RCURLY, "}")
	STATIC_VALUE_TOKEN(LCURLY, "{")
		STATIC_VALUE_TOKEN(RBRACKET, "]")
		STATIC_VALUE_TOKEN(LBRACKET, "[")
		STATIC_VALUE_TOKEN(RPAREN, ")")
		STATIC_VALUE_TOKEN(LPAREN, "(")
		STATIC_VALUE_TOKEN(COLON, ":")
		STATIC_VALUE_TOKEN(VAR_SIGN, "$")
		STATIC_VALUE_TOKEN(DIR_SIGN, "@")
		STATIC_VALUE_TOKEN(ELLIPSIS, "...")
		STATIC_VALUE_TOKEN(EQUALS, "=")
		STATIC_VALUE_TOKEN(BANG, "!")
		STATIC_VALUE_TOKEN(PIPE, "|")
		STATIC_VALUE_TOKEN(AMP, "&")
		STATIC_VALUE_TOKEN(SCHEMA, "schema")
		STATIC_VALUE_TOKEN(SCALAR, "scalar")
		STATIC_VALUE_TOKEN(TYPE, "type")
		STATIC_VALUE_TOKEN(EXTEND, "extend")
		STATIC_VALUE_TOKEN(IMPLEMENTS, "implements")
		STATIC_VALUE_TOKEN(INTERFACE, "interface")
		STATIC_VALUE_TOKEN(UNION, "union")
		STATIC_VALUE_TOKEN(ENUM, "enum")
		STATIC_VALUE_TOKEN(DIRECTIVE, "directive")
		STATIC_VALUE_TOKEN(INPUT, "input")
		// For these, the enum name doesn't match the symbol name:
		case TRUE_LITERAL:
		token_sym = ID2SYM(rb_intern("TRUE"));
		token_content = rb_str_new_cstr("true");
		break;
		case FALSE_LITERAL:
		token_sym = ID2SYM(rb_intern("FALSE"));
		token_content = rb_str_new_cstr("false");
		break;
		case NULL_LITERAL:
		token_sym = ID2SYM(rb_intern("NULL"));
		token_content = rb_str_new_cstr("null");
		break;
		DYNAMIC_VALUE_TOKEN(IDENTIFIER)
		DYNAMIC_VALUE_TOKEN(INT)
		DYNAMIC_VALUE_TOKEN(FLOAT)
		DYNAMIC_VALUE_TOKEN(COMMENT)
		case UNKNOWN_CHAR:
		if (ts[0] == '\0') {
			return;
		} else {
			token_content = rb_utf8_str_new(ts, te - ts);
			token_sym = ID2SYM(rb_intern("UNKNOWN_CHAR"));
			break;
		}
		case QUOTED_STRING:
		quotes_length = 1;
		token_content = rb_utf8_str_new(ts + quotes_length, (te - ts - (2 * quotes_length)));
		token_sym = ID2SYM(rb_intern("STRING"));
		break;
		case BLOCK_STRING:
		token_sym = ID2SYM(rb_intern("STRING"));
		quotes_length = 3;
		token_content = rb_utf8_str_new(ts + quotes_length, (te - ts - (2 * quotes_length)));
		line_incr = FIX2INT(rb_funcall(token_content, rb_intern("count"), 1, rb_str_new_cstr("\n")));
		break;
	}
	
	if (token_sym != Qnil) {
		if (tt == BLOCK_STRING || tt == QUOTED_STRING) {
			VALUE mGraphQL = rb_const_get_at(rb_cObject, rb_intern("GraphQL"));
			VALUE mGraphQLLanguage = rb_const_get_at(mGraphQL, rb_intern("Language"));
			VALUE mGraphQLLanguageLexer = rb_const_get_at(mGraphQLLanguage, rb_intern("Lexer"));
			VALUE valid_string_pattern = rb_const_get_at(mGraphQLLanguageLexer, rb_intern("VALID_STRING"));
			if (tt == BLOCK_STRING) {
				VALUE mGraphQLLanguageBlockString = rb_const_get_at(mGraphQLLanguage, rb_intern("BlockString"));
				token_content = rb_funcall(mGraphQLLanguageBlockString, rb_intern("trim_whitespace"), 1, token_content);
			}
			
			if (
			RB_TEST(rb_funcall(token_content, rb_intern("valid_encoding?"), 0)) &&
			RB_TEST(rb_funcall(token_content, rb_intern("match?"), 1, valid_string_pattern))
			) {
				rb_funcall(mGraphQLLanguageLexer, rb_intern("replace_escaped_characters_in_place"), 1, token_content);
				if (!RB_TEST(rb_funcall(token_content, rb_intern("valid_encoding?"), 0))) {
					token_sym = ID2SYM(rb_intern("BAD_UNICODE_ESCAPE"));
				}
				
				
			} else {
				token_sym = ID2SYM(rb_intern("BAD_UNICODE_ESCAPE"));
			}
		}
		
		VALUE token_data[5] = {
			token_sym,
			rb_int2inum(meta->line),
			rb_int2inum(meta->col),
			token_content,
			meta->previous_token,
		};
		VALUE token = rb_ary_new_from_values(5, token_data);
		// COMMENTs are retained as `previous_token` but aren't pushed to the normal token list
		if (tt != COMMENT) {
			rb_ary_push(meta->tokens, token);
		}
		meta->previous_token = token;
	}
	// Bump the column counter for the next token
	meta->col += te - ts;
	meta->line += line_incr;
}

VALUE tokenize(VALUE query_rbstr) {
	int cs, act = 0;
	char *p = StringValueCStr(query_rbstr);
	char *pe = p + strlen(p) + 1;
	char *eof = NULL;
	char *ts, *te;
	VALUE tokens = rb_ary_new();
	
	struct Meta meta_s = {1, 1, p, pe, tokens, Qnil};
	Meta *meta = &meta_s;
	
	
	{
		cs = (int)graphql_c_lexer_start;
		ts = 0;
		te = 0;
		act = 0;
	}
	
	#line 319 "ext/graphql_ext/lexer.rl"
	
	
	{
		int _trans = 0;
		const char *_keys;
		const short *_inds;
		{
			if ( p == pe )
			goto _test_eof;
			_resume:  {
				switch ( _graphql_c_lexer_from_state_actions[cs] ) {
					case 9:  {
						{
							#line 1 "NONE"
							{ts = p;}}
						break; }
				}
				
				_keys = ( _graphql_c_lexer_trans_keys + ((cs<<1)));
				_inds = ( _graphql_c_lexer_indicies + (_graphql_c_lexer_index_offsets[cs]));
				
				if ( ( (*( p))) <= 125 && ( (*( p))) >= 9 )
				{
					int _ic = (int)_graphql_c_lexer_char_class[(int)( (*( p))) - 9];
					if ( _ic <= (int)(*( _keys+1)) && _ic >= (int)(*( _keys)) )
					_trans = (int)(*( _inds + (int)( _ic - (int)(*( _keys)) ) )); 
					else
					_trans = (int)_graphql_c_lexer_index_defaults[cs];
				}
				else {
					_trans = (int)_graphql_c_lexer_index_defaults[cs];
				}
				
				goto _match_cond;
			}
			_match_cond:  {
				cs = (int)_graphql_c_lexer_cond_targs[_trans];
				
				if ( _graphql_c_lexer_cond_actions[_trans] == 0 )
				goto _again;
				
				switch ( _graphql_c_lexer_cond_actions[_trans] ) {
					case 13:  {
						{
							#line 1 "NONE"
							{te = p+1;}}
						break; }
					case 27:  {
						{
							#line 89 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 89 "ext/graphql_ext/lexer.rl"
									emit(RCURLY, ts, te, meta); }}}
						break; }
					case 25:  {
						{
							#line 90 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 90 "ext/graphql_ext/lexer.rl"
									emit(LCURLY, ts, te, meta); }}}
						break; }
					case 17:  {
						{
							#line 91 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 91 "ext/graphql_ext/lexer.rl"
									emit(RPAREN, ts, te, meta); }}}
						break; }
					case 16:  {
						{
							#line 92 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 92 "ext/graphql_ext/lexer.rl"
									emit(LPAREN, ts, te, meta); }}}
						break; }
					case 24:  {
						{
							#line 93 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 93 "ext/graphql_ext/lexer.rl"
									emit(RBRACKET, ts, te, meta); }}}
						break; }
					case 23:  {
						{
							#line 94 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 94 "ext/graphql_ext/lexer.rl"
									emit(LBRACKET, ts, te, meta); }}}
						break; }
					case 19:  {
						{
							#line 95 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 95 "ext/graphql_ext/lexer.rl"
									emit(COLON, ts, te, meta); }}}
						break; }
					case 2:  {
						{
							#line 96 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 96 "ext/graphql_ext/lexer.rl"
									emit(QUOTED_STRING, ts, te, meta); }}}
						break; }
					case 33:  {
						{
							#line 97 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 97 "ext/graphql_ext/lexer.rl"
									emit(BLOCK_STRING, ts, te, meta); }}}
						break; }
					case 14:  {
						{
							#line 98 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 98 "ext/graphql_ext/lexer.rl"
									emit(VAR_SIGN, ts, te, meta); }}}
						break; }
					case 21:  {
						{
							#line 99 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 99 "ext/graphql_ext/lexer.rl"
									emit(DIR_SIGN, ts, te, meta); }}}
						break; }
					case 7:  {
						{
							#line 100 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 100 "ext/graphql_ext/lexer.rl"
									emit(ELLIPSIS, ts, te, meta); }}}
						break; }
					case 20:  {
						{
							#line 101 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 101 "ext/graphql_ext/lexer.rl"
									emit(EQUALS, ts, te, meta); }}}
						break; }
					case 12:  {
						{
							#line 102 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 102 "ext/graphql_ext/lexer.rl"
									emit(BANG, ts, te, meta); }}}
						break; }
					case 26:  {
						{
							#line 103 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 103 "ext/graphql_ext/lexer.rl"
									emit(PIPE, ts, te, meta); }}}
						break; }
					case 15:  {
						{
							#line 104 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 104 "ext/graphql_ext/lexer.rl"
									emit(AMP, ts, te, meta); }}}
						break; }
					case 11:  {
						{
							#line 108 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 108 "ext/graphql_ext/lexer.rl"
									
									meta->line += 1;
									meta->col = 1;
								}}}
						break; }
					case 10:  {
						{
							#line 115 "ext/graphql_ext/lexer.rl"
							{te = p+1;{
									#line 115 "ext/graphql_ext/lexer.rl"
									emit(UNKNOWN_CHAR, ts, te, meta); }}}
						break; }
					case 35:  {
						{
							#line 68 "ext/graphql_ext/lexer.rl"
							{te = p;p = p - 1;{
									#line 68 "ext/graphql_ext/lexer.rl"
									emit(INT, ts, te, meta); }}}
						break; }
					case 36:  {
						{
							#line 69 "ext/graphql_ext/lexer.rl"
							{te = p;p = p - 1;{
									#line 69 "ext/graphql_ext/lexer.rl"
									emit(FLOAT, ts, te, meta); }}}
						break; }
					case 31:  {
						{
							#line 96 "ext/graphql_ext/lexer.rl"
							{te = p;p = p - 1;{
									#line 96 "ext/graphql_ext/lexer.rl"
									emit(QUOTED_STRING, ts, te, meta); }}}
						break; }
					case 32:  {
						{
							#line 97 "ext/graphql_ext/lexer.rl"
							{te = p;p = p - 1;{
									#line 97 "ext/graphql_ext/lexer.rl"
									emit(BLOCK_STRING, ts, te, meta); }}}
						break; }
					case 37:  {
						{
							#line 105 "ext/graphql_ext/lexer.rl"
							{te = p;p = p - 1;{
									#line 105 "ext/graphql_ext/lexer.rl"
									emit(IDENTIFIER, ts, te, meta); }}}
						break; }
					case 34:  {
						{
							#line 106 "ext/graphql_ext/lexer.rl"
							{te = p;p = p - 1;{
									#line 106 "ext/graphql_ext/lexer.rl"
									emit(COMMENT, ts, te, meta); }}}
						break; }
					case 28:  {
						{
							#line 113 "ext/graphql_ext/lexer.rl"
							{te = p;p = p - 1;{
									#line 113 "ext/graphql_ext/lexer.rl"
									meta->col += te - ts; }}}
						break; }
					case 29:  {
						{
							#line 115 "ext/graphql_ext/lexer.rl"
							{te = p;p = p - 1;{
									#line 115 "ext/graphql_ext/lexer.rl"
									emit(UNKNOWN_CHAR, ts, te, meta); }}}
						break; }
					case 5:  {
						{
							#line 68 "ext/graphql_ext/lexer.rl"
							{p = ((te))-1;
								{
									#line 68 "ext/graphql_ext/lexer.rl"
									emit(INT, ts, te, meta); }}}
						break; }
					case 1:  {
						{
							#line 115 "ext/graphql_ext/lexer.rl"
							{p = ((te))-1;
								{
									#line 115 "ext/graphql_ext/lexer.rl"
									emit(UNKNOWN_CHAR, ts, te, meta); }}}
						break; }
					case 3:  {
						{
							#line 1 "NONE"
							{switch( act ) {
									case 1:  {
										p = ((te))-1;
										{
											#line 68 "ext/graphql_ext/lexer.rl"
											emit(INT, ts, te, meta); } break; }
									case 2:  {
										p = ((te))-1;
										{
											#line 69 "ext/graphql_ext/lexer.rl"
											emit(FLOAT, ts, te, meta); } break; }
									case 3:  {
										p = ((te))-1;
										{
											#line 70 "ext/graphql_ext/lexer.rl"
											emit(ON, ts, te, meta); } break; }
									case 4:  {
										p = ((te))-1;
										{
											#line 71 "ext/graphql_ext/lexer.rl"
											emit(FRAGMENT, ts, te, meta); } break; }
									case 5:  {
										p = ((te))-1;
										{
											#line 72 "ext/graphql_ext/lexer.rl"
											emit(TRUE_LITERAL, ts, te, meta); } break; }
									case 6:  {
										p = ((te))-1;
										{
											#line 73 "ext/graphql_ext/lexer.rl"
											emit(FALSE_LITERAL, ts, te, meta); } break; }
									case 7:  {
										p = ((te))-1;
										{
											#line 74 "ext/graphql_ext/lexer.rl"
											emit(NULL_LITERAL, ts, te, meta); } break; }
									case 8:  {
										p = ((te))-1;
										{
											#line 75 "ext/graphql_ext/lexer.rl"
											emit(QUERY, ts, te, meta); } break; }
									case 9:  {
										p = ((te))-1;
										{
											#line 76 "ext/graphql_ext/lexer.rl"
											emit(MUTATION, ts, te, meta); } break; }
									case 10:  {
										p = ((te))-1;
										{
											#line 77 "ext/graphql_ext/lexer.rl"
											emit(SUBSCRIPTION, ts, te, meta); } break; }
									case 11:  {
										p = ((te))-1;
										{
											#line 78 "ext/graphql_ext/lexer.rl"
											emit(SCHEMA, ts, te, meta); } break; }
									case 12:  {
										p = ((te))-1;
										{
											#line 79 "ext/graphql_ext/lexer.rl"
											emit(SCALAR, ts, te, meta); } break; }
									case 13:  {
										p = ((te))-1;
										{
											#line 80 "ext/graphql_ext/lexer.rl"
											emit(TYPE, ts, te, meta); } break; }
									case 14:  {
										p = ((te))-1;
										{
											#line 81 "ext/graphql_ext/lexer.rl"
											emit(EXTEND, ts, te, meta); } break; }
									case 15:  {
										p = ((te))-1;
										{
											#line 82 "ext/graphql_ext/lexer.rl"
											emit(IMPLEMENTS, ts, te, meta); } break; }
									case 16:  {
										p = ((te))-1;
										{
											#line 83 "ext/graphql_ext/lexer.rl"
											emit(INTERFACE, ts, te, meta); } break; }
									case 17:  {
										p = ((te))-1;
										{
											#line 84 "ext/graphql_ext/lexer.rl"
											emit(UNION, ts, te, meta); } break; }
									case 18:  {
										p = ((te))-1;
										{
											#line 85 "ext/graphql_ext/lexer.rl"
											emit(ENUM, ts, te, meta); } break; }
									case 19:  {
										p = ((te))-1;
										{
											#line 86 "ext/graphql_ext/lexer.rl"
											emit(INPUT, ts, te, meta); } break; }
									case 20:  {
										p = ((te))-1;
										{
											#line 87 "ext/graphql_ext/lexer.rl"
											emit(DIRECTIVE, ts, te, meta); } break; }
									case 21:  {
										p = ((te))-1;
										{
											#line 88 "ext/graphql_ext/lexer.rl"
											emit(REPEATABLE, ts, te, meta); } break; }
									case 29:  {
										p = ((te))-1;
										{
											#line 96 "ext/graphql_ext/lexer.rl"
											emit(QUOTED_STRING, ts, te, meta); } break; }
									case 30:  {
										p = ((te))-1;
										{
											#line 97 "ext/graphql_ext/lexer.rl"
											emit(BLOCK_STRING, ts, te, meta); } break; }
									case 38:  {
										p = ((te))-1;
										{
											#line 105 "ext/graphql_ext/lexer.rl"
											emit(IDENTIFIER, ts, te, meta); } break; }
								}}
						}
						break; }
					case 18:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 68 "ext/graphql_ext/lexer.rl"
							{act = 1;}}
						break; }
					case 6:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 69 "ext/graphql_ext/lexer.rl"
							{act = 2;}}
						break; }
					case 48:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 70 "ext/graphql_ext/lexer.rl"
							{act = 3;}}
						break; }
					case 42:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 71 "ext/graphql_ext/lexer.rl"
							{act = 4;}}
						break; }
					case 54:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 72 "ext/graphql_ext/lexer.rl"
							{act = 5;}}
						break; }
					case 41:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 73 "ext/graphql_ext/lexer.rl"
							{act = 6;}}
						break; }
					case 47:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 74 "ext/graphql_ext/lexer.rl"
							{act = 7;}}
						break; }
					case 49:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 75 "ext/graphql_ext/lexer.rl"
							{act = 8;}}
						break; }
					case 46:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 76 "ext/graphql_ext/lexer.rl"
							{act = 9;}}
						break; }
					case 53:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 77 "ext/graphql_ext/lexer.rl"
							{act = 10;}}
						break; }
					case 52:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 78 "ext/graphql_ext/lexer.rl"
							{act = 11;}}
						break; }
					case 51:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 79 "ext/graphql_ext/lexer.rl"
							{act = 12;}}
						break; }
					case 55:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 80 "ext/graphql_ext/lexer.rl"
							{act = 13;}}
						break; }
					case 40:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 81 "ext/graphql_ext/lexer.rl"
							{act = 14;}}
						break; }
					case 43:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 82 "ext/graphql_ext/lexer.rl"
							{act = 15;}}
						break; }
					case 45:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 83 "ext/graphql_ext/lexer.rl"
							{act = 16;}}
						break; }
					case 56:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 84 "ext/graphql_ext/lexer.rl"
							{act = 17;}}
						break; }
					case 39:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 85 "ext/graphql_ext/lexer.rl"
							{act = 18;}}
						break; }
					case 44:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 86 "ext/graphql_ext/lexer.rl"
							{act = 19;}}
						break; }
					case 38:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 87 "ext/graphql_ext/lexer.rl"
							{act = 20;}}
						break; }
					case 50:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 88 "ext/graphql_ext/lexer.rl"
							{act = 21;}}
						break; }
					case 30:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 96 "ext/graphql_ext/lexer.rl"
							{act = 29;}}
						break; }
					case 4:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 97 "ext/graphql_ext/lexer.rl"
							{act = 30;}}
						break; }
					case 22:  {
						{
							#line 1 "NONE"
							{te = p+1;}}	{
							#line 105 "ext/graphql_ext/lexer.rl"
							{act = 38;}}
						break; }
				}
				
				
			}
			_again:  {
				switch ( _graphql_c_lexer_to_state_actions[cs] ) {
					case 8:  {
						{
							#line 1 "NONE"
							{ts = 0;}}
						break; }
				}
				
				p+= 1;
				if ( p != pe )
				goto _resume;
			}
			_test_eof:  { {}
				if ( p == eof )
				{
					if ( _graphql_c_lexer_eof_trans[cs] > 0 ) {
						_trans = (int)_graphql_c_lexer_eof_trans[cs] - 1;
						goto _match_cond;
					}
				}
				
			}
		}
	}
	
	#line 320 "ext/graphql_ext/lexer.rl"
	
	return tokens;
}
