Lights1 dedede_cap_Kabu_Body_lights = gdSPDefLights1(
	0x44, 0x38, 0x1C,
	0x8F, 0x78, 0x42, 0x28, 0x28, 0x28);

Lights1 dedede_cap_Coat_Inside_lights = gdSPDefLights1(
	0x0, 0x0, 0x0,
	0x0, 0x0, 0x0, 0x28, 0x28, 0x28);

Lights1 dedede_cap_Cap_lights = gdSPDefLights1(
	0x7F, 0x0, 0x0,
	0xFF, 0x0, 0x0, 0x28, 0x28, 0x28);

Lights1 dedede_cap_Crown_lights = gdSPDefLights1(
	0xFF, 0xBC, 0x0,
	0x0, 0x0, 0x0, 0x28, 0x28, 0x28);

Lights1 dedede_cap_Cap_Inside__CAP__lights = gdSPDefLights1(
	0x7F, 0x0, 0x0,
	0xFF, 0x0, 0x0, 0x28, 0x28, 0x28);

Texture dedede_cap_metal_normal_rgba16[] = {
	#include "actors/dedede_cap/metal_normal.rgba16.inc.c"
};

Texture dedede_cap_metal_shine_rgba16[] = {
	#include "actors/dedede_cap/metal_shine.rgba16.inc.c"
};

Texture dedede_cap_Dedede_Puffball_ci4[] = {
	#include "actors/dedede_cap/Dedede_Puffball.ci4.inc.c"
};

Texture dedede_cap_Dedede_Puffball_pal_rgba16[] = {
	#include "actors/dedede_cap/Dedede_Puffball.rgba16.pal"
};

