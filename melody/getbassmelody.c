#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <fftw3.h>

unsigned char header[44];
int size;
unsigned char *raw;
double *data;
double *in;
fftw_complex *out;
fftw_plan plan;

int sample_rate = 44100;
int segment_len = 16384;
int segment_count;
int min_note = 28; // 31;
int max_note = 45; // 83
int real_min_note = 28; //31;
int real_max_note = 50; // 90

char name[12][4] = {"c", "cis", "d", "es", "e", "f", "fis", "g", "as", "a", "b", "h"};

#define SEG_MAX 8000
#define NOTE_MAX 150
double freq[SEG_MAX][NOTE_MAX];
double rowmax[NOTE_MAX];
double colmax[SEG_MAX];
int result[SEG_MAX];

double value[SEG_MAX][NOTE_MAX];

int mode = 2;

double alpha = 4;
int emax = 35;
double beta = 1.5;
double gamma = 0.1;

int abs(int n) {
    if (n < 0) return -n;
    else return n;
}

double min(double a, double b) {
    return (a < b) ? a : b;
}

int get_note(int frequency) {
    return (int)(log(frequency/27.5)/((1/12.0)*log(2))+0.5)+9;
}

int get_freq(int note) {
    return (int)(27.5*pow(pow(2, 1.0/12), note-9));
}

char* get_name(int note) {
    return name[note%12];
}

void calc_value(int pos) {
    double fr[100000];
    int first = pos*segment_len;
    int len = segment_len;
    
    memcpy(in, &data[first], sizeof(double)*len);
    for (int i = 0; i < len; i++) {
        in[i] *= 1.0*(1-cos(2*3.14159*i/(len-1)));
    }
    plan = fftw_plan_dft_r2c_1d(len, in, out, FFTW_ESTIMATE);
    fftw_execute(plan);
    
    for (int i = 0; i < len/2; i++) {
        double x = sqrt(out[i][0]*out[i][0]+out[i][1]*out[i][1]);
        double y = sqrt(out[i+1][0]*out[i+1][0]+out[i+1][1]*out[i+1][1]);
        int a = i*sample_rate/len;
        int b = (i+1)*sample_rate/len;
        int p = b-a;
        for (int j = a; j < b; j++) {
            double v = x*(double)(b-j)/p+y*(double)(j-a)/p;
            fr[j] = v;
        }
    }
    for (int i = real_min_note; i <= real_max_note; i++) {
        double f = fr[get_freq(i)];
        if (rowmax[i] < f) rowmax[i] = f;
        if (colmax[pos] < f) colmax[pos] = f;
        freq[pos][i] = f;
    }
}

void strong_melody(void) {
    for (int i = 0; i < segment_count; i++) {
        for (int j = min_note; j <= max_note; j++) {
            value[i][j] = 1.0*freq[i][j]/colmax[i];
            value[i][j] += 1.0/2*freq[i][j+12]/colmax[i];
            value[i][j] += 1.0/3*freq[i][j+12+7]/colmax[i];
        }
    }
}

void high_melody(void) {
    for (int i = 0; i < segment_count; i++) {
        for (int j = min_note; j <= max_note; j++) {
            value[i][j] = 0;
        }
        double counter = 0;
        int firstpeak = 0;
        for (int j = real_max_note; j >= min_note; j--) {
            double own = 1.0*freq[i][j]/colmax[i];
            if (own > gamma && firstpeak == 0) firstpeak = j;
            value[i][j] += own;
            value[i][j-12] += own;
            value[i][j-7-12] += own;
            counter += own;
            if (counter > beta) break;
            if (firstpeak-j >= 12) break;
        }
    }
}

void tutti_melody(void) {
    for (int i = 0; i < segment_count; i++) {
        double ncounter[12] = {0};
        for (int j = min_note; j <= max_note; j++) {
            value[i][j] = 0;
            ncounter[j%12] += freq[i][j]/colmax[i];
            ncounter[j%12] += freq[i][j+12]/colmax[i]/2;
            ncounter[j%12] += freq[i][j+12+7]/colmax[i]/3;
        }
        double counter = 0;
        int firstpeak = 0;
        for (int j = real_max_note; j >= min_note; j--) {
            double own = 1.0*freq[i][j]/colmax[i];
            if (own > gamma && firstpeak == 0) firstpeak = j;
            value[i][j] += own;
            value[i][j-12] += own;
            value[i][j-7-12] += own;
            counter += own;
            if (counter > beta) break;
            if (firstpeak-j >= 12) break;
        }
        for (int j = min_note; j <= max_note; j++) {
            value[i][j] *= ncounter[j%12];
        }
    }
}

