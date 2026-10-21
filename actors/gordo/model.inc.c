Lights1 gordo_Gordo_Spikes_lights = gdSPDefLights1(
	0x7F, 0x7F, 0x7F,
	0xFF, 0xFF, 0xFF, 0x28, 0x28, 0x28);

Lights1 gordo_Searches_Lights_lights = gdSPDefLights1(
	0xFF, 0x0, 0x0,
	0xFF, 0x89, 0x89, 0x28, 0x28, 0x28);

Lights1 gordo_Searches_Lights__Explode__lights = gdSPDefLights1(
	0xFF, 0xBC, 0xBC,
	0xFF, 0xFF, 0xFF, 0x28, 0x28, 0x28);

Texture gordo_bomb_right_side_rgba16_ci8[] = {
	#include "actors/gordo/bomb_right_side.rgba16.ci8.inc.c"
};

Texture gordo_bomb_right_side_rgba16_pal_rgba16[] = {
	#include "actors/gordo/bomb_right_side.rgba16.pal"
};

Texture gordo_bomb_left_side_rgba16_ci8[] = {
	#include "actors/gordo/bomb_left_side.rgba16.ci8.inc.c"
};

Texture gordo_bomb_left_side_rgba16_pal_rgba16[] = {
	#include "actors/gordo/bomb_left_side.rgba16.pal"
};

Texture gordo_bomb_spike_rgba16_ci8[] = {
	#include "actors/gordo/bomb_spike.rgba16.ci8.inc.c"
};

Texture gordo_bomb_spike_rgba16_pal_rgba16[] = {
	#include "actors/gordo/bomb_spike.rgba16.pal"
};

Texture gordo_Gordo_Eye_ci8[] = {
	#include "actors/gordo/Gordo_Eye.ci8.inc.c"
};

Texture gordo_Gordo_Eye_pal_rgba16[] = {
	#include "actors/gordo/Gordo_Eye.rgba16.pal"
};

Texture gordo_bob_omb_right_side_rgba16_ia8[] = {
	#include "actors/gordo/bob-omb_right_side.rgba16.ia8.inc.c"
};

Texture gordo_bob_omb_left_side_rgba16_ia8[] = {
	#include "actors/gordo/bob-omb_left_side.rgba16.ia8.inc.c"
};

Texture gordo_Searches_Face_ci8[] = {
	#include "actors/gordo/Searches_Face.ci8.inc.c"
};

Texture gordo_Searches_Face_pal_rgba16[] = {
	#include "actors/gordo/Searches_Face.rgba16.pal"
};

Texture gordo_Searches_Right__Explode__ci8[] = {
	#include "actors/gordo/Searches_Right__Explode_.ci8.inc.c"
};

Texture gordo_Searches_Right__Explode__pal_rgba16[] = {
	#include "actors/gordo/Searches_Right__Explode_.rgba16.pal"
};

Texture gordo_Searches_Left__Explode__ci8[] = {
	#include "actors/gordo/Searches_Left__Explode_.ci8.inc.c"
};

Texture gordo_Searches_Left__Explode__pal_rgba16[] = {
	#include "actors/gordo/Searches_Left__Explode_.rgba16.pal"
};

Texture gordo_Searches_Face_Explode_ci8[] = {
	#include "actors/gordo/Searches_Face_Explode.ci8.inc.c"
};

Texture gordo_Searches_Face_Explode_pal_rgba16[] = {
	#include "actors/gordo/Searches_Face_Explode.rgba16.pal"
};

