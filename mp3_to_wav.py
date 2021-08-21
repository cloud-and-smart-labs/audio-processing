from pydub import AudioSegment
sound = AudioSegment.from_mp3('./water.mp3')
sound.export('./water_.wav', format='wav')
