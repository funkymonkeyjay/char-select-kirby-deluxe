Lights1 dedede_cap_wing_Bronto_Burt_Skin_lights = gdSPDefLights1(
	0x7F, 0x32, 0x48,
	0xFF, 0x6C, 0x95, 0x28, 0x28, 0x28);

Lights1 dedede_cap_wing_Bronto_Burt_Face_2_lights = gdSPDefLights1(
	0x7F, 0x32, 0x48,
	0xFF, 0x6C, 0x95, 0x28, 0x28, 0x28);

Lights1 dedede_cap_wing_Bronto_Burt_Shoe_lights = gdSPDefLights1(
	0x7F, 0x66, 0x0,
	0xFF, 0xCF, 0x0, 0x28, 0x28, 0x28);

Texture dedede_cap_wing_Bronto_Burt_Face_2_ci4[] = {
	#include "actors/dedede_cap_wing/Bronto_Burt_Face_2.ci4.inc.c"
};

Texture dedede_cap_wing_Bronto_Burt_Face_2_pal_rgba16[] = {
	#include "actors/dedede_cap_wing/Bronto_Burt_Face_2.rgba16.pal"
};

Texture dedede_cap_wing_Bronto_Burt_Wing_ci8[] = {
	#include "actors/dedede_cap_wing/Bronto_Burt_Wing.ci8.inc.c"
};

Texture dedede_cap_wing_Bronto_Burt_Wing_pal_rgba16[] = {
	#include "actors/dedede_cap_wing/Bronto_Burt_Wing.rgba16.pal"
};

Vtx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_vtx_0[27] = {
	{{{-86, 18, 45}, 0, {752, 837}, {0xCB, 0x92, 0x22, 0xFF}}},
	{{{-150, 62, 32}, 0, {752, 667}, {0x95, 0xBE, 0x14, 0xFF}}},
	{{{-106, 30, -70}, 0, {624, 667}, {0xB6, 0xA5, 0xCF, 0xFF}}},
	{{{-122, 100, -108}, 0, {624, 496}, {0xA7, 0xE0, 0xAB, 0xFF}}},
	{{{-173, 136, 9}, 0, {752, 496}, {0x81, 0xF9, 0x02, 0xFF}}},
	{{{-155, 235, -22}, 0, {752, 325}, {0x8D, 0x33, 0xEF, 0xFF}}},
	{{{-106, 204, -123}, 0, {624, 325}, {0xB2, 0x1F, 0xA1, 0xFF}}},
	{{{-86, 306, -44}, 0, {624, 155}, {0xBD, 0x67, 0xE0, 0xFF}}},
	{{{0, 281, -127}, 0, {496, 155}, {0x00, 0x52, 0x9F, 0xFF}}},
	{{{0, 328, -51}, 0, {560, -16}, {0x00, 0x79, 0xDA, 0xFF}}},
	{{{86, 306, -44}, 0, {624, 155}, {0x43, 0x67, 0xE0, 0xFF}}},
	{{{106, 204, -123}, 0, {624, 325}, {0x4E, 0x1F, 0xA1, 0xFF}}},
	{{{155, 235, -22}, 0, {752, 325}, {0x73, 0x33, 0xEF, 0xFF}}},
	{{{122, 100, -108}, 0, {624, 496}, {0x59, 0xE0, 0xAB, 0xFF}}},
	{{{173, 136, 9}, 0, {752, 496}, {0x7F, 0xF9, 0x02, 0xFF}}},
	{{{150, 62, 32}, 0, {752, 667}, {0x6B, 0xBE, 0x14, 0xFF}}},
	{{{106, 30, -70}, 0, {624, 667}, {0x4A, 0xA5, 0xCF, 0xFF}}},
	{{{86, 18, 45}, 0, {752, 837}, {0x35, 0x92, 0x22, 0xFF}}},
	{{{0, 17, -111}, 0, {-16, 1008}, {0x00, 0x9E, 0xAF, 0xFF}}},
	{{{0, 85, -156}, 0, {496, 496}, {0x00, 0xD6, 0x88, 0xFF}}},
	{{{0, 191, -165}, 0, {496, 325}, {0x00, 0x11, 0x82, 0xFF}}},
	{{{0, 281, -127}, 0, {-16, 1008}, {0x00, 0x52, 0x9F, 0xFF}}},
	{{{-86, 18, 45}, 0, {624, 837}, {0xCB, 0x92, 0x22, 0xFF}}},
	{{{0, -8, -37}, 0, {496, 837}, {0x00, 0x82, 0xF0, 0xFF}}},
	{{{0, 17, -111}, 0, {496, 667}, {0x00, 0x9E, 0xAF, 0xFF}}},
	{{{86, 18, 45}, 0, {624, 837}, {0x35, 0x92, 0x22, 0xFF}}},
	{{{0, -2, 51}, 0, {560, 1008}, {0x00, 0x87, 0x26, 0xFF}}},
};

