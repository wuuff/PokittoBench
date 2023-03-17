#include "Pokitto.h"
#include "PokittoCore.h"
#include "PokittoPalettes.h"

const uint8_t pokitto8x8_4bpp[] = {
8,8,
0x00,0xBB,0xBB,0x00,
0x0B,0x22,0x22,0xB0,
0x0B,0x22,0x22,0xB0,
0xBB,0x22,0x22,0xBB,
0x0B,0xFA,0xBF,0xB0,
0x0B,0xAF,0xFB,0xB0,
0x0B,0xBB,0xBB,0xB0,
0x0B,0x00,0x00,0xB0,
};

const uint8_t pokitto16x16_4bpp[] = {
16,16,
0x00,0x0E,0xEE,0xEE,0xEE,0xEE,0xE0,0x00,
0x00,0xEB,0xBB,0xBB,0xBB,0xBB,0xB5,0x00,
0x00,0xEB,0x22,0x22,0x22,0x22,0xB5,0x00,
0x00,0xEB,0x2D,0x22,0x22,0xD2,0xB5,0x00,
0x00,0xEB,0x22,0x22,0x22,0x22,0xB5,0x00,
0x0E,0xEB,0x22,0xD2,0x2D,0x22,0xBB,0xB0,
0x05,0xEB,0x22,0x2D,0xD2,0x22,0xB5,0x50,
0x00,0xEB,0x22,0x22,0x22,0x22,0xB5,0x00,
0x00,0xEB,0xBB,0xBB,0xBB,0xBB,0xB5,0x00,
0x00,0xEB,0xBF,0xBB,0xBB,0xBF,0xB5,0x00,
0x00,0xEB,0xFF,0xFB,0xBF,0xBB,0xB5,0x00,
0x00,0xEB,0xBF,0xBB,0xBB,0xBB,0xB5,0x00,
0x00,0xEB,0xBB,0xBF,0xFB,0xBB,0xB5,0x00,
0x00,0xEB,0xBB,0xBB,0xBB,0xBB,0xB5,0x00,
0x00,0xE5,0x55,0x55,0x55,0x55,0xB5,0x00,
0x00,0xE5,0x00,0x00,0x00,0x00,0xB5,0x00,
};

Pokitto::Core pokitto;

#define ENTITY_RECT8 0
#define ENTITY_RECT16 1
#define ENTITY_BITMAP8 2
#define ENTITY_BITMAP16 3

#define BENCHMARK_RECT8 0
#define BENCHMARK_RECT16 1
#define BENCHMARK_CIRCLE8 2
#define BENCHMARK_CIRCLE16 3
#define BENCHMARK_BITMAP8 4
#define BENCHMARK_BITMAP16 5
#define BENCHMARK_TEXT 6

typedef struct entity{
  uint16_t x;
  uint16_t y;
  uint8_t color;
} entity;

#define MAX_ENTITIES 1000
uint16_t num_entities = 0;
uint16_t prev_num_entities = 0;
uint16_t num_unchanged_frames = 0;
uint8_t target_walkback = 0;
uint32_t last_time = 0;
entity entities[MAX_ENTITIES];

#define NUM_BENCHMARKS 7
#define BENCHMARK_RESULTS NUM_BENCHMARKS
uint16_t benchmark_results[NUM_BENCHMARKS];
const char benchmark_names[NUM_BENCHMARKS][16] = {
  "8x8 Rects",
  "16x16 Rects",
  "8x8 Circles",
  "16x16 Circles",
  "8x8 Bitmaps",
  "16x16 Bitmaps",
  "5x7 Characters",
};
const uint8_t benchmark_sizes[NUM_BENCHMARKS] = {
  8,
  16,
  4,
  8,
  8,
  16,
  8
};
const uint16_t benchmark_thresholds[NUM_BENCHMARKS] = {
  45-10,
  65-20,
  45-10,
  65-20,
  45-10,
  65-20,
  45-10,
};
uint8_t current_benchmark;
uint16_t benchmark_counter;
uint16_t benchmark_frameCount;
uint16_t benchmark_fps;
uint32_t benchmark_nextRefresh;
#define BENCHMARK_FPS_REFRESH 500

void benchmark_reset(){
  num_entities = 0;
  prev_num_entities = 0;
  num_unchanged_frames = 0;
  benchmark_counter = 0;
  target_walkback = 0;
  benchmark_frameCount = 0;
  benchmark_nextRefresh = pokitto.getTime();
}

