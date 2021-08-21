#library(readr)
#install.packages('tuneR')
#library(tuneR)
#audio = readWave('C:/Users/ADMIN/Desktop/smart-farming/cricket_.wav')
#str(audio)
#len_of_audio <- 4932911/audio@samp.rate

#s1 <- audio@left/2^(audio@bit - 1)
#time_array <- (0 : (4932911 - 1))/audio@samp.rate
#plot(time_array, s1, type='l', col='black', xlab='Time(ms)', ylab='Amplitude')

install.packages('sound', dep=TRUE)
library(sound)

audio_fc <- loadSample('./cricket_.wav')
audio_fw <- loadSample('./water_.wav')
fs_cricket <- rate(audio_fc)
fs_water <- rate(audio_fw)
#n_bits <- bits(audio_fw)
cricket <- sound(audio_fc)
water <- sound(audio_fw)

dim(water)
dim(cricket)

s_water <- water[1, ]
s_cricket <- cricket[1, ]
s_cricket <- s_cricket[1:(dim(water)[2])]
length(s_water)

n <- length(s_water)
n_uniqPts <- ceiling((n + 1)/2)


time_a <- (0 : (length(s_water) - 1))/fs_water

par(mfrow=c(2, 2), col.axis="black")


### Adding White Noise
noise = rnorm(n, mean=0, sd=0.2)
cricket_water_noise = s_cricket + s_water + noise
plot(time_a, cricket_water_noise, main='Noisy Signal', type='l', col='black', xlab='Time', ylab='Amplitude')


freq_a <- (0:(n_uniqPts-1)) * (fs_water/n)

### Fourier Transform of the noisy signal
fft_cwn_ <- fft(cricket_water_noise)
fft_cwn <- fft_cwn_[1:n_uniqPts]
fft_cwn <- abs(fft_cwn)
plot(freq_a/1000, fft_cwn, main='FFT of Noisy Signal', type='l', col='blue', xlab='Frequency (kHz)', ylab='Amplitude')


### Filtering out with frequencies
fft_cwn_[abs(freq_a) < 4500] <- 0
fft_cwn_[abs(freq_a) > 5500] <- 0
ifft_cwn = fft(fft_cwn_, inverse=TRUE)/n
plot(time_a, ifft_cwn, main='Filtered Signal', type='l', col='red', xlab='Time', ylab='Amplitude')



