Gfx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_tri_0[] = {
	gsSPVertex(dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_vtx_0 + 0, 27, 0),
	gsSP2Triangles(0, 1, 2, 0, 1, 3, 2, 0),
	gsSP2Triangles(1, 4, 3, 0, 5, 3, 4, 0),
	gsSP2Triangles(3, 5, 6, 0, 5, 7, 6, 0),
	gsSP2Triangles(7, 8, 6, 0, 7, 9, 8, 0),
	gsSP2Triangles(10, 8, 9, 0, 10, 11, 8, 0),
	gsSP2Triangles(12, 11, 10, 0, 13, 11, 12, 0),
	gsSP2Triangles(12, 14, 13, 0, 15, 13, 14, 0),
	gsSP2Triangles(15, 16, 13, 0, 17, 16, 15, 0),
	gsSP2Triangles(13, 16, 18, 0, 18, 19, 13, 0),
	gsSP2Triangles(18, 3, 19, 0, 3, 18, 2, 0),
	gsSP2Triangles(19, 3, 20, 0, 3, 6, 20, 0),
	gsSP2Triangles(20, 6, 21, 0, 20, 21, 11, 0),
	gsSP2Triangles(13, 20, 11, 0, 19, 20, 13, 0),
	gsSP2Triangles(22, 2, 23, 0, 24, 23, 2, 0),
	gsSP2Triangles(24, 16, 23, 0, 25, 23, 16, 0),
	gsSP2Triangles(26, 23, 25, 0, 26, 22, 23, 0),
	gsSPEndDisplayList(),
};

Vtx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_vtx_1[23] = {
	{{{0, 332, 38}, 0, {1006, -186}, {0x00, 0x7B, 0x21, 0xFF}}},
	{{{0, 328, -51}, 0, {1006, -371}, {0x00, 0x79, 0xDA, 0xFF}}},
	{{{-86, 306, -44}, 0, {432, -186}, {0xBD, 0x67, 0xE0, 0xFF}}},
	{{{86, 306, -44}, 0, {432, -186}, {0x43, 0x67, 0xE0, 0xFF}}},
	{{{110, 265, 74}, 0, {272, 408}, {0x52, 0x4E, 0x3B, 0xFF}}},
	{{{0, 281, 125}, 0, {1006, 408}, {0x00, 0x54, 0x5F, 0xFF}}},
	{{{-110, 265, 74}, 0, {272, 408}, {0xAE, 0x4E, 0x3B, 0xFF}}},
	{{{-155, 235, -22}, 0, {-445, 204}, {0x8D, 0x33, 0xEF, 0xFF}}},
	{{{-122, 172, 125}, 0, {194, 1239}, {0xA7, 0x16, 0x58, 0xFF}}},
	{{{-173, 136, 9}, 0, {-560, 1036}, {0x81, 0xF9, 0x02, 0xFF}}},
	{{{-106, 93, 133}, 0, {303, 1858}, {0xB6, 0xD1, 0x5C, 0xFF}}},
	{{{-150, 62, 32}, 0, {-406, 1839}, {0x95, 0xBE, 0x14, 0xFF}}},
	{{{-86, 18, 45}, 0, {432, 2224}, {0xCB, 0x92, 0x22, 0xFF}}},
	{{{0, 43, 128}, 0, {1006, 2224}, {0x00, 0xA1, 0x55, 0xFF}}},
	{{{0, -2, 51}, 0, {1006, 2387}, {0x00, 0x87, 0x26, 0xFF}}},
	{{{86, 18, 45}, 0, {432, 2224}, {0x35, 0x92, 0x22, 0xFF}}},
	{{{106, 93, 133}, 0, {303, 1858}, {0x4A, 0xD1, 0x5C, 0xFF}}},
	{{{150, 62, 32}, 0, {-406, 1839}, {0x6B, 0xBE, 0x14, 0xFF}}},
	{{{173, 136, 9}, 0, {-560, 1036}, {0x7F, 0xF9, 0x02, 0xFF}}},
	{{{122, 172, 125}, 0, {194, 1239}, {0x59, 0x16, 0x58, 0xFF}}},
	{{{155, 235, -22}, 0, {-445, 204}, {0x73, 0x33, 0xEF, 0xFF}}},
	{{{0, 187, 174}, 0, {1006, 1239}, {0x00, 0x21, 0x7B, 0xFF}}},
	{{{0, 106, 174}, 0, {1006, 1858}, {0x00, 0xDE, 0x7A, 0xFF}}},
};