void benchmark_step(uint8_t entity_width, uint16_t slowdown_threshold){
  benchmark_frameCount++;
  uint32_t now = pokitto.getTime();
  if( now > benchmark_nextRefresh ){
    benchmark_fps = (1000*benchmark_frameCount) / (now-benchmark_nextRefresh+BENCHMARK_FPS_REFRESH);
    benchmark_nextRefresh = now + BENCHMARK_FPS_REFRESH;
    benchmark_frameCount = 0;
  }
  /* Wait to measure fps until after first 300 steps in benchmark showing benchmark name */
  if( benchmark_counter < 300 ){
    return;
  }
  if( target_walkback == 0 && benchmark_fps < 30 ){
    /* Start slowly walking back placed entities once fps drops below 30 */
    target_walkback = 1;
    /* Place entities every N seconds */
    last_time = pokitto.getTime();
  }
  if( target_walkback ){
    /* Record number of entities while trying to increase their number to just barely meet 30 fps */
    benchmark_results[current_benchmark] = num_entities;
    if( benchmark_fps < 30 && pokitto.getTime()-last_time > BENCHMARK_FPS_REFRESH*2 ){
      num_entities--;
      last_time = pokitto.getTime();
    } 
    return;
  }
  /* If fps is above 30, keep adding entities (but more slowly as we approach 30 fps) */
  if( num_entities < MAX_ENTITIES &&
      ((benchmark_fps >= slowdown_threshold /*&& benchmark_counter%2 == 0*/) ||
       (benchmark_counter % (slowdown_threshold-benchmark_fps)) == 0) ){
    entities[num_entities].x = random()%(LCDWIDTH-entity_width);
    entities[num_entities].y = random()%(LCDHEIGHT-entity_width);
    entities[num_entities].color = random()%15+1;
    num_entities++;
  }
}

void benchmark_rect8_step(){
  /* Wait to measure fps until after first 100 steps in benchmark showing benchmark name */
  if( benchmark_counter < 100 ){
    return;
  }
  if( pokitto.fps_counter < 30 ){
    /* Record number of entities when fps drops below 30 */
    benchmark_results[current_benchmark] = num_entities;
    return;
  }
  /* If fps is above 30, keep adding entities (but more slowly as we approach 30 fps) */
  if( num_entities < MAX_ENTITIES && (pokitto.fps_counter > 40 || (benchmark_counter % (40-pokitto.fps_counter)) == 0) ){
    entities[num_entities].x = random()%(LCDWIDTH-8);
    entities[num_entities].y = random()%(LCDHEIGHT-8);
    entities[num_entities].color = random()%15+1;
    num_entities++;
  }
}

void benchmark_rect16_step(){
  /* Wait to measure fps until after first 100 steps in benchmark showing benchmark name */
  if( benchmark_counter < 100 ){
    return;
  }
  if( pokitto.fps_counter < 30 ){
    /* Record number of entities when fps drops below 30 */
    benchmark_results[current_benchmark] = num_entities;
    return;
  }
  /* If fps is above 30, keep adding entities (but more slowly as we approach 30 fps) */
  if( num_entities < MAX_ENTITIES && (pokitto.fps_counter > 60 || (benchmark_counter % ((60-pokitto.fps_counter)*2)) == 0) ){
    entities[num_entities].x = random()%(LCDWIDTH-16);
    entities[num_entities].y = random()%(LCDHEIGHT-16);
    entities[num_entities].color = random()%15+1;
    num_entities++;
  }
}

void benchmark_bitmap8_step(){
  /* Wait to measure fps until after first 100 steps in benchmark showing benchmark name */
  if( benchmark_counter < 100 ){
    return;
  }
  if( pokitto.fps_counter < 30 ){
    /* Record number of entities when fps drops below 30 */
    benchmark_results[current_benchmark] = num_entities;
    return;
  }
  /* If fps is above 30, keep adding entities (but more slowly as we approach 30 fps) */
  if( num_entities < MAX_ENTITIES && (pokitto.fps_counter > 40 || (benchmark_counter % (40-pokitto.fps_counter)) == 0) ){
    entities[num_entities].x = random()%(LCDWIDTH-8);
    entities[num_entities].y = random()%(LCDHEIGHT-8);
    num_entities++;
  }
}

void benchmark_bitmap16_step(){
  /* Wait to measure fps until after first 100 steps in benchmark showing benchmark name */
  if( benchmark_counter < 100 ){
    return;
  }
  if( pokitto.fps_counter < 30 ){
    /* Record number of entities when fps drops below 30 */
    benchmark_results[current_benchmark] = num_entities;
    return;
  }
  /* If fps is above 30, keep adding entities (but more slowly as we approach 30 fps) */
  if( num_entities < MAX_ENTITIES && (pokitto.fps_counter > 60 || (benchmark_counter % ((60-pokitto.fps_counter)*2)) == 0) ){
    entities[num_entities].x = random()%(LCDWIDTH-16);
    entities[num_entities].y = random()%(LCDHEIGHT-16);
    num_entities++;
  }
}