Vtx dedede_cap_Normal_Cap_DL_mesh_layer_1_vtx_0[114] = {
	{{{0, 386, 127}, 0, {9, 752}, {0x00, 0x53, 0x60, 0xFF}}},
	{{{0, 292, 170}, 0, {-6, 752}, {0x00, 0x36, 0x73, 0xFF}}},
	{{{42, 288, 155}, 0, {12, 795}, {0x2F, 0x31, 0x6B, 0xFF}}},
	{{{0, 448, 0}, 0, {240, 752}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-89, 386, 89}, 0, {43, 670}, {0xBC, 0x52, 0x44, 0xFF}}},
	{{{-133, 6, 133}, 0, {112, 428}, {0xA6, 0x0B, 0x59, 0xFF}}},
	{{{-66, 44, 158}, 0, {176, 428}, {0xCF, 0x07, 0x75, 0xFF}}},
	{{{-64, 126, 153}, 0, {176, 246}, {0xC8, 0x14, 0x70, 0xFF}}},
	{{{-125, 198, 108}, 0, {112, 152}, {0x97, 0x09, 0x47, 0xFF}}},
	{{{-133, 6, 133}, 0, {112, 246}, {0xA6, 0x0B, 0x59, 0xFF}}},
	{{{121, 273, 121}, 0, {30, 839}, {0xE9, 0x83, 0x00, 0xFF}}},
	{{{42, 288, 155}, 0, {-16, 1008}, {0xE9, 0x83, 0x00, 0xFF}}},
	{{{42, 288, 125}, 0, {78, 690}, {0xE9, 0x83, 0x00, 0xFF}}},
	{{{0, 292, 170}, 0, {-6, 752}, {0x00, 0x87, 0x26, 0xFF}}},
	{{{-42, 288, 155}, 0, {12, 752}, {0x00, 0x87, 0x26, 0xFF}}},
	{{{42, 288, 155}, 0, {12, 795}, {0x00, 0x87, 0x26, 0xFF}}},
	{{{-121, 273, 121}, 0, {112, -16}, {0x17, 0x83, 0x00, 0xFF}}},
	{{{-42, 288, 125}, 0, {-16, 1008}, {0x17, 0x83, 0x00, 0xFF}}},
	{{{-42, 288, 155}, 0, {101, 219}, {0x17, 0x83, 0x00, 0xFF}}},
	{{{43, 198, 125}, 0, {352, 152}, {0x12, 0x5B, 0x57, 0xFF}}},
	{{{43, 171, 153}, 0, {168, 588}, {0x12, 0x5B, 0x57, 0xFF}}},
	{{{125, 198, 108}, 0, {368, 152}, {0x12, 0x5B, 0x57, 0xFF}}},
	{{{-125, 198, 108}, 0, {47, 588}, {0xEE, 0x5B, 0x57, 0xFF}}},
	{{{-43, 171, 153}, 0, {80, 588}, {0xEE, 0x5B, 0x57, 0xFF}}},
	{{{-43, 198, 125}, 0, {224, 152}, {0xEE, 0x5B, 0x57, 0xFF}}},
	{{{43, 198, 233}, 0, {304, 152}, {0x7F, 0x02, 0x00, 0xFF}}},
	{{{43, 171, 153}, 0, {168, 588}, {0x7F, 0x00, 0x00, 0xFF}}},
	{{{43, 198, 125}, 0, {352, 152}, {0x6C, 0xFC, 0x43, 0xFF}}},
	{{{-187, 6, 0}, 0, {1008, 496}, {0x81, 0x09, 0x01, 0xFF}}},
	{{{-172, 292, 0}, 0, {1008, -16}, {0x84, 0x1E, 0x02, 0xFF}}},
	{{{-121, 292, -121}, 0, {880, -16}, {0xA9, 0x1E, 0xA9, 0xFF}}},
	{{{-133, 6, -133}, 0, {880, 496}, {0xA6, 0x07, 0xA6, 0xFF}}},
	{{{0, 292, -172}, 0, {752, -16}, {0x00, 0x1E, 0x85, 0xFF}}},
	{{{0, 6, -187}, 0, {752, 496}, {0x00, 0x07, 0x81, 0xFF}}},
	{{{121, 292, -121}, 0, {624, -16}, {0x57, 0x1E, 0xA9, 0xFF}}},
	{{{133, 6, -133}, 0, {624, 496}, {0x5A, 0x07, 0xA6, 0xFF}}},
	{{{172, 292, 0}, 0, {496, 152}, {0x7C, 0x1E, 0x02, 0xFF}}},
	{{{187, 6, 0}, 0, {496, 496}, {0x7F, 0x09, 0x01, 0xFF}}},
	{{{125, 198, 108}, 0, {-16, 1008}, {0x69, 0x09, 0x47, 0xFF}}},
	{{{121, 273, 121}, 0, {30, 839}, {0x64, 0x1F, 0x48, 0xFF}}},
	{{{133, 6, 133}, 0, {368, 246}, {0x5A, 0x0B, 0x59, 0xFF}}},
	{{{-133, 6, 133}, 0, {112, 496}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-187, 6, 0}, 0, {-16, 496}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-133, 6, -133}, 0, {880, 496}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{133, 6, -133}, 0, {624, 496}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{0, 6, -187}, 0, {752, 496}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{133, 6, 133}, 0, {304, 496}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{187, 6, 0}, 0, {496, 496}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{0, 6, 187}, 0, {240, 496}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-125, 198, 108}, 0, {47, 588}, {0x97, 0x09, 0x47, 0xFF}}},
	{{{-172, 292, 0}, 0, {240, 506}, {0x84, 0x1E, 0x02, 0xFF}}},
	{{{-121, 273, 121}, 0, {112, -16}, {0x9C, 0x1F, 0x48, 0xFF}}},
	{{{133, 6, 133}, 0, {304, 496}, {0x5A, 0x0B, 0x59, 0xFF}}},
	{{{66, 44, 158}, 0, {304, 428}, {0x31, 0x07, 0x75, 0xFF}}},
	{{{0, 44, 185}, 0, {240, 428}, {0x00, 0x07, 0x7F, 0xFF}}},
	{{{0, 6, 187}, 0, {240, 496}, {0x00, 0x07, 0x7F, 0xFF}}},
	{{{-133, 6, 133}, 0, {176, 496}, {0xA6, 0x0B, 0x59, 0xFF}}},
	{{{66, 44, 158}, 0, {336, 428}, {0x31, 0x07, 0x75, 0xFF}}},
	{{{64, 126, 153}, 0, {336, 246}, {0x38, 0x14, 0x70, 0xFF}}},
	{{{125, 198, 108}, 0, {368, 152}, {0x69, 0x09, 0x47, 0xFF}}},
	{{{43, 171, 153}, 0, {168, 588}, {0x29, 0xF4, 0x77, 0xFF}}},
	{{{89, 386, 89}, 0, {77, 915}, {0x44, 0x52, 0x44, 0xFF}}},
	{{{0, 386, 127}, 0, {43, 834}, {0x00, 0x53, 0x60, 0xFF}}},
	{{{127, 386, 0}, 0, {240, 983}, {0x5F, 0x54, 0x01, 0xFF}}},
	{{{127, 386, 0}, 0, {240, 983}, {0x5F, 0x54, 0x01, 0xFF}}},
	{{{89, 386, 89}, 0, {77, 915}, {0x44, 0x52, 0x44, 0xFF}}},
	{{{121, 273, 121}, 0, {66, 926}, {0x64, 0x1F, 0x48, 0xFF}}},
	{{{172, 292, 0}, 0, {240, 998}, {0x7C, 0x1E, 0x02, 0xFF}}},
	{{{89, 386, -89}, 0, {403, 915}, {0x43, 0x55, 0xBD, 0xFF}}},
	{{{121, 292, -121}, 0, {414, 926}, {0x57, 0x1E, 0xA9, 0xFF}}},
	{{{0, 386, -127}, 0, {471, 752}, {0x00, 0x55, 0xA1, 0xFF}}},
	{{{0, 292, -172}, 0, {486, 752}, {0x00, 0x1E, 0x85, 0xFF}}},
	{{{-89, 386, -89}, 0, {403, 589}, {0xBD, 0x55, 0xBD, 0xFF}}},
	{{{-121, 292, -121}, 0, {414, 578}, {0xA9, 0x1E, 0xA9, 0xFF}}},
	{{{-127, 386, 0}, 0, {240, 521}, {0xA1, 0x54, 0x01, 0xFF}}},
	{{{-172, 292, 0}, 0, {240, 506}, {0x84, 0x1E, 0x02, 0xFF}}},
	{{{-89, 386, 89}, 0, {77, 589}, {0xBC, 0x52, 0x44, 0xFF}}},
	{{{-121, 273, 121}, 0, {66, 578}, {0x9C, 0x1F, 0x48, 0xFF}}},
	{{{0, 448, 0}, 0, {240, 752}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{121, 273, 121}, 0, {30, 839}, {0x64, 0x1F, 0x48, 0xFF}}},
	{{{0, 386, 127}, 0, {26, 793}, {0x00, 0x53, 0x60, 0xFF}}},
	{{{42, 288, 155}, 0, {-16, 1008}, {0x2F, 0x31, 0x6B, 0xFF}}},
	{{{0, 386, 127}, 0, {26, 711}, {0x00, 0x53, 0x60, 0xFF}}},
	{{{-89, 386, 89}, 0, {43, 670}, {0xBC, 0x52, 0x44, 0xFF}}},
	{{{-121, 273, 121}, 0, {30, 665}, {0x9C, 0x1F, 0x48, 0xFF}}},
	{{{-42, 288, 155}, 0, {12, 709}, {0xD1, 0x31, 0x6B, 0xFF}}},
	{{{0, 292, 170}, 0, {-6, 752}, {0x00, 0x36, 0x73, 0xFF}}},
	{{{-43, 198, 125}, 0, {176, 152}, {0x81, 0x01, 0x00, 0xFF}}},
	{{{-43, 171, 153}, 0, {80, 588}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{-43, 198, 233}, 0, {176, 152}, {0x81, 0x02, 0x00, 0xFF}}},
	{{{-42, 288, 155}, 0, {101, 219}, {0x81, 0x02, 0x00, 0xFF}}},
	{{{-42, 273, 192}, 0, {101, 219}, {0x81, 0x02, 0x00, 0xFF}}},
	{{{-42, 288, 125}, 0, {-16, 1008}, {0x81, 0x02, 0x00, 0xFF}}},
	{{{-125, 198, 108}, 0, {47, 588}, {0x97, 0x09, 0x47, 0xFF}}},
	{{{-64, 126, 153}, 0, {176, 246}, {0xC8, 0x14, 0x70, 0xFF}}},
	{{{-43, 171, 153}, 0, {80, 588}, {0xD7, 0xF4, 0x77, 0xFF}}},
	{{{0, 146, 180}, 0, {-16, 1008}, {0x00, 0x42, 0x6C, 0xFF}}},
	{{{43, 171, 153}, 0, {-16, 1008}, {0x29, 0xF4, 0x77, 0xFF}}},
	{{{64, 126, 153}, 0, {336, 246}, {0x38, 0x14, 0x70, 0xFF}}},
	{{{-42, 288, 155}, 0, {48, 752}, {0x00, 0x76, 0x30, 0xFF}}},
	{{{-42, 273, 192}, 0, {66, 752}, {0x00, 0x5F, 0x55, 0xFF}}},
	{{{42, 273, 192}, 0, {66, 839}, {0x00, 0x5F, 0x55, 0xFF}}},
	{{{42, 288, 155}, 0, {12, 795}, {0x00, 0x76, 0x30, 0xFF}}},
	{{{43, 198, 233}, 0, {304, 152}, {0x00, 0xD1, 0x76, 0xFF}}},
	{{{42, 273, 192}, 0, {78, 690}, {0x00, 0x5F, 0x55, 0xFF}}},
	{{{-42, 273, 192}, 0, {89, 455}, {0x00, 0x5F, 0x55, 0xFF}}},
	{{{-43, 198, 233}, 0, {240, 152}, {0x00, 0xD1, 0x76, 0xFF}}},
	{{{43, 171, 153}, 0, {168, 588}, {0x29, 0xF4, 0x77, 0xFF}}},
	{{{43, 198, 125}, 0, {304, 152}, {0x6C, 0xFC, 0x43, 0xFF}}},
	{{{42, 288, 155}, 0, {78, 690}, {0x7F, 0x02, 0x00, 0xFF}}},
	{{{42, 273, 192}, 0, {78, 690}, {0x7F, 0x02, 0x00, 0xFF}}},
	{{{43, 198, 233}, 0, {304, 152}, {0x7F, 0x02, 0x00, 0xFF}}},
	{{{42, 288, 125}, 0, {78, 690}, {0x61, 0x01, 0x51, 0xFF}}},
	{{{42, 288, 155}, 0, {-16, 1008}, {0x7F, 0x02, 0x00, 0xFF}}},
};