Gfx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_tri_1[] = {
	gsSPVertex(dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_vtx_1 + 0, 23, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 3, 1, 0),
	gsSP2Triangles(4, 3, 0, 0, 5, 4, 0, 0),
	gsSP2Triangles(5, 0, 6, 0, 6, 0, 2, 0),
	gsSP2Triangles(6, 2, 7, 0, 6, 7, 8, 0),
	gsSP2Triangles(7, 9, 8, 0, 10, 8, 9, 0),
	gsSP2Triangles(10, 9, 11, 0, 12, 10, 11, 0),
	gsSP2Triangles(12, 13, 10, 0, 14, 13, 12, 0),
	gsSP2Triangles(14, 15, 13, 0, 15, 16, 13, 0),
	gsSP2Triangles(15, 17, 16, 0, 16, 17, 18, 0),
	gsSP2Triangles(16, 18, 19, 0, 20, 19, 18, 0),
	gsSP2Triangles(4, 19, 20, 0, 4, 20, 3, 0),
	gsSP2Triangles(4, 21, 19, 0, 5, 21, 4, 0),
	gsSP2Triangles(5, 6, 21, 0, 6, 8, 21, 0),
	gsSP2Triangles(22, 21, 8, 0, 22, 8, 10, 0),
	gsSP2Triangles(22, 10, 13, 0, 22, 13, 16, 0),
	gsSP2Triangles(22, 16, 19, 0, 22, 19, 21, 0),
	gsSPEndDisplayList(),
};