#define CHG_MAX 100

double maxval[SEG_MAX][NOTE_MAX][CHG_MAX+1];
int prev[SEG_MAX][NOTE_MAX][CHG_MAX+1];
int pchg[SEG_MAX][NOTE_MAX][CHG_MAX+1];

int m_a = 12;
int m_b = 4;

void track_melody(void) {
    for (int j = min_note; j <= max_note; j++) {
        for (int c = 0; c <= emax; c++) {
            maxval[0][j][c] = value[0][j];
        }
    }
    int last;
    for (int i = 1; i < segment_count; i++) {
        last = min_note;	
        for (int j = min_note; j <= max_note; j++) {
            for (int c = 0; c <= emax; c++) {
                double bestval = 0;
                int bestprev = 0;
                int bestchg = 0;
                for (int k = min_note; k <= max_note; k++) {
                    int chg = (int)(abs(k-j)*alpha); //4
                    if (chg > c) continue;
                    int nchg = c-chg+1;
                    if (nchg > emax) nchg = emax;
                    double cost = 0;
                    double newval = maxval[i-1][k][nchg]+value[i][j]+cost;
                    if (newval > bestval) {
                        bestval = newval;
                        bestprev = k;
                        bestchg = nchg;
                    }
                }
                maxval[i][j][c] = bestval;
                prev[i][j][c] = bestprev;
                pchg[i][j][c] = bestchg;
                if (maxval[i][j][c] > maxval[i][last][c]) last = j;            
            }
        }
    }
    int pos = segment_count-1;    
    int note = last;    
    int chg = emax;
    while (pos >= 0) {
    //  printf("%i\n",note); // FIX
        result[pos] = note;
        int tmp = note;
        note = prev[pos][tmp][chg];
        chg = pchg[pos][tmp][chg];
        pos--;
    }
}

double analysis(char* name) {
    char buffer[100];
    sprintf(buffer, "%s", name);

    FILE *file = fopen(buffer, "r");
    if (fread(header, 1, 44, file));
    size = (header[4]+(header[5]<<8)+(header[6]<<16)+(header[7]<<24))/2;    
    raw = (char*)malloc(2*size);
    if (fread(raw, 2, size, file));
    fclose(file);
    
    data = (double*)fftw_malloc(sizeof(double)*size);    
    for (int i = 0; i < size; i++) {
        data[i] = raw[2*i]+(raw[2*i+1]<<8);
        if (data[i] > 32767) data[i] -= 65536;
    }

    in = (double*)fftw_malloc(sizeof(double)*size);
    out = (fftw_complex*)fftw_malloc(sizeof(fftw_complex)*size);

    segment_count = size/segment_len;
    for (int i = 0; i < segment_count; i++) {
       colmax[i] = 0.00001;
       for (int j = min_note; j <= max_note; j++) {
           rowmax[j] = 0.00001;
           value[i][j] = 0;
       }      
    }    
    
    for (int i = 0; i < segment_count; i++) {
        calc_value(i);
    }
    
    free(raw);
    fftw_free(data);
    fftw_free(in);
    fftw_free(out);
    
    if (mode == 1) strong_melody();
    if (mode == 2) high_melody();
    if (mode == 3) tutti_melody();

    track_melody();
    
    for (int i = 0; i < segment_count; i++) {
        //printf("%lf,%i\n", 1.0*i*segment_len/sample_rate, result[i]);
        printf("%i\n", result[i]);
    }
}

int main(int argc, char **argv) {
    if (argc >= 3) {
      sscanf(argv[2], "%i", &mode);
    }
    if (argc > 3) {
      sscanf(argv[3], "%lf", &alpha);
      sscanf(argv[4], "%i", &emax);
      sscanf(argv[5], "%lf", &beta);
      sscanf(argv[6], "%lf", &gamma);
    }
    analysis(argv[1]);
    return 0;
}