Gfx dedede_cap_Normal_Cap_DL_mesh_layer_1_tri_0[] = {
	gsSPVertex(dedede_cap_Normal_Cap_DL_mesh_layer_1_vtx_0 + 0, 64, 0),
	gsSP2Triangles(0, 1, 2, 0, 3, 4, 0, 0),
	gsSP2Triangles(5, 6, 7, 0, 8, 9, 7, 0),
	gsSP2Triangles(10, 11, 12, 0, 13, 14, 15, 0),
	gsSP2Triangles(16, 17, 18, 0, 19, 20, 21, 0),
	gsSP2Triangles(22, 23, 24, 0, 25, 26, 27, 0),
	gsSP2Triangles(28, 29, 30, 0, 28, 30, 31, 0),
	gsSP2Triangles(31, 30, 32, 0, 31, 32, 33, 0),
	gsSP2Triangles(33, 32, 34, 0, 33, 34, 35, 0),
	gsSP2Triangles(35, 34, 36, 0, 35, 36, 37, 0),
	gsSP2Triangles(36, 38, 37, 0, 36, 39, 38, 0),
	gsSP2Triangles(40, 37, 38, 0, 41, 42, 43, 0),
	gsSP2Triangles(41, 43, 44, 0, 43, 45, 44, 0),
	gsSP2Triangles(44, 46, 41, 0, 44, 47, 46, 0),
	gsSP2Triangles(46, 48, 41, 0, 49, 28, 9, 0),
	gsSP2Triangles(50, 28, 49, 0, 51, 50, 49, 0),
	gsSP2Triangles(52, 53, 54, 0, 52, 54, 55, 0),
	gsSP2Triangles(55, 54, 6, 0, 55, 6, 56, 0),
	gsSP2Triangles(57, 40, 58, 0, 58, 40, 59, 0),
	gsSP2Triangles(59, 60, 58, 0, 61, 3, 62, 0),
	gsSP1Triangle(63, 3, 61, 0),
	gsSPVertex(dedede_cap_Normal_Cap_DL_mesh_layer_1_vtx_0 + 64, 50, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSP2Triangles(4, 0, 3, 0, 4, 3, 5, 0),
	gsSP2Triangles(6, 4, 5, 0, 6, 5, 7, 0),
	gsSP2Triangles(8, 6, 7, 0, 8, 7, 9, 0),
	gsSP2Triangles(10, 8, 9, 0, 10, 9, 11, 0),
	gsSP2Triangles(12, 10, 11, 0, 12, 11, 13, 0),
	gsSP2Triangles(12, 14, 10, 0, 14, 8, 10, 0),
	gsSP2Triangles(8, 14, 6, 0, 6, 14, 4, 0),
	gsSP2Triangles(4, 14, 0, 0, 15, 1, 16, 0),
	gsSP2Triangles(15, 16, 17, 0, 18, 19, 20, 0),
	gsSP2Triangles(18, 20, 21, 0, 18, 21, 22, 0),
	gsSP2Triangles(23, 24, 25, 0, 26, 23, 25, 0),
	gsSP2Triangles(26, 25, 27, 0, 23, 26, 28, 0),
	gsSP2Triangles(29, 30, 31, 0, 32, 31, 30, 0),
	gsSP2Triangles(32, 33, 31, 0, 32, 34, 33, 0),
	gsSP2Triangles(35, 36, 37, 0, 37, 38, 35, 0),
	gsSP2Triangles(39, 40, 41, 0, 39, 41, 42, 0),
	gsSP2Triangles(39, 42, 31, 0, 39, 31, 43, 0),
	gsSP2Triangles(44, 45, 46, 0, 44, 46, 47, 0),
	gsSP1Triangle(48, 49, 44, 0),
	gsSPEndDisplayList(),
};

Vtx dedede_cap_Normal_Cap_DL_mesh_layer_1_vtx_1[15] = {
	{{{125, 198, 108}, 0, {368, 152}, {0x19, 0xEB, 0x7B, 0xFF}}},
	{{{121, 273, 121}, 0, {30, 839}, {0x0F, 0xF6, 0x7E, 0xFF}}},
	{{{43, 198, 125}, 0, {352, 152}, {0x6C, 0xFC, 0x43, 0xFF}}},
	{{{42, 288, 125}, 0, {78, 690}, {0x61, 0x01, 0x51, 0xFF}}},
	{{{43, 198, 125}, 0, {304, 152}, {0x6C, 0xFC, 0x43, 0xFF}}},
	{{{-121, 273, 121}, 0, {112, -16}, {0xF1, 0xF6, 0x7E, 0xFF}}},
	{{{-43, 198, 125}, 0, {176, 152}, {0xF1, 0xF6, 0x7E, 0xFF}}},
	{{{-42, 288, 125}, 0, {-16, 1008}, {0xFA, 0x00, 0x7F, 0xFF}}},
	{{{-125, 198, 108}, 0, {47, 588}, {0xE7, 0xEB, 0x7B, 0xFF}}},
	{{{0, 146, 180}, 0, {-16, 1008}, {0x00, 0x08, 0x7F, 0xFF}}},
	{{{66, 44, 158}, 0, {304, 428}, {0x31, 0x07, 0x75, 0xFF}}},
	{{{64, 126, 153}, 0, {336, 246}, {0x31, 0x07, 0x75, 0xFF}}},
	{{{0, 44, 185}, 0, {240, 428}, {0x00, 0x08, 0x7F, 0xFF}}},
	{{{-64, 126, 153}, 0, {176, 246}, {0xCF, 0x07, 0x75, 0xFF}}},
	{{{-66, 44, 158}, 0, {176, 428}, {0xCF, 0x07, 0x75, 0xFF}}},
};

Gfx dedede_cap_Normal_Cap_DL_mesh_layer_1_tri_1[] = {
	gsSPVertex(dedede_cap_Normal_Cap_DL_mesh_layer_1_vtx_1 + 0, 15, 0),
	gsSP2Triangles(0, 1, 2, 0, 1, 3, 4, 0),
	gsSP2Triangles(5, 6, 7, 0, 5, 8, 6, 0),
	gsSP2Triangles(9, 10, 11, 0, 9, 12, 10, 0),
	gsSP2Triangles(13, 12, 9, 0, 13, 14, 12, 0),
	gsSPEndDisplayList(),
};

Vtx dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_vtx_0[19] = {
	{{{-147, 229, -125}, 0, {157, 661}, {0xB2, 0x58, 0xD1, 0xFF}}},
	{{{0, 296, -50}, 0, {368, 240}, {0x00, 0x7F, 0xFA, 0xFF}}},
	{{{0, 224, -203}, 0, {-16, 1008}, {0x00, 0x52, 0x9F, 0xFF}}},
	{{{147, 229, -125}, 0, {157, 661}, {0x4E, 0x58, 0xD1, 0xFF}}},
	{{{187, 58, -197}, 0, {-16, 1008}, {0x5D, 0xF1, 0xAB, 0xFF}}},
	{{{223, 91, -60}, 0, {-16, 1008}, {0x7F, 0x04, 0xFD, 0xFF}}},
	{{{0, 37, -267}, 0, {-16, 1008}, {0x00, 0xE5, 0x84, 0xFF}}},
	{{{-187, 58, -197}, 0, {-16, 1008}, {0xA3, 0xF1, 0xAB, 0xFF}}},
	{{{-223, 91, -60}, 0, {-16, 1008}, {0x81, 0x04, 0xFD, 0xFF}}},
	{{{-147, 229, -125}, 0, {148, 680}, {0xB2, 0x58, 0xD1, 0xFF}}},
	{{{-144, 220, 54}, 0, {-16, 1008}, {0xB4, 0x59, 0x32, 0xFF}}},
	{{{-194, 125, 77}, 0, {-16, 1008}, {0x96, 0x0E, 0x45, 0xFF}}},
	{{{-70, 130, 155}, 0, {-16, 1008}, {0xAD, 0x2B, 0x55, 0xFF}}},
	{{{0, 181, 140}, 0, {-16, 1008}, {0x00, 0x73, 0x35, 0xFF}}},
	{{{0, 255, 86}, 0, {-16, 1008}, {0x00, 0x67, 0x4A, 0xFF}}},
	{{{144, 220, 54}, 0, {-16, 1008}, {0x4C, 0x59, 0x32, 0xFF}}},
	{{{70, 130, 155}, 0, {-16, 1008}, {0x53, 0x2B, 0x55, 0xFF}}},
	{{{194, 125, 77}, 0, {-16, 1008}, {0x6A, 0x0E, 0x45, 0xFF}}},
	{{{147, 229, -125}, 0, {148, 680}, {0x4E, 0x58, 0xD1, 0xFF}}},
};

Gfx dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_tri_0[] = {
	gsSPVertex(dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_vtx_0 + 0, 19, 0),
	gsSP2Triangles(0, 1, 2, 0, 3, 2, 1, 0),
	gsSP2Triangles(2, 3, 4, 0, 5, 4, 3, 0),
	gsSP2Triangles(6, 2, 4, 0, 6, 7, 2, 0),
	gsSP2Triangles(2, 7, 0, 0, 8, 0, 7, 0),
	gsSP2Triangles(9, 10, 1, 0, 10, 9, 8, 0),
	gsSP2Triangles(8, 11, 10, 0, 10, 11, 12, 0),
	gsSP2Triangles(12, 13, 10, 0, 14, 10, 13, 0),
	gsSP2Triangles(15, 14, 13, 0, 13, 16, 15, 0),
	gsSP2Triangles(15, 16, 17, 0, 5, 15, 17, 0),
	gsSP2Triangles(15, 5, 18, 0, 18, 1, 15, 0),
	gsSP2Triangles(14, 15, 1, 0, 14, 1, 10, 0),
	gsSPEndDisplayList(),
};

Vtx dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_vtx_1[26] = {
	{{{0, 196, 178}, 0, {-260, 495}, {0x00, 0x77, 0x2D, 0xFF}}},
	{{{0, 181, 140}, 0, {-260, 495}, {0x00, 0x73, 0x35, 0xFF}}},
	{{{-70, 130, 155}, 0, {-260, 495}, {0xAD, 0x2B, 0x55, 0xFF}}},
	{{{70, 130, 155}, 0, {-260, 495}, {0x53, 0x2B, 0x55, 0xFF}}},
	{{{83, 66, 183}, 0, {-260, 495}, {0x71, 0xD7, 0x2A, 0xFF}}},
	{{{0, 112, 214}, 0, {-260, 495}, {0x00, 0x17, 0x7D, 0xFF}}},
	{{{-83, 66, 183}, 0, {-260, 495}, {0x8F, 0xD7, 0x2A, 0xFF}}},
	{{{-57, 68, 135}, 0, {-260, 495}, {0xC4, 0x90, 0xF5, 0xFF}}},
	{{{-194, 125, 77}, 0, {-260, 495}, {0x96, 0x0E, 0x45, 0xFF}}},
	{{{-176, 71, 73}, 0, {-260, 495}, {0xBE, 0xA7, 0x3F, 0xFF}}},
	{{{-207, 47, -46}, 0, {-260, 495}, {0xB0, 0xA0, 0x17, 0xFF}}},
	{{{-223, 91, -60}, 0, {-260, 495}, {0x81, 0x04, 0xFD, 0xFF}}},
	{{{-164, 8, -168}, 0, {-260, 495}, {0xC8, 0x91, 0xE7, 0xFF}}},
	{{{-187, 58, -197}, 0, {-260, 495}, {0xA3, 0xF1, 0xAB, 0xFF}}},
	{{{0, -7, -221}, 0, {-260, 495}, {0x00, 0x89, 0xD3, 0xFF}}},
	{{{0, 37, -267}, 0, {-260, 495}, {0x00, 0xE5, 0x84, 0xFF}}},
	{{{187, 58, -197}, 0, {-260, 495}, {0x5D, 0xF1, 0xAB, 0xFF}}},
	{{{164, 8, -168}, 0, {-260, 495}, {0x38, 0x91, 0xE7, 0xFF}}},
	{{{223, 91, -60}, 0, {-260, 495}, {0x7F, 0x04, 0xFD, 0xFF}}},
	{{{207, 47, -46}, 0, {-260, 495}, {0x50, 0xA0, 0x17, 0xFF}}},
	{{{194, 125, 77}, 0, {-260, 495}, {0x6A, 0x0E, 0x45, 0xFF}}},
	{{{176, 71, 73}, 0, {-260, 495}, {0x42, 0xA7, 0x3F, 0xFF}}},
	{{{57, 68, 135}, 0, {-260, 495}, {0x3C, 0x90, 0xF5, 0xFF}}},
	{{{0, 37, 144}, 0, {-260, 495}, {0x00, 0xA5, 0xA8, 0xFF}}},
	{{{0, 9, 194}, 0, {-260, 495}, {0x48, 0x9F, 0x27, 0xFF}}},
	{{{0, 9, 194}, 0, {-260, 495}, {0xB8, 0x9F, 0x27, 0xFF}}},
};

Gfx dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_tri_1[] = {
	gsSPVertex(dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_vtx_1 + 0, 26, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 3, 1, 0),
	gsSP2Triangles(3, 0, 4, 0, 5, 4, 0, 0),
	gsSP2Triangles(5, 0, 6, 0, 2, 6, 0, 0),
	gsSP2Triangles(2, 7, 6, 0, 8, 7, 2, 0),
	gsSP2Triangles(8, 9, 7, 0, 10, 9, 8, 0),
	gsSP2Triangles(10, 8, 11, 0, 12, 10, 11, 0),
	gsSP2Triangles(12, 11, 13, 0, 14, 12, 13, 0),
	gsSP2Triangles(14, 13, 15, 0, 14, 15, 16, 0),
	gsSP2Triangles(14, 16, 17, 0, 17, 16, 18, 0),
	gsSP2Triangles(17, 18, 19, 0, 19, 18, 20, 0),
	gsSP2Triangles(19, 20, 21, 0, 20, 22, 21, 0),
	gsSP2Triangles(20, 3, 22, 0, 3, 4, 22, 0),
	gsSP2Triangles(4, 23, 22, 0, 23, 4, 24, 0),
	gsSP2Triangles(4, 5, 24, 0, 7, 22, 23, 0),
	gsSP2Triangles(6, 7, 23, 0, 23, 25, 6, 0),
	gsSP1Triangle(6, 25, 5, 0),
	gsSPEndDisplayList(),
};

Vtx dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_vtx_2[9] = {
	{{{-176, 71, 73}, 0, {-16, 1008}, {0xBE, 0xA7, 0x3F, 0xFF}}},
	{{{57, 68, 135}, 0, {-16, 1008}, {0x3C, 0x90, 0xF5, 0xFF}}},
	{{{-57, 68, 135}, 0, {-16, 1008}, {0xC4, 0x90, 0xF5, 0xFF}}},
	{{{176, 71, 73}, 0, {-16, 1008}, {0x42, 0xA7, 0x3F, 0xFF}}},
	{{{-207, 47, -46}, 0, {-16, 1008}, {0xB0, 0xA0, 0x17, 0xFF}}},
	{{{207, 47, -46}, 0, {-16, 1008}, {0x50, 0xA0, 0x17, 0xFF}}},
	{{{-164, 8, -168}, 0, {-16, 1008}, {0xC8, 0x91, 0xE7, 0xFF}}},
	{{{164, 8, -168}, 0, {-16, 1008}, {0x38, 0x91, 0xE7, 0xFF}}},
	{{{0, -7, -221}, 0, {-16, 1008}, {0x00, 0x89, 0xD3, 0xFF}}},
};

Gfx dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_tri_2[] = {
	gsSPVertex(dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_vtx_2 + 0, 9, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 3, 1, 0),
	gsSP2Triangles(4, 3, 0, 0, 4, 5, 3, 0),
	gsSP2Triangles(6, 5, 4, 0, 6, 7, 5, 0),
	gsSP1Triangle(8, 7, 6, 0),
	gsSPEndDisplayList(),
};

Vtx dedede_cap_Normal_Cap_Switch_Option_Puffball_Cap_DL_mesh_layer_4_vtx_0[4] = {
	{{{21, -20, 0}, 0, {496, 496}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{20, 21, 0}, 0, {496, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-21, 20, 0}, 0, {-16, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-20, -21, 0}, 0, {-16, 496}, {0x00, 0x00, 0x7F, 0xFF}}},
};

Gfx dedede_cap_Normal_Cap_Switch_Option_Puffball_Cap_DL_mesh_layer_4_tri_0[] = {
	gsSPVertex(dedede_cap_Normal_Cap_Switch_Option_Puffball_Cap_DL_mesh_layer_4_vtx_0 + 0, 4, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSPEndDisplayList(),
};


Gfx mat_dedede_cap_Kabu_Body[] = {
	gsSPSetLights1(dedede_cap_Kabu_Body_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_Kabu_Body[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_dedede_cap_Coat_Inside[] = {
	gsSPSetLights1(dedede_cap_Coat_Inside_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_Coat_Inside[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_dedede_cap_Cap[] = {
	gsSPCopyLightsPlayerPart(CAP),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_Cap[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_dedede_cap_Crown[] = {
	gsSPSetGeometryMode(G_TEXTURE_GEN),
	gsSPLight(&dedede_cap_Crown_lights.l, 1),
    gsSPLight(&dedede_cap_Crown_lights.a, 2),
    gsSPCopyLightEXT(2, 17),
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, TEXEL1, 0, 0, 0, ENVIRONMENT, TEXEL0, 0, SHADE, TEXEL1, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(4032, 1984, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, dedede_cap_metal_normal_rgba16),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 2047, 128),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 16, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 6, 0),
	gsDPSetTileSize(0, 0, 0, 252, 124),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, dedede_cap_metal_shine_rgba16),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 512, 6, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(6, 0, 0, 2047, 128),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 16, 512, 1, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 6, 0),
	gsDPSetTileSize(1, 0, 0, 252, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_Crown[] = {
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_dedede_cap_Cap_Inside__CAP_[] = {
	gsSPSetLights1(dedede_cap_Cap_Inside__CAP__lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(SHADE, 0, PRIMITIVE, 0, 0, 0, 0, ENVIRONMENT, SHADE, 0, PRIMITIVE, 0, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetPrimColor(0, 0, 115, 115, 115, 255),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_Cap_Inside__CAP_[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_dedede_cap_Puffball[] = {
	gsSPClearGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, dedede_cap_Dedede_Puffball_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 11),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_16b, 1, dedede_cap_Dedede_Puffball_ci4),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_16b, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 63, 2048),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_4b, 1, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 4, 0, G_TX_CLAMP | G_TX_NOMIRROR, 4, 0),
	gsDPSetTileSize(0, 0, 0, 60, 60),
	gsSPEndDisplayList(),
};

Gfx mat_revert_dedede_cap_Puffball[] = {
	gsSPSetGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx dedede_cap_Normal_Cap_DL_mesh_layer_1[] = {
	gsSPDisplayList(mat_dedede_cap_Kabu_Body),
	gsSPDisplayList(dedede_cap_Normal_Cap_DL_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_dedede_cap_Kabu_Body),
	gsSPDisplayList(mat_dedede_cap_Coat_Inside),
	gsSPDisplayList(dedede_cap_Normal_Cap_DL_mesh_layer_1_tri_1),
	gsSPDisplayList(mat_revert_dedede_cap_Coat_Inside),
	gsSPEndDisplayList(),
};

Gfx dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1[] = {
	gsSPDisplayList(mat_dedede_cap_Cap),
	gsSPDisplayList(dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_dedede_cap_Cap),
	gsSPDisplayList(mat_dedede_cap_Crown),
	gsSPDisplayList(dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_tri_1),
	gsSPDisplayList(mat_revert_dedede_cap_Crown),
	gsSPDisplayList(mat_dedede_cap_Cap_Inside__CAP_),
	gsSPDisplayList(dedede_cap_Normal_Cap_Switch_Option_Normal_Cap_DL_mesh_layer_1_tri_2),
	gsSPDisplayList(mat_revert_dedede_cap_Cap_Inside__CAP_),
	gsSPEndDisplayList(),
};

Gfx dedede_cap_Normal_Cap_Switch_Option_Puffball_Cap_DL_mesh_layer_4[] = {
	gsSPDisplayList(mat_dedede_cap_Puffball),
	gsSPDisplayList(dedede_cap_Normal_Cap_Switch_Option_Puffball_Cap_DL_mesh_layer_4_tri_0),
	gsSPDisplayList(mat_revert_dedede_cap_Puffball),
	gsSPEndDisplayList(),
};

Gfx dedede_cap_material_revert_render_settings[] = {
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