Vtx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_vtx_2[54] = {
	{{{-91, 24, 173}, 0, {-16, -16}, {0xCF, 0xBB, 0x5F, 0xFF}}},
	{{{-145, 137, 228}, 0, {-16, -16}, {0xCF, 0xBB, 0x5F, 0xFF}}},
	{{{-213, 159, 209}, 0, {-16, -16}, {0xCF, 0xBB, 0x5F, 0xFF}}},
	{{{-177, 19, 125}, 0, {-16, -16}, {0xCF, 0xBB, 0x5F, 0xFF}}},
	{{{-239, 115, 163}, 0, {-16, 1008}, {0xCF, 0xBB, 0x5F, 0xFF}}},
	{{{-121, 1, 140}, 0, {-16, -16}, {0xCF, 0xBB, 0x5F, 0xFF}}},
	{{{-239, 115, 163}, 0, {-16, 1008}, {0x9E, 0xCD, 0x40, 0xFF}}},
	{{{-183, 19, 92}, 0, {-16, -16}, {0xBA, 0xAA, 0xC2, 0xFF}}},
	{{{-177, 19, 125}, 0, {-16, -16}, {0xBC, 0xA0, 0x2F, 0xFF}}},
	{{{-248, 122, 141}, 0, {-16, -16}, {0x89, 0x10, 0xD6, 0xFF}}},
	{{{-220, 190, 206}, 0, {-16, -16}, {0xBE, 0x60, 0x34, 0xFF}}},
	{{{-213, 159, 209}, 0, {-16, -16}, {0xBD, 0xE4, 0x69, 0xFF}}},
	{{{-145, 137, 228}, 0, {-16, -16}, {0xF3, 0xE4, 0x7B, 0xFF}}},
	{{{-125, 153, 226}, 0, {-16, -16}, {0x41, 0x3E, 0x5A, 0xFF}}},
	{{{-59, 31, 165}, 0, {-16, -16}, {0x66, 0xCC, 0x36, 0xFF}}},
	{{{-91, 24, 173}, 0, {-16, -16}, {0x09, 0xAC, 0x5F, 0xFF}}},
	{{{-102, -6, 113}, 0, {-16, 1008}, {0x1B, 0x87, 0xE5, 0xFF}}},
	{{{-121, 1, 140}, 0, {-16, -16}, {0xEA, 0x91, 0x3A, 0xFF}}},
	{{{-70, 35, 77}, 0, {-16, -16}, {0x52, 0xDD, 0xA6, 0xFF}}},
	{{{-64, 95, 142}, 0, {-16, -16}, {0x73, 0x36, 0x00, 0xFF}}},
	{{{-110, 125, 84}, 0, {-16, -16}, {0x2B, 0x51, 0xA8, 0xFF}}},
	{{{-164, 73, 66}, 0, {-16, -16}, {0xDB, 0x09, 0x87, 0xFF}}},
	{{{-183, 19, 92}, 0, {-16, 1008}, {0xBA, 0xAA, 0xC2, 0xFF}}},
	{{{-102, -6, 113}, 0, {-16, -16}, {0x1B, 0x87, 0xE5, 0xFF}}},
	{{{-121, 1, 140}, 0, {-16, -16}, {0xEA, 0x91, 0x3A, 0xFF}}},
	{{{-169, 179, 150}, 0, {-16, -16}, {0x0B, 0x74, 0xCE, 0xFF}}},
	{{{-169, 179, 150}, 0, {-16, 1008}, {0x0B, 0x74, 0xCE, 0xFF}}},
	{{{213, 159, 209}, 0, {-16, -16}, {0x31, 0xBB, 0x5F, 0xFF}}},
	{{{145, 137, 228}, 0, {-16, -16}, {0x31, 0xBB, 0x5F, 0xFF}}},
	{{{91, 24, 173}, 0, {-16, -16}, {0x31, 0xBB, 0x5F, 0xFF}}},
	{{{177, 19, 125}, 0, {-16, -16}, {0x31, 0xBB, 0x5F, 0xFF}}},
	{{{121, 1, 140}, 0, {-16, -16}, {0x31, 0xBB, 0x5F, 0xFF}}},
	{{{239, 115, 163}, 0, {-16, 1008}, {0x31, 0xBB, 0x5F, 0xFF}}},
	{{{239, 115, 163}, 0, {-16, 1008}, {0x62, 0xCD, 0x40, 0xFF}}},
	{{{177, 19, 125}, 0, {-16, -16}, {0x44, 0xA0, 0x2F, 0xFF}}},
	{{{183, 19, 92}, 0, {-16, -16}, {0x46, 0xAA, 0xC2, 0xFF}}},
	{{{248, 122, 141}, 0, {-16, -16}, {0x77, 0x10, 0xD6, 0xFF}}},
	{{{164, 73, 66}, 0, {-16, -16}, {0x25, 0x09, 0x87, 0xFF}}},
	{{{169, 179, 150}, 0, {-16, -16}, {0xF5, 0x74, 0xCE, 0xFF}}},
	{{{110, 125, 84}, 0, {-16, -16}, {0xD5, 0x51, 0xA8, 0xFF}}},
	{{{70, 35, 77}, 0, {-16, -16}, {0xAE, 0xDD, 0xA6, 0xFF}}},
	{{{183, 19, 92}, 0, {-16, 1008}, {0x46, 0xAA, 0xC2, 0xFF}}},
	{{{102, -6, 113}, 0, {-16, -16}, {0xE5, 0x87, 0xE5, 0xFF}}},
	{{{121, 1, 140}, 0, {-16, -16}, {0x16, 0x91, 0x3A, 0xFF}}},
	{{{64, 95, 142}, 0, {-16, -16}, {0x8D, 0x36, 0x00, 0xFF}}},
	{{{59, 31, 165}, 0, {-16, -16}, {0x9A, 0xCC, 0x36, 0xFF}}},
	{{{102, -6, 113}, 0, {-16, 1008}, {0xE5, 0x87, 0xE5, 0xFF}}},
	{{{91, 24, 173}, 0, {-16, -16}, {0xF7, 0xAC, 0x5F, 0xFF}}},
	{{{121, 1, 140}, 0, {-16, -16}, {0x16, 0x91, 0x3A, 0xFF}}},
	{{{145, 137, 228}, 0, {-16, -16}, {0x0D, 0xE4, 0x7B, 0xFF}}},
	{{{125, 153, 226}, 0, {-16, -16}, {0xBF, 0x3E, 0x5A, 0xFF}}},
	{{{220, 190, 206}, 0, {-16, -16}, {0x42, 0x60, 0x34, 0xFF}}},
	{{{213, 159, 209}, 0, {-16, -16}, {0x43, 0xE4, 0x69, 0xFF}}},
	{{{169, 179, 150}, 0, {-16, 1008}, {0xF5, 0x74, 0xCE, 0xFF}}},
};