void benchmark_results_step(){
  char num_buf[4];
  pokitto.display.setColor(15);
  pokitto.display.setCursor(LCDWIDTH/2-21,0);
  pokitto.display.print("RESULTS");
  for( uint8_t i = 0; i < NUM_BENCHMARKS; i++ ){
    sprintf(num_buf,"%d",benchmark_results[i]);
    pokitto.display.setCursor(LCDWIDTH/2-(strlen(num_buf)+strlen(benchmark_names[i])+1)*6/2,16+i*8);
    pokitto.display.print(benchmark_names[i]);
    pokitto.display.print(":");
    pokitto.display.print(num_buf);
  }
}

void draw(){
  if( current_benchmark < NUM_BENCHMARKS && num_entities == 0 ){
    pokitto.display.setColor(15);
    pokitto.display.setCursor(LCDWIDTH/2-strlen(benchmark_names[current_benchmark])*6/2,LCDHEIGHT/2-4);
    pokitto.display.print(benchmark_names[current_benchmark]);
    return;
  }
  for( uint16_t i = 0; i < num_entities; i++ ){
    switch( current_benchmark ){
      case BENCHMARK_RECT8:
        pokitto.display.setColor(entities[i].color);
        pokitto.display.fillRectangle(entities[i].x,entities[i].y,8,8);
        break;
      case BENCHMARK_RECT16:
        pokitto.display.setColor(entities[i].color);
        pokitto.display.fillRectangle(entities[i].x,entities[i].y,16,16);
        break;
      case BENCHMARK_CIRCLE8:
        pokitto.display.setColor(entities[i].color);
        pokitto.display.fillCircle(entities[i].x,entities[i].y,4);
        break;
      case BENCHMARK_CIRCLE16:
        pokitto.display.setColor(entities[i].color);
        pokitto.display.fillCircle(entities[i].x,entities[i].y,8);
        break;
      case BENCHMARK_BITMAP8:
        pokitto.display.drawBitmap(entities[i].x,entities[i].y,pokitto8x8_4bpp,0);
        break;
      case BENCHMARK_BITMAP16:
        pokitto.display.drawBitmap(entities[i].x,entities[i].y,pokitto16x16_4bpp,0);
        break;
      case BENCHMARK_TEXT:
        char text_buf[] = "A";
        pokitto.display.setColor(entities[i].color);
        pokitto.display.setCursor(entities[i].x,entities[i].y);
        text_buf[0] = 'A'+i%26;
        pokitto.display.print(text_buf);
        break;
    }
  }
}

void init(){
  pokitto.begin();
  pokitto.display.loadRGBPalette(paletteDB16);
  pokitto.display.setFont(font5x7);
  pokitto.setFrameRate(255);
  pokitto.display.setInvisibleColor(0);
  benchmark_reset();
  current_benchmark = BENCHMARK_RECT8;
  while( !pokitto.update() );
}

void loop(){
  if( pokitto.update() ){
    benchmark_counter++;
    switch( current_benchmark ){
      /*case BENCHMARK_RECT8:
        benchmark_step(ENTITY_RECT8, 8, 40);
        if( num_unchanged_frames > 300 ){
          benchmark_reset();
          current_benchmark = BENCHMARK_RECT16;
        }
        break;
      case BENCHMARK_RECT16:
        benchmark_step(ENTITY_RECT16, 16, 60);
        if( num_unchanged_frames > 300 ){
          benchmark_reset();
          current_benchmark = BENCHMARK_BITMAP8;
        }
        break;
      case BENCHMARK_BITMAP8:
        benchmark_step(ENTITY_BITMAP8, 8, 35);
        if( num_unchanged_frames > 300 ){
          benchmark_reset();
          current_benchmark = BENCHMARK_BITMAP16;
        }
        break;
      case BENCHMARK_BITMAP16:
        benchmark_step(ENTITY_BITMAP16, 16, 50);
        if( num_unchanged_frames > 300 ){
          benchmark_reset();
          current_benchmark = BENCHMARK_RESULTS;
        }
        break;*/
      case BENCHMARK_RESULTS:
        benchmark_results_step();
        if( pokitto.buttons.pressed(BTN_A) ){
          benchmark_reset();
          current_benchmark = BENCHMARK_RECT8;
        }
        break;
      default:
        benchmark_step(benchmark_sizes[current_benchmark], benchmark_thresholds[current_benchmark]);
        if( num_unchanged_frames > 150 ){
          benchmark_reset();
          current_benchmark++;
        }
        break;
    }
    /* Keep track of whether benchmark has reached steady state */
    if( benchmark_counter > 400 && num_entities == prev_num_entities ){
      num_unchanged_frames++;
    }else{
      prev_num_entities = num_entities;
      num_unchanged_frames = 0;
    }
    draw();
  }
}

int main(){
  init();
  while( true ){
    loop();
  }
  return 0;
}