Vtx gordo_Gordo_Body_DL_mesh_layer_4_vtx_0[4] = {
	{{{38, -38, 0}, 0, {1040, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{38, 38, 0}, 0, {1040, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{0, 38, 0}, 0, {16, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{0, -38, 0}, 0, {16, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
};

Gfx gordo_Gordo_Body_DL_mesh_layer_4_tri_0[] = {
	gsSPVertex(gordo_Gordo_Body_DL_mesh_layer_4_vtx_0 + 0, 4, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Gordo_Body_DL_mesh_layer_4_vtx_1[4] = {
	{{{0, -38, 0}, 0, {1008, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-38, 38, 0}, 0, {-16, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-38, -38, 0}, 0, {-16, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{0, 38, 0}, 0, {1008, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
};

Gfx gordo_Gordo_Body_DL_mesh_layer_4_tri_1[] = {
	gsSPVertex(gordo_Gordo_Body_DL_mesh_layer_4_vtx_1 + 0, 4, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 3, 1, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Gordo_DL_mesh_layer_1_vtx_0[40] = {
	{{{0, 142, 40}, 0, {-16, 984}, {0x00, 0x3A, 0x71, 0xFF}}},
	{{{0, 220, 0}, 0, {496, -16}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-40, 142, 0}, 0, {496, 984}, {0x8F, 0x3A, 0x00, 0xFF}}},
	{{{40, 142, 0}, 0, {496, 984}, {0x71, 0x3A, 0x00, 0xFF}}},
	{{{0, 142, -40}, 0, {1008, 984}, {0x00, 0x3A, 0x8F, 0xFF}}},
	{{{0, -40, 148}, 0, {-16, 984}, {0x00, 0x8F, 0x3A, 0xFF}}},
	{{{0, 0, 226}, 0, {496, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-40, 0, 148}, 0, {496, 984}, {0x8F, 0x00, 0x3A, 0xFF}}},
	{{{40, 0, 148}, 0, {496, 984}, {0x71, 0x00, 0x3A, 0xFF}}},
	{{{0, 40, 148}, 0, {1008, 984}, {0x00, 0x71, 0x3A, 0xFF}}},
	{{{0, -143, -40}, 0, {-16, 984}, {0x00, 0xC6, 0x8F, 0xFF}}},
	{{{0, -221, 0}, 0, {496, -16}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-40, -143, 0}, 0, {496, 984}, {0x8F, 0xC6, 0x00, 0xFF}}},
	{{{40, -143, 0}, 0, {496, 984}, {0x71, 0xC6, 0x00, 0xFF}}},
	{{{0, -143, 40}, 0, {1008, 984}, {0x00, 0xC6, 0x71, 0xFF}}},
	{{{0, 40, -137}, 0, {-16, 984}, {0x00, 0x71, 0xC6, 0xFF}}},
	{{{0, 0, -214}, 0, {496, -16}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{-40, 0, -137}, 0, {496, 984}, {0x8F, 0x00, 0xC6, 0xFF}}},
	{{{40, 0, -137}, 0, {496, 984}, {0x71, 0x00, 0xC6, 0xFF}}},
	{{{0, -41, -137}, 0, {1008, 984}, {0x00, 0x8F, 0xC6, 0xFF}}},
	{{{0, 126, -69}, 0, {-16, 984}, {0x00, 0x70, 0x3B, 0xFF}}},
	{{{0, 190, -190}, 0, {496, -16}, {0x00, 0x5A, 0xA6, 0xFF}}},
	{{{-40, 98, -98}, 0, {496, 984}, {0x87, 0x1B, 0xE5, 0xFF}}},
	{{{40, 98, -98}, 0, {496, 984}, {0x79, 0x1B, 0xE5, 0xFF}}},
	{{{0, 69, -126}, 0, {1008, 984}, {0x00, 0xC5, 0x90, 0xFF}}},
	{{{0, 72, 129}, 0, {-16, 984}, {0x00, 0xBD, 0x6C, 0xFF}}},
	{{{0, 225, 225}, 0, {496, -16}, {0x00, 0x5A, 0x5A, 0xFF}}},
	{{{-40, 101, 101}, 0, {496, 984}, {0x84, 0x14, 0x14, 0xFF}}},
	{{{40, 101, 101}, 0, {496, 984}, {0x7C, 0x14, 0x14, 0xFF}}},
	{{{0, 129, 72}, 0, {1008, 984}, {0x00, 0x6C, 0xBD, 0xFF}}},
	{{{0, -129, 72}, 0, {-16, 984}, {0x00, 0x90, 0xC5, 0xFF}}},
	{{{0, -193, 193}, 0, {496, -16}, {0x00, 0xA6, 0x5A, 0xFF}}},
	{{{-40, -101, 101}, 0, {496, 984}, {0x87, 0xE5, 0x1B, 0xFF}}},
	{{{40, -101, 101}, 0, {496, 984}, {0x79, 0xE5, 0x1B, 0xFF}}},
	{{{0, -72, 129}, 0, {1008, 984}, {0x00, 0x3B, 0x70, 0xFF}}},
	{{{0, -69, -125}, 0, {-16, 984}, {0x00, 0x43, 0x94, 0xFF}}},
	{{{0, -221, -221}, 0, {496, -16}, {0x00, 0xA6, 0xA6, 0xFF}}},
	{{{-40, -97, -97}, 0, {496, 984}, {0x84, 0xEC, 0xEC, 0xFF}}},
	{{{40, -97, -97}, 0, {496, 984}, {0x7C, 0xEC, 0xEC, 0xFF}}},
	{{{0, -126, -68}, 0, {1008, 984}, {0x00, 0x94, 0x43, 0xFF}}},
};

Gfx gordo_Gordo_DL_mesh_layer_1_tri_0[] = {
	gsSPVertex(gordo_Gordo_DL_mesh_layer_1_vtx_0 + 0, 40, 0),
	gsSP2Triangles(0, 1, 2, 0, 3, 1, 0, 0),
	gsSP2Triangles(4, 1, 3, 0, 2, 1, 4, 0),
	gsSP2Triangles(5, 6, 7, 0, 8, 6, 5, 0),
	gsSP2Triangles(9, 6, 8, 0, 7, 6, 9, 0),
	gsSP2Triangles(10, 11, 12, 0, 13, 11, 10, 0),
	gsSP2Triangles(14, 11, 13, 0, 12, 11, 14, 0),
	gsSP2Triangles(15, 16, 17, 0, 18, 16, 15, 0),
	gsSP2Triangles(19, 16, 18, 0, 17, 16, 19, 0),
	gsSP2Triangles(20, 21, 22, 0, 23, 21, 20, 0),
	gsSP2Triangles(24, 21, 23, 0, 22, 21, 24, 0),
	gsSP2Triangles(25, 26, 27, 0, 28, 26, 25, 0),
	gsSP2Triangles(29, 26, 28, 0, 27, 26, 29, 0),
	gsSP2Triangles(30, 31, 32, 0, 33, 31, 30, 0),
	gsSP2Triangles(34, 31, 33, 0, 32, 31, 34, 0),
	gsSP2Triangles(35, 36, 37, 0, 38, 36, 35, 0),
	gsSP2Triangles(39, 36, 38, 0, 37, 36, 39, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Gordo_DL_mesh_layer_4_vtx_0[8] = {
	{{{162, -69, 8}, 0, {1008, 1008}, {0x77, 0x00, 0x2B, 0xFF}}},
	{{{162, 69, 8}, 0, {1008, -16}, {0x77, 0x00, 0x2B, 0xFF}}},
	{{{117, 69, 132}, 0, {-16, -16}, {0x77, 0x00, 0x2B, 0xFF}}},
	{{{117, -69, 132}, 0, {-16, 1008}, {0x77, 0x00, 0x2B, 0xFF}}},
	{{{162, -69, -9}, 0, {1008, 1008}, {0x77, 0x00, 0xD5, 0xFF}}},
	{{{117, -69, -133}, 0, {-16, 1008}, {0x77, 0x00, 0xD5, 0xFF}}},
	{{{117, 69, -133}, 0, {-16, -16}, {0x77, 0x00, 0xD5, 0xFF}}},
	{{{162, 69, -9}, 0, {1008, -16}, {0x77, 0x00, 0xD5, 0xFF}}},
};

Gfx gordo_Gordo_DL_mesh_layer_4_tri_0[] = {
	gsSPVertex(gordo_Gordo_DL_mesh_layer_4_vtx_0 + 0, 8, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSP2Triangles(4, 5, 6, 0, 4, 6, 7, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Searches_Switch_Option_Searches_Body_DL_mesh_layer_4_vtx_0[4] = {
	{{{38, -38, 0}, 0, {1040, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{38, 38, 0}, 0, {1040, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{0, 38, 0}, 0, {16, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{0, -38, 0}, 0, {16, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
};

Gfx gordo_Searches_Switch_Option_Searches_Body_DL_mesh_layer_4_tri_0[] = {
	gsSPVertex(gordo_Searches_Switch_Option_Searches_Body_DL_mesh_layer_4_vtx_0 + 0, 4, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Searches_Switch_Option_Searches_Body_DL_mesh_layer_4_vtx_1[4] = {
	{{{0, -38, 0}, 0, {1008, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-38, 38, 0}, 0, {-16, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-38, -38, 0}, 0, {-16, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{0, 38, 0}, 0, {1008, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
};

Gfx gordo_Searches_Switch_Option_Searches_Body_DL_mesh_layer_4_tri_1[] = {
	gsSPVertex(gordo_Searches_Switch_Option_Searches_Body_DL_mesh_layer_4_vtx_1 + 0, 4, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 3, 1, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Searches_Switch_Option_Searches_DL_mesh_layer_1_vtx_0[36] = {
	{{{-59, 137, 0}, 0, {-16, 984}, {0x8B, 0x32, 0x00, 0xFF}}},
	{{{0, 178, -42}, 0, {496, 542}, {0x00, 0x4C, 0x9A, 0xFF}}},
	{{{0, 137, -59}, 0, {496, 984}, {0x00, 0x32, 0x8B, 0xFF}}},
	{{{-41, 178, 0}, 0, {210, 542}, {0x9A, 0x4C, 0x00, 0xFF}}},
	{{{0, 137, 59}, 0, {496, 984}, {0x00, 0x32, 0x75, 0xFF}}},
	{{{0, 178, 42}, 0, {496, 542}, {0x00, 0x4C, 0x66, 0xFF}}},
	{{{59, 137, 0}, 0, {1008, 984}, {0x75, 0x32, 0x00, 0xFF}}},
	{{{42, 178, 0}, 0, {782, 542}, {0x66, 0x4C, 0x00, 0xFF}}},
	{{{0, 202, 0}, 0, {496, -16}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-137, -59, 0}, 0, {-16, 984}, {0xCE, 0x8B, 0x00, 0xFF}}},
	{{{-178, 0, -42}, 0, {496, 542}, {0xB4, 0x00, 0x9A, 0xFF}}},
	{{{-137, 0, -59}, 0, {496, 984}, {0xCE, 0x00, 0x8B, 0xFF}}},
	{{{-178, -41, 0}, 0, {210, 542}, {0xB4, 0x9A, 0x00, 0xFF}}},
	{{{-137, 0, 59}, 0, {496, 984}, {0xCE, 0x00, 0x75, 0xFF}}},
	{{{-178, 0, 42}, 0, {496, 542}, {0xB4, 0x00, 0x66, 0xFF}}},
	{{{-137, 59, 0}, 0, {1008, 984}, {0xCE, 0x75, 0x00, 0xFF}}},
	{{{-178, 42, 0}, 0, {782, 542}, {0xB4, 0x66, 0x00, 0xFF}}},
	{{{-202, 0, 0}, 0, {496, -16}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{59, -137, 0}, 0, {-16, 984}, {0x75, 0xCE, 0x00, 0xFF}}},
	{{{0, -178, -42}, 0, {496, 542}, {0x00, 0xB4, 0x9A, 0xFF}}},
	{{{0, -137, -59}, 0, {496, 984}, {0x00, 0xCE, 0x8B, 0xFF}}},
	{{{41, -178, 0}, 0, {210, 542}, {0x66, 0xB4, 0x00, 0xFF}}},
	{{{0, -137, 59}, 0, {496, 984}, {0x00, 0xCE, 0x75, 0xFF}}},
	{{{0, -178, 42}, 0, {496, 542}, {0x00, 0xB4, 0x66, 0xFF}}},
	{{{-59, -137, 0}, 0, {1008, 984}, {0x8B, 0xCE, 0x00, 0xFF}}},
	{{{-42, -178, 0}, 0, {782, 542}, {0x9A, 0xB4, 0x00, 0xFF}}},
	{{{0, -202, 0}, 0, {496, -16}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{137, 59, 0}, 0, {-16, 984}, {0x32, 0x75, 0x00, 0xFF}}},
	{{{178, 0, -42}, 0, {496, 542}, {0x4C, 0x00, 0x9A, 0xFF}}},
	{{{137, 0, -59}, 0, {496, 984}, {0x32, 0x00, 0x8B, 0xFF}}},
	{{{178, 41, 0}, 0, {210, 542}, {0x4C, 0x66, 0x00, 0xFF}}},
	{{{137, 0, 59}, 0, {496, 984}, {0x32, 0x00, 0x75, 0xFF}}},
	{{{178, 0, 42}, 0, {496, 542}, {0x4C, 0x00, 0x66, 0xFF}}},
	{{{137, -59, 0}, 0, {1008, 984}, {0x32, 0x8B, 0x00, 0xFF}}},
	{{{178, -42, 0}, 0, {782, 542}, {0x4C, 0x9A, 0x00, 0xFF}}},
	{{{202, 0, 0}, 0, {496, -16}, {0x7F, 0x00, 0x00, 0xFF}}},
};

Gfx gordo_Searches_Switch_Option_Searches_DL_mesh_layer_1_tri_0[] = {
	gsSPVertex(gordo_Searches_Switch_Option_Searches_DL_mesh_layer_1_vtx_0 + 0, 36, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 3, 1, 0),
	gsSP2Triangles(4, 3, 0, 0, 4, 5, 3, 0),
	gsSP2Triangles(6, 5, 4, 0, 6, 7, 5, 0),
	gsSP2Triangles(2, 7, 6, 0, 2, 1, 7, 0),
	gsSP2Triangles(7, 1, 8, 0, 1, 3, 8, 0),
	gsSP2Triangles(3, 5, 8, 0, 5, 7, 8, 0),
	gsSP2Triangles(9, 10, 11, 0, 9, 12, 10, 0),
	gsSP2Triangles(13, 12, 9, 0, 13, 14, 12, 0),
	gsSP2Triangles(15, 14, 13, 0, 15, 16, 14, 0),
	gsSP2Triangles(11, 16, 15, 0, 11, 10, 16, 0),
	gsSP2Triangles(16, 10, 17, 0, 10, 12, 17, 0),
	gsSP2Triangles(12, 14, 17, 0, 14, 16, 17, 0),
	gsSP2Triangles(18, 19, 20, 0, 18, 21, 19, 0),
	gsSP2Triangles(22, 21, 18, 0, 22, 23, 21, 0),
	gsSP2Triangles(24, 23, 22, 0, 24, 25, 23, 0),
	gsSP2Triangles(20, 25, 24, 0, 20, 19, 25, 0),
	gsSP2Triangles(25, 19, 26, 0, 19, 21, 26, 0),
	gsSP2Triangles(21, 23, 26, 0, 23, 25, 26, 0),
	gsSP2Triangles(27, 28, 29, 0, 27, 30, 28, 0),
	gsSP2Triangles(31, 30, 27, 0, 31, 32, 30, 0),
	gsSP2Triangles(33, 32, 31, 0, 33, 34, 32, 0),
	gsSP2Triangles(29, 34, 33, 0, 29, 28, 34, 0),
	gsSP2Triangles(34, 28, 35, 0, 28, 30, 35, 0),
	gsSP2Triangles(30, 32, 35, 0, 32, 34, 35, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Searches_Switch_Option_Searches_DL_mesh_layer_4_vtx_0[16] = {
	{{{0, -103, 151}, 0, {496, 1008}, {0x24, 0xF1, 0x79, 0xFF}}},
	{{{108, -103, 119}, 0, {1008, 1008}, {0x24, 0xF1, 0x79, 0xFF}}},
	{{{108, 0, 132}, 0, {1008, 496}, {0x24, 0xF1, 0x79, 0xFF}}},
	{{{0, 0, 164}, 0, {496, 496}, {0x24, 0xF1, 0x79, 0xFF}}},
	{{{0, -103, 151}, 0, {496, 1008}, {0xDC, 0xF1, 0x79, 0xFF}}},
	{{{0, 0, 164}, 0, {496, 496}, {0xDC, 0xF1, 0x79, 0xFF}}},
	{{{-107, 0, 132}, 0, {-16, 496}, {0xDC, 0xF1, 0x79, 0xFF}}},
	{{{-107, -103, 119}, 0, {-16, 1008}, {0xDC, 0xF1, 0x79, 0xFF}}},
	{{{0, 0, 164}, 0, {496, 496}, {0xDC, 0x0F, 0x79, 0xFF}}},
	{{{0, 103, 151}, 0, {496, -16}, {0xDC, 0x0F, 0x79, 0xFF}}},
	{{{-107, 103, 119}, 0, {-16, -16}, {0xDC, 0x0F, 0x79, 0xFF}}},
	{{{-107, 0, 132}, 0, {-16, 496}, {0xDC, 0x0F, 0x79, 0xFF}}},
	{{{0, 0, 164}, 0, {496, 496}, {0x24, 0x0F, 0x79, 0xFF}}},
	{{{108, 103, 119}, 0, {1008, -16}, {0x24, 0x0F, 0x79, 0xFF}}},
	{{{0, 103, 151}, 0, {496, -16}, {0x24, 0x0F, 0x79, 0xFF}}},
	{{{108, 0, 132}, 0, {1008, 496}, {0x24, 0x0F, 0x79, 0xFF}}},
};

Gfx gordo_Searches_Switch_Option_Searches_DL_mesh_layer_4_tri_0[] = {
	gsSPVertex(gordo_Searches_Switch_Option_Searches_DL_mesh_layer_4_vtx_0 + 0, 16, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSP2Triangles(4, 5, 6, 0, 4, 6, 7, 0),
	gsSP2Triangles(8, 9, 10, 0, 8, 10, 11, 0),
	gsSP2Triangles(12, 13, 14, 0, 12, 15, 13, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Searches_Alt_Switch_Option_Searches_Alt_Body_DL_mesh_layer_4_vtx_0[4] = {
	{{{38, -38, 0}, 0, {1040, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{38, 38, 0}, 0, {1040, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{0, 38, 0}, 0, {16, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{0, -38, 0}, 0, {16, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
};

Gfx gordo_Searches_Alt_Switch_Option_Searches_Alt_Body_DL_mesh_layer_4_tri_0[] = {
	gsSPVertex(gordo_Searches_Alt_Switch_Option_Searches_Alt_Body_DL_mesh_layer_4_vtx_0 + 0, 4, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Searches_Alt_Switch_Option_Searches_Alt_Body_DL_mesh_layer_4_vtx_1[4] = {
	{{{0, -38, 0}, 0, {1008, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-38, 38, 0}, 0, {-16, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-38, -38, 0}, 0, {-16, 2032}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{0, 38, 0}, 0, {1008, -16}, {0x00, 0x00, 0x7F, 0xFF}}},
};

Gfx gordo_Searches_Alt_Switch_Option_Searches_Alt_Body_DL_mesh_layer_4_tri_1[] = {
	gsSPVertex(gordo_Searches_Alt_Switch_Option_Searches_Alt_Body_DL_mesh_layer_4_vtx_1 + 0, 4, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 3, 1, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_1_vtx_0[36] = {
	{{{-59, 137, 0}, 0, {-16, 984}, {0x8B, 0x32, 0x00, 0xFF}}},
	{{{0, 178, -42}, 0, {496, 542}, {0x00, 0x4C, 0x9A, 0xFF}}},
	{{{0, 137, -59}, 0, {496, 984}, {0x00, 0x32, 0x8B, 0xFF}}},
	{{{-41, 178, 0}, 0, {210, 542}, {0x9A, 0x4C, 0x00, 0xFF}}},
	{{{0, 137, 59}, 0, {496, 984}, {0x00, 0x32, 0x75, 0xFF}}},
	{{{0, 178, 42}, 0, {496, 542}, {0x00, 0x4C, 0x66, 0xFF}}},
	{{{59, 137, 0}, 0, {1008, 984}, {0x75, 0x32, 0x00, 0xFF}}},
	{{{42, 178, 0}, 0, {782, 542}, {0x66, 0x4C, 0x00, 0xFF}}},
	{{{0, 202, 0}, 0, {496, -16}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-137, -59, 0}, 0, {-16, 984}, {0xCE, 0x8B, 0x00, 0xFF}}},
	{{{-178, 0, -42}, 0, {496, 542}, {0xB4, 0x00, 0x9A, 0xFF}}},
	{{{-137, 0, -59}, 0, {496, 984}, {0xCE, 0x00, 0x8B, 0xFF}}},
	{{{-178, -41, 0}, 0, {210, 542}, {0xB4, 0x9A, 0x00, 0xFF}}},
	{{{-137, 0, 59}, 0, {496, 984}, {0xCE, 0x00, 0x75, 0xFF}}},
	{{{-178, 0, 42}, 0, {496, 542}, {0xB4, 0x00, 0x66, 0xFF}}},
	{{{-137, 59, 0}, 0, {1008, 984}, {0xCE, 0x75, 0x00, 0xFF}}},
	{{{-178, 42, 0}, 0, {782, 542}, {0xB4, 0x66, 0x00, 0xFF}}},
	{{{-202, 0, 0}, 0, {496, -16}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{59, -137, 0}, 0, {-16, 984}, {0x75, 0xCE, 0x00, 0xFF}}},
	{{{0, -178, -42}, 0, {496, 542}, {0x00, 0xB4, 0x9A, 0xFF}}},
	{{{0, -137, -59}, 0, {496, 984}, {0x00, 0xCE, 0x8B, 0xFF}}},
	{{{41, -178, 0}, 0, {210, 542}, {0x66, 0xB4, 0x00, 0xFF}}},
	{{{0, -137, 59}, 0, {496, 984}, {0x00, 0xCE, 0x75, 0xFF}}},
	{{{0, -178, 42}, 0, {496, 542}, {0x00, 0xB4, 0x66, 0xFF}}},
	{{{-59, -137, 0}, 0, {1008, 984}, {0x8B, 0xCE, 0x00, 0xFF}}},
	{{{-42, -178, 0}, 0, {782, 542}, {0x9A, 0xB4, 0x00, 0xFF}}},
	{{{0, -202, 0}, 0, {496, -16}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{137, 59, 0}, 0, {-16, 984}, {0x32, 0x75, 0x00, 0xFF}}},
	{{{178, 0, -42}, 0, {496, 542}, {0x4C, 0x00, 0x9A, 0xFF}}},
	{{{137, 0, -59}, 0, {496, 984}, {0x32, 0x00, 0x8B, 0xFF}}},
	{{{178, 41, 0}, 0, {210, 542}, {0x4C, 0x66, 0x00, 0xFF}}},
	{{{137, 0, 59}, 0, {496, 984}, {0x32, 0x00, 0x75, 0xFF}}},
	{{{178, 0, 42}, 0, {496, 542}, {0x4C, 0x00, 0x66, 0xFF}}},
	{{{137, -59, 0}, 0, {1008, 984}, {0x32, 0x8B, 0x00, 0xFF}}},
	{{{178, -42, 0}, 0, {782, 542}, {0x4C, 0x9A, 0x00, 0xFF}}},
	{{{202, 0, 0}, 0, {496, -16}, {0x7F, 0x00, 0x00, 0xFF}}},
};

Gfx gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_1_tri_0[] = {
	gsSPVertex(gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_1_vtx_0 + 0, 36, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 3, 1, 0),
	gsSP2Triangles(4, 3, 0, 0, 4, 5, 3, 0),
	gsSP2Triangles(6, 5, 4, 0, 6, 7, 5, 0),
	gsSP2Triangles(2, 7, 6, 0, 2, 1, 7, 0),
	gsSP2Triangles(7, 1, 8, 0, 1, 3, 8, 0),
	gsSP2Triangles(3, 5, 8, 0, 5, 7, 8, 0),
	gsSP2Triangles(9, 10, 11, 0, 9, 12, 10, 0),
	gsSP2Triangles(13, 12, 9, 0, 13, 14, 12, 0),
	gsSP2Triangles(15, 14, 13, 0, 15, 16, 14, 0),
	gsSP2Triangles(11, 16, 15, 0, 11, 10, 16, 0),
	gsSP2Triangles(16, 10, 17, 0, 10, 12, 17, 0),
	gsSP2Triangles(12, 14, 17, 0, 14, 16, 17, 0),
	gsSP2Triangles(18, 19, 20, 0, 18, 21, 19, 0),
	gsSP2Triangles(22, 21, 18, 0, 22, 23, 21, 0),
	gsSP2Triangles(24, 23, 22, 0, 24, 25, 23, 0),
	gsSP2Triangles(20, 25, 24, 0, 20, 19, 25, 0),
	gsSP2Triangles(25, 19, 26, 0, 19, 21, 26, 0),
	gsSP2Triangles(21, 23, 26, 0, 23, 25, 26, 0),
	gsSP2Triangles(27, 28, 29, 0, 27, 30, 28, 0),
	gsSP2Triangles(31, 30, 27, 0, 31, 32, 30, 0),
	gsSP2Triangles(33, 32, 31, 0, 33, 34, 32, 0),
	gsSP2Triangles(29, 34, 33, 0, 29, 28, 34, 0),
	gsSP2Triangles(34, 28, 35, 0, 28, 30, 35, 0),
	gsSP2Triangles(30, 32, 35, 0, 32, 34, 35, 0),
	gsSPEndDisplayList(),
};

Vtx gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_4_vtx_0[16] = {
	{{{0, -103, 151}, 0, {496, 1008}, {0x24, 0xF1, 0x79, 0xFF}}},
	{{{108, -103, 119}, 0, {1008, 1008}, {0x24, 0xF1, 0x79, 0xFF}}},
	{{{108, 0, 132}, 0, {1008, 496}, {0x24, 0xF1, 0x79, 0xFF}}},
	{{{0, 0, 164}, 0, {496, 496}, {0x24, 0xF1, 0x79, 0xFF}}},
	{{{0, -103, 151}, 0, {496, 1008}, {0xDC, 0xF1, 0x79, 0xFF}}},
	{{{0, 0, 164}, 0, {496, 496}, {0xDC, 0xF1, 0x79, 0xFF}}},
	{{{-107, 0, 132}, 0, {-16, 496}, {0xDC, 0xF1, 0x79, 0xFF}}},
	{{{-107, -103, 119}, 0, {-16, 1008}, {0xDC, 0xF1, 0x79, 0xFF}}},
	{{{0, 0, 164}, 0, {496, 496}, {0xDC, 0x0F, 0x79, 0xFF}}},
	{{{0, 103, 151}, 0, {496, -16}, {0xDC, 0x0F, 0x79, 0xFF}}},
	{{{-107, 103, 119}, 0, {-16, -16}, {0xDC, 0x0F, 0x79, 0xFF}}},
	{{{-107, 0, 132}, 0, {-16, 496}, {0xDC, 0x0F, 0x79, 0xFF}}},
	{{{0, 0, 164}, 0, {496, 496}, {0x24, 0x0F, 0x79, 0xFF}}},
	{{{108, 103, 119}, 0, {1008, -16}, {0x24, 0x0F, 0x79, 0xFF}}},
	{{{0, 103, 151}, 0, {496, -16}, {0x24, 0x0F, 0x79, 0xFF}}},
	{{{108, 0, 132}, 0, {1008, 496}, {0x24, 0x0F, 0x79, 0xFF}}},
};

Gfx gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_4_tri_0[] = {
	gsSPVertex(gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_4_vtx_0 + 0, 16, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSP2Triangles(4, 5, 6, 0, 4, 6, 7, 0),
	gsSP2Triangles(8, 9, 10, 0, 8, 10, 11, 0),
	gsSP2Triangles(12, 13, 14, 0, 12, 15, 13, 0),
	gsSPEndDisplayList(),
};


Gfx mat_gordo_Gordo_Right[] = {
	gsSPClearGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, gordo_bomb_right_side_rgba16_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 75),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_bomb_right_side_rgba16_ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 6, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 252),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Gordo_Right[] = {
	gsSPSetGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Gordo_Left[] = {
	gsSPClearGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, gordo_bomb_left_side_rgba16_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 43),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_bomb_left_side_rgba16_ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 6, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 252),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Gordo_Left[] = {
	gsSPSetGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Gordo_Spikes[] = {
	gsSPSetLights1(gordo_Gordo_Spikes_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT, TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, gordo_bomb_spike_rgba16_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 36),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_bomb_spike_rgba16_ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 511, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Gordo_Spikes[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Gordo_Eye[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, gordo_Gordo_Eye_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 54),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_Gordo_Eye_ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 511, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Gordo_Eye[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Searches_Right[] = {
	gsSPClearGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_IA, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_bob_omb_right_side_rgba16_ia8),
	gsDPSetTile(G_IM_FMT_IA, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 512),
	gsDPSetTile(G_IM_FMT_IA, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 6, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 252),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Searches_Right[] = {
	gsSPSetGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Searches_Left[] = {
	gsSPClearGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_IA, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_bob_omb_left_side_rgba16_ia8),
	gsDPSetTile(G_IM_FMT_IA, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 512),
	gsDPSetTile(G_IM_FMT_IA, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 6, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 252),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Searches_Left[] = {
	gsSPSetGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Searches_Lights[] = {
	gsSPSetLights1(gordo_Searches_Lights_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Searches_Lights[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Searches_Face[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, gordo_Searches_Face_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 54),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_Searches_Face_ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 511, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Searches_Face[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Searches_Right__Explode_[] = {
	gsSPClearGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, gordo_Searches_Right__Explode__pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 37),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_Searches_Right__Explode__ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 6, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 252),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Searches_Right__Explode_[] = {
	gsSPSetGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Searches_Left__Explode_[] = {
	gsSPClearGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, gordo_Searches_Left__Explode__pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 24),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_Searches_Left__Explode__ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 6, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 252),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Searches_Left__Explode_[] = {
	gsSPSetGeometryMode(G_CULL_BACK),
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Searches_Lights__Explode_[] = {
	gsSPSetLights1(gordo_Searches_Lights__Explode__lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Searches_Lights__Explode_[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx mat_gordo_Searches_Face__Explode_[] = {
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsDPSetTextureLUT(G_TT_RGBA16),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, gordo_Searches_Face_Explode_pal_rgba16),
	gsDPSetTile(0, 0, 0, 256, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadTLUTCmd(5, 57),
	gsDPSetTextureImage(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 1, gordo_Searches_Face_Explode_ci8),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 511, 512),
	gsDPSetTile(G_IM_FMT_CI, G_IM_SIZ_8b, 4, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_gordo_Searches_Face__Explode_[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsDPSetTextureLUT(G_TT_NONE),
	gsSPEndDisplayList(),
};

Gfx gordo_Gordo_Body_DL_mesh_layer_4[] = {
	gsSPDisplayList(mat_gordo_Gordo_Right),
	gsSPDisplayList(gordo_Gordo_Body_DL_mesh_layer_4_tri_0),
	gsSPDisplayList(mat_revert_gordo_Gordo_Right),
	gsSPDisplayList(mat_gordo_Gordo_Left),
	gsSPDisplayList(gordo_Gordo_Body_DL_mesh_layer_4_tri_1),
	gsSPDisplayList(mat_revert_gordo_Gordo_Left),
	gsSPEndDisplayList(),
};

Gfx gordo_Gordo_DL_mesh_layer_1[] = {
	gsSPDisplayList(mat_gordo_Gordo_Spikes),
	gsSPDisplayList(gordo_Gordo_DL_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_gordo_Gordo_Spikes),
	gsSPEndDisplayList(),
};

Gfx gordo_Gordo_DL_mesh_layer_4[] = {
	gsSPDisplayList(mat_gordo_Gordo_Eye),
	gsSPDisplayList(gordo_Gordo_DL_mesh_layer_4_tri_0),
	gsSPDisplayList(mat_revert_gordo_Gordo_Eye),
	gsSPEndDisplayList(),
};

Gfx gordo_Searches_Switch_Option_Searches_Body_DL_mesh_layer_4[] = {
	gsSPDisplayList(mat_gordo_Searches_Right),
	gsSPDisplayList(gordo_Searches_Switch_Option_Searches_Body_DL_mesh_layer_4_tri_0),
	gsSPDisplayList(mat_revert_gordo_Searches_Right),
	gsSPDisplayList(mat_gordo_Searches_Left),
	gsSPDisplayList(gordo_Searches_Switch_Option_Searches_Body_DL_mesh_layer_4_tri_1),
	gsSPDisplayList(mat_revert_gordo_Searches_Left),
	gsSPEndDisplayList(),
};

Gfx gordo_Searches_Switch_Option_Searches_DL_mesh_layer_1[] = {
	gsSPDisplayList(mat_gordo_Searches_Lights),
	gsSPDisplayList(gordo_Searches_Switch_Option_Searches_DL_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_gordo_Searches_Lights),
	gsSPEndDisplayList(),
};

Gfx gordo_Searches_Switch_Option_Searches_DL_mesh_layer_4[] = {
	gsSPDisplayList(mat_gordo_Searches_Face),
	gsSPDisplayList(gordo_Searches_Switch_Option_Searches_DL_mesh_layer_4_tri_0),
	gsSPDisplayList(mat_revert_gordo_Searches_Face),
	gsSPEndDisplayList(),
};

Gfx gordo_Searches_Alt_Switch_Option_Searches_Alt_Body_DL_mesh_layer_4[] = {
	gsSPDisplayList(mat_gordo_Searches_Right__Explode_),
	gsSPDisplayList(gordo_Searches_Alt_Switch_Option_Searches_Alt_Body_DL_mesh_layer_4_tri_0),
	gsSPDisplayList(mat_revert_gordo_Searches_Right__Explode_),
	gsSPDisplayList(mat_gordo_Searches_Left__Explode_),
	gsSPDisplayList(gordo_Searches_Alt_Switch_Option_Searches_Alt_Body_DL_mesh_layer_4_tri_1),
	gsSPDisplayList(mat_revert_gordo_Searches_Left__Explode_),
	gsSPEndDisplayList(),
};

Gfx gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_1[] = {
	gsSPDisplayList(mat_gordo_Searches_Lights__Explode_),
	gsSPDisplayList(gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_gordo_Searches_Lights__Explode_),
	gsSPEndDisplayList(),
};

Gfx gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_4[] = {
	gsSPDisplayList(mat_gordo_Searches_Face__Explode_),
	gsSPDisplayList(gordo_Searches_Alt_Switch_Option_Searches_Alt_DL_mesh_layer_4_tri_0),
	gsSPDisplayList(mat_revert_gordo_Searches_Face__Explode_),
	gsSPEndDisplayList(),
};

Gfx gordo_material_revert_render_settings[] = {
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