Gfx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_tri_2[] = {
	gsSPVertex(dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_vtx_2 + 0, 54, 0),
	gsSP2Triangles(0, 1, 2, 0, 3, 0, 2, 0),
	gsSP2Triangles(2, 4, 3, 0, 3, 5, 0, 0),
	gsSP2Triangles(6, 7, 8, 0, 7, 6, 9, 0),
	gsSP2Triangles(9, 6, 10, 0, 6, 11, 10, 0),
	gsSP2Triangles(11, 12, 10, 0, 10, 12, 13, 0),
	gsSP2Triangles(13, 12, 14, 0, 12, 15, 14, 0),
	gsSP2Triangles(16, 14, 15, 0, 17, 16, 15, 0),
	gsSP2Triangles(16, 18, 14, 0, 19, 14, 18, 0),
	gsSP2Triangles(20, 19, 18, 0, 18, 21, 20, 0),
	gsSP2Triangles(22, 21, 18, 0, 18, 23, 22, 0),
	gsSP2Triangles(22, 23, 24, 0, 8, 22, 24, 0),
	gsSP2Triangles(20, 21, 25, 0, 21, 9, 25, 0),
	gsSP2Triangles(7, 9, 21, 0, 25, 9, 10, 0),
	gsSP2Triangles(25, 19, 20, 0, 13, 14, 19, 0),
	gsSP2Triangles(26, 13, 19, 0, 10, 13, 26, 0),
	gsSP2Triangles(27, 28, 29, 0, 27, 29, 30, 0),
	gsSP2Triangles(29, 31, 30, 0, 30, 32, 27, 0),
	gsSP2Triangles(33, 34, 35, 0, 35, 36, 33, 0),
	gsSP2Triangles(35, 37, 36, 0, 37, 38, 36, 0),
	gsSP2Triangles(39, 38, 37, 0, 40, 39, 37, 0),
	gsSP2Triangles(41, 40, 37, 0, 40, 41, 42, 0),
	gsSP2Triangles(41, 43, 42, 0, 34, 43, 41, 0),
	gsSP2Triangles(39, 40, 44, 0, 44, 40, 45, 0),
	gsSP2Triangles(46, 45, 40, 0, 46, 47, 45, 0),
	gsSP2Triangles(48, 47, 46, 0, 49, 45, 47, 0),
	gsSP2Triangles(50, 45, 49, 0, 51, 50, 49, 0),
	gsSP2Triangles(52, 51, 49, 0, 33, 51, 52, 0),
	gsSP2Triangles(36, 51, 33, 0, 38, 51, 36, 0),
	gsSP2Triangles(51, 53, 50, 0, 53, 44, 50, 0),
	gsSP2Triangles(50, 44, 45, 0, 38, 39, 44, 0),
	gsSPEndDisplayList(),
};

Vtx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_5_vtx_0[8] = {
	{{{-172, 63, 15}, 0, {1008, 1008}, {0xA3, 0x2F, 0x48, 0xFF}}},
	{{{-115, 332, -85}, 0, {1008, -16}, {0xA3, 0x2F, 0x48, 0xFF}}},
	{{{-250, 303, -241}, 0, {-16, -16}, {0xA3, 0x2F, 0x48, 0xFF}}},
	{{{-307, 34, -141}, 0, {-16, 1008}, {0xA3, 0x2F, 0x48, 0xFF}}},
	{{{172, 63, 15}, 0, {1008, 1008}, {0x5D, 0x2F, 0x48, 0xFF}}},
	{{{307, 34, -141}, 0, {-16, 1008}, {0x5D, 0x2F, 0x48, 0xFF}}},
	{{{250, 303, -241}, 0, {-16, -16}, {0x5D, 0x2F, 0x48, 0xFF}}},
	{{{115, 332, -85}, 0, {1008, -16}, {0x5D, 0x2F, 0x48, 0xFF}}},
};

Gfx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_5_tri_0[] = {
	gsSPVertex(dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_5_vtx_0 + 0, 8, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSP2Triangles(4, 5, 6, 0, 4, 6, 7, 0),
	gsSPEndDisplayList(),
};


Gfx mat_dedede_cap_wing_Bronto_Burt_Skin[] = {
	gsSPSetLights1(dedede_cap_wing_Bronto_Burt_Skin_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_wing_Bronto_Burt_Skin[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_dedede_cap_wing_Bronto_Burt_Face_2[] = {
	gsSPSetLights1(dedede_cap_wing_Bronto_Burt_Face_2_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, SHADE, TEXEL0_ALPHA, SHADE, 0, 0, 0, ENVIRONMENT, TEXEL0, SHADE, TEXEL0_ALPHA, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, dedede_cap_wing_Bronto_Burt_Face_2_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 5),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_16b, 1, dedede_cap_wing_Bronto_Burt_Face_2_ci4),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_16b, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 511, 1024),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_4b, 2, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 6, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 252),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_wing_Bronto_Burt_Face_2[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx mat_dedede_cap_wing_Bronto_Burt_Shoe[] = {
	gsSPSetLights1(dedede_cap_wing_Bronto_Burt_Shoe_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_wing_Bronto_Burt_Shoe[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_dedede_cap_wing_Bronto_Burt_Wing[] = {
	gsSPClearGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, dedede_cap_wing_Bronto_Burt_Wing_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 62),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, dedede_cap_wing_Bronto_Burt_Wing_ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 511, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_wing_Bronto_Burt_Wing[] = {
	gsSPSetGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1[] = {
	gsSPDisplayList(mat_dedede_cap_wing_Bronto_Burt_Skin),
	gsSPDisplayList(dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_dedede_cap_wing_Bronto_Burt_Skin),
	gsSPDisplayList(mat_dedede_cap_wing_Bronto_Burt_Face_2),
	gsSPDisplayList(dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_tri_1),
	gsSPDisplayList(mat_revert_dedede_cap_wing_Bronto_Burt_Face_2),
	gsSPDisplayList(mat_dedede_cap_wing_Bronto_Burt_Shoe),
	gsSPDisplayList(dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_1_tri_2),
	gsSPDisplayList(mat_revert_dedede_cap_wing_Bronto_Burt_Shoe),
	gsSPEndDisplayList(),
};

Gfx dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_5[] = {
	gsSPDisplayList(mat_dedede_cap_wing_Bronto_Burt_Wing),
	gsSPDisplayList(dedede_cap_wing_Bronto_Burt_Cap_DL_mesh_layer_5_tri_0),
	gsSPDisplayList(mat_revert_dedede_cap_wing_Bronto_Burt_Wing),
	gsSPEndDisplayList(),
};

Gfx dedede_cap_wing_material_revert_render_settings[] = {
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, 0),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP  | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 256),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 8, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, 0),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 256, 6, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(6, 0, 0, 1023, 256),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 8, 256, 1, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(1, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};

